//
// Created by E_LJF on 2026/6/4.
//

#ifndef ESGUI_ESGUI_ANIM_H
#define ESGUI_ESGUI_ANIM_H

#include "ESGUI_Def.h"
#include "ESGUI_DefaultConfig.h"
#include "stdbool.h"

#ifndef ANIM_MAX_COUNT
#define ANIM_MAX_COUNT  16  //最大并行动画数量，即最多运行多少动画
#endif

/* ========== 枚举 ========== */

/**
 * @brief 动画状态枚举
 *
 * 描述动画实例在生命周期中的当前阶段。
 * 状态机流转：IDLE -> PLAYING -> [BACKWARD] -> IDLE
 */
typedef enum {
    ANIM_STATE_IDLE = 0,    /**< 空闲状态：动画未启动，或已结束归还至空闲链表 */
    ANIM_STATE_PLAYING,     /**< 正向播放：动画正在从 start 向 end 执行 */
    ANIM_STATE_BACKWARD,    /**< 反向播放：动画在 playback 模式下从 end 返回 start */
} anim_state_t;

/**
 * @brief 缓动曲线类型枚举
 *
 * 定义动画值随时间变化的数学映射方式。
 * 所有内置曲线均基于 0~1000 的线性进度进行变换，以适配无 FPU 的 MCU。
 */
typedef enum {
    ANIM_PATH_LINEAR = 0,   /**< 线性匀速：进度无变换，全程速度一致 */
    ANIM_PATH_EASE_IN,      /**< 缓入：起步慢，逐渐加速，适合元素进入场景 */
    ANIM_PATH_EASE_OUT,     /**< 缓出：起步快，接近目标时减速，适合元素停止 */
    ANIM_PATH_EASE_IN_OUT,  /**< 缓入缓出：先加速后减速，最自然的过渡效果 */
    ANIM_PATH_OVERSHOOT,    /**< 冲过：超过目标值后回正，模拟弹性过冲 */
    ANIM_PATH_BOUNCE,       /**< 弹跳：多次反弹逐渐衰减，模拟物理弹跳 */
    ANIM_PATH_STEP,         /**< 步进：不经过中间值，直接跳转到 end，用于瞬时切换 */
    ANIM_PATH_CUSTOM,       /**< 自定义：使用 path_custom 函数指针实现专有曲线 */

#if MORE_ANIM_FUNK
    ANIM_PATH_LINEAR2,  /*<线性2*/
    ANIM_PATH_QUAD_IN,  /*<二次缓入*/
    ANIM_PATH_QUAD_OUT, /*<二次缓出*/
    ANIM_PATH_QUAD_INOUT,/*<二次缓入缓出*/
    ANIM_PATH_CUBIC_IN, /*<三次缓入*/
    ANIM_PATH_CUBIC_OUT,/*<三次缓出*/
    ANIM_PATH_CUBIC_INOUT,/*<三次缓入缓出*/
    ANIM_PATH_SINE_OUT,/*<正弦缓出*/
    ANIM_PATH_SINE_IN,/*<正弦缓入*/
    ANIM_PATH_SINE_INOUT,/*<正弦缓入缓出*/
    ANIM_PATH_EXPO_OUT,/*<指数缓出*/
    ANIM_PATH_EXPO_IN,/*<指数缓入*/
    ANIM_PATH_BACK_OUT,/*<回弹缓出*/
    ANIM_PATH_BACK_IN,/*<回弹缓入*/
    ANIM_PATH_ELSTIC_OUT,/*<弹性缓出*/
    ANIM_PATH_PAUSE_MID,/*<中间停顿 (0→500 快速，500~900 停顿，900→1000 快速)*/

#endif

} anim_path_type_t;

/* ========== 回调类型 ========== */

struct anim_t;

/**
 * @brief 自定义缓动曲线函数
 * @param a     当前动画实例，可读取 duration/start 等属性
 * @param p1000 线性时间进度，范围 [0, 1000]。0=起点，1000=终点
 * @return      变换后的进度，范围 [0, 1000]。可超出，如 overshoot 返回 1100
 *
 * 说明：使用 0~1000 千分比而非 0.0~1.0 浮点，是为了适配无 FPU 的 MCU。
 */
typedef eui_int32_t (*anim_path_cb_t)(const struct anim_t* a, eui_int32_t p1000);

/**
 * @brief 属性写入回调，每帧被调用一次
 * @param var   用户数据指针，即 anim_set_var() 设置的值
 * @param value 当前帧计算出的插值结果
 *
 * 说明：这是动画系统与你的菜单框架的"接口"。
 * 你在这个函数里把 value 写进对象的属性，例如：
 *   ((menu_item_t*)var)->x = value;
 */
