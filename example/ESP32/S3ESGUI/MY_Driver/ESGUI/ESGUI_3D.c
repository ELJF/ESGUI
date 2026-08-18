//
// Created by E_LJF on 2026/8/15.
// 3D 线框渲染：定点透视投影 + 模型变换（零浮点）
//

#include "ESGUI_3D.h"
#include "stdint.h"

#if ESGUI_ENABLE_3D


/* ========== 3D 线框图（定点透视投影，零浮点） ========== */

/* 透视投影的定点小数位数：投影结果保留 16 位小数精度后再取整 */
#define ESGUI_3D_FP_BITS 16

/**
 * @brief  单轴透视投影（定点）
 * @param  coord  顶点坐标分量（X 或 Z，即水平或垂直）
 * @param  focal  透视焦距（像素，正整数）
 * @param  depth  顶点深度（必须 > 0，位于相机前方）
 * @return 投影后的定点值（低 ESGUI_3D_FP_BITS 位为小数），
 *         调用方需右移 ESGUI_3D_FP_BITS 位得到像素坐标
 * @note   中间量用 int64 防溢出；focal < 65536 时任意 int32 坐标均不溢出
 */
static eui_int32_t _esgui_3d_project(eui_int32_t coord, eui_int32_t focal, eui_int32_t depth)
{
    int64_t num = ((int64_t)coord * focal) << ESGUI_3D_FP_BITS;
    return (eui_int32_t)(num / depth);
}

/* ==================== 3D 变换（模型局部坐标 → 世界坐标） ==================== */

/* Q15 定点正弦表：sin(i°)×32768，i = 0..90 */
static const int16_t _esgui_3d_sin90[91] = {
      0,   572,  1144,  1715,  2286,  2856,  3425,  3993,
   4560,  5126,  5690,  6252,  6813,  7371,  7927,  8481,
   9032,  9580, 10126, 10668, 11207, 11743, 12275, 12803,
  13328, 13848, 14365, 14876, 15384, 15886, 16384, 16876,
  17364, 17847, 18324, 18795, 19261, 19720, 20174, 20621,
  21063, 21498, 21926, 22348, 22762, 23170, 23571, 23965,
  24351, 24730, 25101, 25466, 25822, 26170, 26510, 26842,
  27166, 27482, 27789, 28087, 28378, 28660, 28932, 29196,
  29452, 29698, 29935, 30163, 30382, 30592, 30791, 30982,
  31164, 31336, 31499, 31651, 31794, 31928, 32051, 32165,
  32270, 32365, 32449, 32524, 32588, 32643, 32688, 32723,
  32748, 32763, 32767
};

/**
 * @brief  定点正弦（Q15）
 * @param  deg  角度（度，支持任意整数与负角度）
 * @return sin(deg)×32768，范围 [-32767, 32767]
 */
static eui_int32_t _esgui_3d_sin(eui_int32_t deg)
{
    deg %= 360;
    if (deg < 0) deg += 360;
    if (deg <= 90)  return  _esgui_3d_sin90[deg];
    if (deg <= 180) return  _esgui_3d_sin90[180 - deg];
    if (deg <= 270) return -_esgui_3d_sin90[deg - 180];
    return -_esgui_3d_sin90[360 - deg];
}

/** @brief  定点余弦（Q15）= sin(deg+90) */
static eui_int32_t _esgui_3d_cos(eui_int32_t deg)
{
    return _esgui_3d_sin(deg + 90);
}

/**
 * @brief  恒等变换初始化
 * @param  t  变换指针，不能为 ESGUI_NULL
 * @note   平移 0、旋转 0、缩放 256（=1.0）
 */
void ESGUI_3DTransformInit(ESGUI_3DTransform_T *t)
{
    if (t == ESGUI_NULL) return;
    t->tx = 0; t->ty = 0; t->tz = 0;
    t->rot_x = 0; t->rot_y = 0; t->rot_z = 0;
    t->scale_q8 = 256;
}

/** @brief  角度归一到 [0, 360)，防止长期累加溢出 */
static eui_int32_t _esgui_3d_norm_angle(eui_int32_t deg)
{
    deg %= 360;
    if (deg < 0) deg += 360;
    return deg;
}

/**
 * @brief  设置绕某轴旋转到绝对角度
 * @param  t          变换指针，不能为 ESGUI_NULL
 * @param  axis       旋转轴（X/Y/Z）
 * @param  angle_deg  目标角度（度，自动归一到 [0,360)）
 */
void ESGUI_3DTransformSetRot(ESGUI_3DTransform_T *t, ESGUI_3DAxis_T axis, eui_int32_t angle_deg)
{
    if (t == ESGUI_NULL) return;
    angle_deg = _esgui_3d_norm_angle(angle_deg);
    switch (axis) {
        case ESGUI_3D_AXIS_X: t->rot_x = angle_deg; break;
        case ESGUI_3D_AXIS_Y: t->rot_y = angle_deg; break;
        case ESGUI_3D_AXIS_Z: t->rot_z = angle_deg; break;
        default: break;
    }
}

