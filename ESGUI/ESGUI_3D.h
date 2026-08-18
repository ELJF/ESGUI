//
// Created by E_LJF on 2026/8/15.
// 3D 线框渲染模块：模型 / 变换 / 定点透视投影（零浮点）
//

#ifndef ESGUI_ESGUI_3D_H
#define ESGUI_ESGUI_3D_H

#include "ESGUI_DefaultConfig.h"

#if ESGUI_ENABLE_3D

#include "ESGUI_BSP_Canvas.h"
#include "ESGUI_BSP_draw.h"
#include "ESGUI_Def.h"
#include "stdint.h"


//3D图形坐标点集（用户直觉坐标：右手系）
typedef struct esgui_3d_point {
    eui_int32_t x;   // 水平，朝右
    eui_int32_t y;   // 深度，正值朝前（屏幕里/相机前方）
    eui_int32_t z;   // 垂直，朝上
}ESGUI_3DPoint_T;


//3D图形面边集
typedef struct esgui_3d_edge {
    eui_uint16_t a;
    eui_uint16_t b;
}ESGUI_3DEdge_T;


//3D模型描述结构体（只记录形状：顶点为局部坐标，中心通常在原点）
typedef struct esgui_3d_model {
    const ESGUI_3DPoint_T *point_list;  //顶点数组（局部坐标），不能为 ESGUI_NULL
    eui_uint16_t num_points;            //顶点数量，用于校验边索引是否越界
    const ESGUI_3DEdge_T *edge_list;    //边数组（每条边存两个顶点下标 a/b），不能为 ESGUI_NULL
    eui_uint16_t num_edges;             //边数量
}ESGUI_3D_T;


//3D变换结构体（模型局部坐标 → 世界坐标：平移 + 三轴旋转 + 缩放，全部定点）
typedef struct esgui_3d_transform {
    eui_int32_t tx, ty, tz;            //平移（世界坐标偏移）
    eui_int32_t rot_x, rot_y, rot_z;   //欧拉角（度，绕 X/Y/Z 轴，可正可负）
    eui_int32_t scale_q8;              //统一缩放，Q8 定点（256 = 1.0）
}ESGUI_3DTransform_T;


//3D旋转轴枚举
typedef enum {
    ESGUI_3D_AXIS_X = 0,   //绕 X 轴（水平）
    ESGUI_3D_AXIS_Y,       //绕 Y 轴（深度）
    ESGUI_3D_AXIS_Z,       //绕 Z 轴（垂直）
}ESGUI_3DAxis_T;


/* 3D 线框图（定点透视投影，零浮点；focal 为整数焦距）
 * model 为模型（顶点局部坐标）；transform 为 ESGUI_NULL 或恒等变换时，
 * 直接按世界坐标绘制（零变换开销），否则内部自动变换后绘制 */
void ESGUI_3DWireframeDiagram(Canvas *c,
                              const ESGUI_3D_T *model,
                              const ESGUI_3DTransform_T *transform,
                              eui_int32_t focal,
                              eui_uint16_t screen_w,
                              eui_uint16_t screen_h,
                              EUI_DrawMode mode);

/* 3D 变换：模型局部坐标 → 世界坐标（缩放→绕X→绕Y→绕Z→平移）。src 与 dst 可为同一数组 */
void ESGUI_3DTransformPoints(const ESGUI_3DPoint_T *src,
                             eui_uint16_t num,
                             const ESGUI_3DTransform_T *transform,
                             ESGUI_3DPoint_T *dst);

/* 恒等变换初始化（平移 0、旋转 0、缩放 256=1.0） */
void ESGUI_3DTransformInit(ESGUI_3DTransform_T *t);

/* 设置绕某轴旋转到绝对角度（度，自动归一到 [0,360)） */
void ESGUI_3DTransformSetRot(ESGUI_3DTransform_T *t, ESGUI_3DAxis_T axis, eui_int32_t angle_deg);

/* 一次性设置三轴旋转角（度，各自归一到 [0,360)） */
void ESGUI_3DTransformSetRotXYZ(ESGUI_3DTransform_T *t, eui_int32_t rot_x, eui_int32_t rot_y, eui_int32_t rot_z);

/* 在当前旋转基础上，再绕某轴累加 angle_deg（度，自动归一到 [0,360)） */
void ESGUI_3DTransformRotate(ESGUI_3DTransform_T *t, ESGUI_3DAxis_T axis, eui_int32_t angle_deg);

#endif //ESGUI_ENABLE_3D

#endif //ESGUI_ESGUI_3D_H