typedef void (*anim_exec_cb_t)(void* var, eui_int32_t value);

/**
 * @brief 动画结束回调，动画彻底完成后调用一次
 * @param a 动画实例指针。通过 a->var 可知道是哪个对象
 *
 * 说明：用于串联动画（A 结束启动 B）、播放音效、恢复输入等。
 * 注意：此回调在 anim_update 内部调用，不要在里面做阻塞操作。
 */
typedef void (*anim_ready_cb_t)(struct anim_t* a);

/* ========== 动画实例结构体 ========== */

/**
 * @brief 动画实例结构体
 *
 * 描述一个动画的所有配置参数和运行时状态。
 * 用户先填充此结构体，再调用 anim_start() 将其拷贝到内部动画池。
 * 结构体中的回调和数值字段支持链式配置。
 */
typedef struct anim_t {
    /* ---- 状态与链表 ---- */
    anim_state_t    state;      /**< 当前状态：IDLE / PLAYING / BACKWARD */
    struct anim_t*  next;       /**< 链表指针：用于串联空闲链表或活跃链表，用户无需操作 */

    /* ---- 用户关联 ---- */
    void*           var;        /**< 用户数据指针：关联的目标对象，原样透传给 exec_cb 和 ready_cb */
    anim_exec_cb_t  exec_cb;    /**< 逐帧回调：每帧计算出新值后调用，用于将值写入对象属性。不可为 ESGUI_NULL */
    anim_ready_cb_t ready_cb;   /**< 结束回调：动画完全结束后调用一次，可为 ESGUI_NULL。用于串联动画或触发音效 */

    /* ---- 数值定义 ---- */
    eui_int32_t         start;      /**< 起始值：动画开始时 exec_cb 收到的第一个值。可大于 end，表示递减 */
    eui_int32_t         end;        /**< 目标值：动画结束时 exec_cb 收到的最后一个值 */
    eui_int32_t         current;    /**< 当前值：本帧计算后的插值结果，仅在运行时有效 */

    /* ---- 时间控制 ---- */
    eui_uint32_t        start_time; /**< 启动时间戳：记录动画实际开始计时的系统 tick（ms）。0 表示尚未初始化 */
    eui_uint32_t        duration;   /**< 持续时间：单次动画（去程）的时长，单位毫秒。必须大于 0 */
    eui_uint32_t        delay;      /**< 启动延迟：从调用 anim_start 到真正开始计时的等待时间，单位毫秒。仅首次生效 */

    /* ---- 重复与往返 ---- */
    eui_uint16_t        repeat_cnt; /**< 剩余重复次数：运行时的递减计数器。0xFFFF 表示无限循环 */
    eui_uint16_t        repeat_total; /**< 总重复次数：配置时写入的原始值，用于需要时重置或查询 */
    bool            playback;   /**< 往返模式标志：true = 到 end 后自动返回 start（一去一回算一次 repeat）；false = 单向重复 */

    /* ---- 缓动曲线 ---- */
    anim_path_type_t path_type; /**< 缓动类型：选择内置曲线或 ANIM_PATH_CUSTOM */
    anim_path_cb_t   path_custom; /**< 自定义曲线函数指针：当 path_type = CUSTOM 时生效，否则可为 ESGUI_NULL */

    /* ---- 是否必须完成 ---- */
    bool must_complete;         // 新增：true = 该动画必须完成，才允许页面销毁
    eui_uint8_t _completion_id;     // 内部使用：框架自动分配的标志位 ID
} anim_t;

/* ========== 系统级 API ========== */

/**
 * @brief 初始化动画系统，必须在所有其他 API 之前调用
 * @param 无
 * @return 无
 *
 * 作用：把 ANIM_MAX_COUNT 个节点全部置为 IDLE 状态，串成空闲链表。
 * 时机：系统启动时调用一次即可，不可重复调用（会重置所有运行中动画）。
 */
void anim_init(void);

/**
 * @brief 启动一个动画
 * @param a 用户填写的动画配置。必须是已填充的 anim_t 结构体，exec_cb 不能为 ESGUI_NULL
 * @return  动画池中的真实实例指针；ESGUI_NULL 表示池满，启动失败
 *
 * 说明：
 * - 函数内部会把 *a 整份拷贝到静态数组的空闲槽位，你的临时变量 a 随后可销毁
 * - 返回的指针用于后续操作（如 anim_stop），指向的是 anim_pool 内部
 * - start_time 在此函数中不会赋值，由 anim_update 第一次遇到时设置
 */