/**
 * @brief  一次性设置三轴旋转角
 * @param  t      变换指针，不能为 ESGUI_NULL
 * @param  rot_x  绕 X 轴角度（度）
 * @param  rot_y  绕 Y 轴角度（度）
 * @param  rot_z  绕 Z 轴角度（度）
 */
void ESGUI_3DTransformSetRotXYZ(ESGUI_3DTransform_T *t, eui_int32_t rot_x, eui_int32_t rot_y, eui_int32_t rot_z)
{
    if (t == ESGUI_NULL) return;
    t->rot_x = _esgui_3d_norm_angle(rot_x);
    t->rot_y = _esgui_3d_norm_angle(rot_y);
    t->rot_z = _esgui_3d_norm_angle(rot_z);
}

/**
 * @brief  在当前旋转基础上再绕某轴累加旋转
 * @param  t          变换指针，不能为 ESGUI_NULL
 * @param  axis       旋转轴（X/Y/Z）
 * @param  angle_deg  累加角度（度，可正可负，自动归一到 [0,360)）
 * @note   等价于 t->rot_* += angle_deg（绕固定世界轴，符合 X→Y→Z 旋转顺序）
 */
void ESGUI_3DTransformRotate(ESGUI_3DTransform_T *t, ESGUI_3DAxis_T axis, eui_int32_t angle_deg)
{
    if (t == ESGUI_NULL) return;
    eui_int32_t a = _esgui_3d_norm_angle(angle_deg);  /* 先归一再相加，防止溢出 */
    switch (axis) {
        case ESGUI_3D_AXIS_X: t->rot_x = _esgui_3d_norm_angle(t->rot_x + a); break;
        case ESGUI_3D_AXIS_Y: t->rot_y = _esgui_3d_norm_angle(t->rot_y + a); break;
        case ESGUI_3D_AXIS_Z: t->rot_z = _esgui_3d_norm_angle(t->rot_z + a); break;
        default: break;
    }
}

/**
 * @brief  模型局部坐标 → 世界坐标
 * @param  src        模型顶点数组（局部坐标），不能为 ESGUI_NULL
 * @param  num        顶点数量
 * @param  transform  变换参数，不能为 ESGUI_NULL
 * @param  dst        世界坐标输出数组，不能为 ESGUI_NULL；可与 src 相同（就地变换）
 * @note   变换顺序：缩放 → 绕X → 绕Y → 绕Z → 平移（右手系，逆时针为正）
 */
void ESGUI_3DTransformPoints(const ESGUI_3DPoint_T *src,
                             eui_uint16_t num,
                             const ESGUI_3DTransform_T *transform,
                             ESGUI_3DPoint_T *dst)
{
    if (src == ESGUI_NULL || transform == ESGUI_NULL || dst == ESGUI_NULL) return;

    /* 预计算旋转角的 Q15 三角值 */
    eui_int32_t sx = _esgui_3d_sin(transform->rot_x);
    eui_int32_t cx = _esgui_3d_cos(transform->rot_x);
    eui_int32_t sy = _esgui_3d_sin(transform->rot_y);
    eui_int32_t cy = _esgui_3d_cos(transform->rot_y);
    eui_int32_t sz = _esgui_3d_sin(transform->rot_z);
    eui_int32_t cz = _esgui_3d_cos(transform->rot_z);

    for (eui_uint16_t i = 0; i < num; i++) {
        int64_t x = src[i].x;
        int64_t y = src[i].y;
        int64_t z = src[i].z;

        /* 1. 缩放（Q8） */
        x = (x * transform->scale_q8) >> 8;
        y = (y * transform->scale_q8) >> 8;
        z = (z * transform->scale_q8) >> 8;

        /* 2. 绕 X 轴旋转（Q15） */
        int64_t nx = x;
        int64_t ny = (y * cx - z * sx) >> 15;
        int64_t nz = (y * sx + z * cx) >> 15;
        x = nx; y = ny; z = nz;

        /* 3. 绕 Y 轴旋转（Q15） */
        nx = (x * cy + z * sy) >> 15;
        ny = y;
        nz = (-x * sy + z * cy) >> 15;
        x = nx; y = ny; z = nz;

        /* 4. 绕 Z 轴旋转（Q15） */
        nx = (x * cz - y * sz) >> 15;
        ny = (x * sz + y * cz) >> 15;
        nz = z;
        x = nx; y = ny; z = nz;

        /* 5. 平移 */
        dst[i].x = (eui_int32_t)(x + transform->tx);
        dst[i].y = (eui_int32_t)(y + transform->ty);
        dst[i].z = (eui_int32_t)(z + transform->tz);
    }
}

/** @brief  判断变换是否为恒等（平移 0、旋转 0、缩放 1.0） */
static bool _esgui_3d_transform_is_identity(const ESGUI_3DTransform_T *t)
{
    if (t == ESGUI_NULL) return true;
    return (t->tx == 0 && t->ty == 0 && t->tz == 0 &&
            t->rot_x == 0 && t->rot_y == 0 && t->rot_z == 0 &&
            t->scale_q8 == 256);
}