anim_t* anim_start(anim_t* a);

/**
 * @brief 停止并释放指定动画
 * @param a anim_start() 返回的指针。传 ESGUI_NULL 安全无操作
 * @return 无
 *
 * 说明：动画立即停止，exec_cb 不再被调用，节点归还空闲链表。
 * 如果 a 已经被停止过，再次调用是安全的（但应避免）。
 */
void anim_stop(anim_t* a);

/**
 * @brief 停止某个对象关联的所有动画
 * @param var 用户数据指针，匹配 anim_t.var 字段
 * @return 无
 *
 * 说明：遍历活跃链表，var 匹配的全部停止。用于页面切换时批量清理。
 * 传 ESGUI_NULL 会匹配所有 var 为 ESGUI_NULL 的动画。
 */
void anim_stop_all(void* var);

/**
 * @brief 动画引擎心跳，驱动所有活跃动画前进一帧
 * @param tick 当前系统时间戳（ms），必须单调递增
 * @return 无
 *
 * 说明：
 * - 必须在主循环或定时器中断中周期性调用，建议频率 1ms~10ms
 * - tick 由用户提供，通常来自 SysTick 或 RTOS 的 tick 计数
 * - 首次调用时，会把活跃链表中各节点的 start_time 初始化为 tick
 */
void anim_update(eui_uint32_t tick);



/**
 * @brief 重置必须完成动画位图
 * @param 无
 * @return 无
 */
void anim_must_complete_reset(void);


/**
 * @brief 查询当前是否有任何动画在运行
 * @param 无
 * @return true 有至少一个动画在活跃链表中；false 所有槽位均空闲
 *
 * 用途：主循环中判断是否需要阻塞用户输入，避免动画期间误触发。
 */
bool anim_is_running(void);

/**
 * @brief 查询指定对象是否还有动画在运行
 * @param var 用户数据指针，匹配 anim_t.var 字段
 * @return true 该对象至少有一个关联动画在跑；false 无关联动画
 *
 * 用途：判断某个菜单项的滑入/淡出是否已完成，再允许用户操作它。
 */
bool anim_is_running_var(void* var);




/**
 * @brief 获取当前正在运行的动画数量
 * @param 无
 * @return 活跃链表中动画节点的个数，范围 [0, ANIM_MAX_COUNT]
 *
 * 用途：调试或性能监控，查看动画系统负载。
 */
eui_uint8_t anim_get_running_count(void);


/**
 * @brief 查询：是否所有"必须完成"的动画都结束了
 * @param 无
 * @return True   False
 */
bool anim_all_must_complete_done(void);


bool anim_set_end(anim_t* a, eui_int32_t end, eui_uint32_t duration);




/* ========== 配置辅助函数 ========== */

/**
 * @brief 设置动画关联的用户数据指针
 * @param a   目标动画配置
 * @param var 任意指针，会原样传给 exec_cb 和 ready_cb
 * @return    返回 a 自身，支持链式调用
 */
anim_t* anim_set_var(anim_t* a, void* var);

/**
 * @brief 设置每帧属性写入回调
 * @param a  目标动画配置
 * @param cb 回调函数指针，不能为 ESGUI_NULL，否则 anim_start 会失败
 * @return   返回 a 自身，支持链式调用
 */
anim_t* anim_set_exec_cb(anim_t* a, anim_exec_cb_t cb);

/**
 * @brief 设置动画结束通知回调
 * @param a  目标动画配置
 * @param cb 结束回调，可为 ESGUI_NULL（表示不需要通知）
 * @return   返回 a 自身，支持链式调用
 */
anim_t* anim_set_ready_cb(anim_t* a, anim_ready_cb_t cb);

/**
 * @brief 设置动画的起始值和目标值
 * @param a     目标动画配置
 * @param start 起始值，动画开始时 exec_cb 收到的第一个值
 * @param end   目标值，动画结束时 exec_cb 收到的最后一个值
 * @return      返回 a 自身，支持链式调用
 *
 * 说明：start 可以大于 end，表示数值递减。例如 start=240, end=20 表示向左滑动。
 */
anim_t* anim_set_values(anim_t* a, eui_int32_t start, eui_int32_t end);

/**
 * @brief 设置单次动画持续时间
 * @param a        目标动画配置
 * @param duration 持续时间，单位毫秒。必须 > 0
 * @return         返回 a 自身，支持链式调用
 *
 * 说明：这是"去程"的时间。若开启 playback，回程时间与此相同。
 */
anim_t* anim_set_time(anim_t* a, eui_uint32_t duration);

/**
 * @brief 设置启动延迟
 * @param a     目标动画配置
 * @param delay 延迟时间，单位毫秒。0 表示立即开始
 * @return      返回 a 自身，支持链式调用
 *
 * 说明：delay 只影响第一次启动。repeat 和 playback 的回程不会重新延迟。
 */
anim_t* anim_set_delay(anim_t* a, eui_uint32_t delay);

/**
 * @brief 设置重复次数和往返模式
 * @param a         目标动画配置
 * @param cnt       重复次数。0 表示不重复（只播放一次），0xFFFF 表示无限循环
 * @param playback  true=往返模式：到 end 后自动返回 start，一去一回算一次 repeat
 *                  false=单向重复：每次从 start 重新到 end
 * @return          返回 a 自身，支持链式调用
 *
 * 说明：
 * - playback=true 时，去程+回程 = 一次完整 repeat
 * - playback=false 时，每次都是从 start 到 end，不会自动返回
 */
anim_t* anim_set_repeat(anim_t* a, eui_uint16_t cnt, bool playback);

/**
 * @brief 设置缓动曲线类型
 * @param a    目标动画配置
 * @param type 内置曲线类型，或 ANIM_PATH_CUSTOM 使用自定义函数
 * @return     返回 a 自身，支持链式调用
 *
 * 说明：选择 CUSTOM 时，还需通过 a.path_custom 设置函数指针。
 */
anim_t* anim_set_path(anim_t* a, anim_path_type_t type);


/**
 * @brief 设置动画为必须完成的动画
 * @param a    目标动画配置
 * @param en   是否必须完成使能
 * @return     返回 a 自身，支持链式调用
 */
anim_t* anim_set_must_complete(anim_t* a, bool en);

/* ========== 内置缓动函数（可直接调用或用于自定义组合） ========== */

/**
 * @brief 线性匀速
 * @param a     未使用，为保持签名一致而保留
 * @param p1000 线性进度 [0, 1000]
 * @return      等于 p1000，无变换
 */
eui_int32_t anim_path_linear_impl(const anim_t* a, eui_int32_t p1000);

/**
 * @brief 缓入：起步慢，越来越快
 * @param a     未使用
 * @param p1000 线性进度 [0, 1000]
 * @return      p1000 的平方除以 1000，范围 [0, 1000]
 */
eui_int32_t anim_path_ease_in_impl(const anim_t* a, eui_int32_t p1000);

/**
 * @brief 缓出：起步快，接近目标时减速
 * @param a     未使用
 * @param p1000 线性进度 [0, 1000]
 * @return      开口向下抛物线，范围 [0, 1000]
 */
eui_int32_t anim_path_ease_out_impl(const anim_t* a, eui_int32_t p1000);

/**
 * @brief 缓入缓出：先加速后减速
 * @param a     未使用
 * @param p1000 线性进度 [0, 1000]
 * @return      分段二次曲线，范围 [0, 1000]
 */
eui_int32_t anim_path_ease_in_out_impl(const anim_t* a, eui_int32_t p1000);

/**
 * @brief 冲过：超过目标再回正
 * @param a     未使用
 * @param p1000 线性进度 [0, 1000]
 * @return      范围 [0, 1100]，前 70% 冲到 110%，后 30% 拉回 100%
 */
#if ESGUI_ANIM_ENABLE_OVERSHOOT
eui_int32_t anim_path_overshoot_impl(const anim_t* a, eui_int32_t p1000);
#endif

/**
 * @brief 弹跳：多次反弹逐渐衰减
 * @param a     未使用
 * @param p1000 线性进度 [0, 1000]
 * @return      分段线性模拟弹跳，最终收敛到 1000
 */
#if ESGUI_ANIM_ENABLE_BOUNCE
eui_int32_t anim_path_bounce_impl(const anim_t* a, eui_int32_t p1000);
#endif

#if MORE_ANIM_FUNK
eui_int32_t anim_path_linear(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_quad_in(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_quad_out(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_quad_inout(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_cubic_in(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_cubic_out(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_cubic_inout(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_sine_out(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_sine_in(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_sine_inout(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_expo_out(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_expo_in(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_back_out(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_back_in(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_elastic_out(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_step(const struct anim_t* a, eui_int32_t p1000);
eui_int32_t anim_path_pause_mid(const struct anim_t* a, eui_int32_t p1000);
#endif


#endif //ESGUI_ESGUI_ANIM_H