/**
 * @brief  按世界坐标顶点数组绘制线框（内部，投影 + 画线）
 * @param  pts        世界坐标顶点数组（x 水平右 / y 深度前 / z 垂直上）
 * @note   y（深度）<= 0 的顶点视为相机后方，所在边跳过
 */
static void _esgui_3d_draw_wireframe(Canvas *c,
                                     const ESGUI_3DPoint_T *pts,
                                     eui_uint16_t num_points,
                                     const ESGUI_3DEdge_T *edges,
                                     eui_uint16_t num_edges,
                                     eui_int32_t focal,
                                     eui_uint16_t screen_w,
                                     eui_uint16_t screen_h,
                                     EUI_DrawMode mode)
{
    eui_int32_t cx = screen_w / 2;
    eui_int32_t cy = screen_h / 2;

    for (eui_int32_t i = 0; i < num_edges; i++) {
        eui_uint16_t ia = edges[i].a;
        eui_uint16_t ib = edges[i].b;

        /* 顶点索引越界校验 */
        if (ia >= num_points || ib >= num_points) continue;

        const ESGUI_3DPoint_T *p1 = &pts[ia];
        const ESGUI_3DPoint_T *p2 = &pts[ib];

        /* 简化裁剪：深度 y <= 0 视为在相机后方/平面上，跳过该边 */
        if (p1->y <= 0 || p2->y <= 0) continue;

        /* 定点透视投影 + 屏幕映射（内部轴转换：y 为深度、z 为垂直） */
        eui_int32_t x1 = (_esgui_3d_project(p1->x, focal, p1->y) >> ESGUI_3D_FP_BITS) + cx;
        eui_int32_t y1 = cy - (_esgui_3d_project(p1->z, focal, p1->y) >> ESGUI_3D_FP_BITS);
        eui_int32_t x2 = (_esgui_3d_project(p2->x, focal, p2->y) >> ESGUI_3D_FP_BITS) + cx;
        eui_int32_t y2 = cy - (_esgui_3d_project(p2->z, focal, p2->y) >> ESGUI_3D_FP_BITS);

        eui_draw_line(c, x1, y1, x2, y2, mode);
    }
}

/**
 * @brief  绘制 3D 线框图（定点透视投影，零浮点）
 * @param  c           Canvas 指针，不能为 ESGUI_NULL
 * @param  model       3D 模型描述结构体（顶点为局部坐标），不能为 ESGUI_NULL
 * @param  transform   变换参数；ESGUI_NULL 或恒等变换时直接按世界坐标绘制（零开销），
 *                     否则内部自动完成“局部坐标 → 世界坐标”再绘制
 * @param  focal       透视焦距（像素，正整数，值越大视野越窄/物体越大）
 * @param  screen_w    屏幕宽度（像素），用于确定水平中心
 * @param  screen_h    屏幕高度（像素），用于确定垂直中心
 * @param  mode        绘制模式
 * @note   - 内部自动完成轴转换：y（深度朝前）作投影深度，z（垂直朝上）作屏幕垂直分量
 *         - 屏幕 Y 轴向下，投影时对垂直分量取反以还原“上为正”
 *         - 深度 y <= 0 的顶点视为在相机后方/平面上，其所在边整条跳过（简化裁剪）
 *         - 顶点索引越界或数组为空的边会被安全跳过
 *         - 非恒等变换时顶点数须 <= ESGUI_3D_MAX_VERTICES，否则安全返回不绘制
 */
void ESGUI_3DWireframeDiagram(Canvas *c,
                              const ESGUI_3D_T *model,
                              const ESGUI_3DTransform_T *transform,
                              eui_int32_t focal,
                              eui_uint16_t screen_w,
                              eui_uint16_t screen_h,
                              EUI_DrawMode mode)
{
    if (c == ESGUI_NULL || model == ESGUI_NULL || model->point_list == ESGUI_NULL || model->edge_list == ESGUI_NULL) return;
    if (focal <= 0 || screen_w == 0 || screen_h == 0) return;

    if (_esgui_3d_transform_is_identity(transform)) {
        /* 恒等变换：直接按世界坐标绘制（零变换开销） */
        _esgui_3d_draw_wireframe(c, model->point_list, model->num_points,
                                 model->edge_list, model->num_edges,
                                 focal, screen_w, screen_h, mode);
    } else {
        /* 非恒等：先变换到内部栈缓冲再绘制 */
        if (model->num_points > ESGUI_3D_MAX_VERTICES) return;
        ESGUI_3DPoint_T world[ESGUI_3D_MAX_VERTICES];
        ESGUI_3DTransformPoints(model->point_list, model->num_points, transform, world);
        _esgui_3d_draw_wireframe(c, world, model->num_points,
                                 model->edge_list, model->num_edges,
                                 focal, screen_w, screen_h, mode);
    }
}

#endif //ESGUI_ENABLE_3D