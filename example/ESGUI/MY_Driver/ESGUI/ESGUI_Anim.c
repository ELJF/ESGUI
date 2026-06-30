//
// Created by E_LJF on 2026/6/4.
//

#include "ESGUI_Anim.h"
#include "string.h"

/* ========== 静态数据区 ========== */

static anim_t  anim_pool[ANIM_MAX_COUNT];
static anim_t* anim_idle_head = NULL;
static anim_t* anim_active_head = NULL;
// 内部自动分配标志位（最多 32 个并发"必须完成"动画）
static uint32_t s_used_ids = 0;      // 位图：哪些 ID 已被占用
static uint32_t s_done_ids = 0;    // 位图：哪些 ID 已完成

/* ========== 内部工具函数 ========== */

/**
 * @brief 线性映射工具函数
 * @param x       输入值，范围 [in_min, in_max]
 * @param in_min  输入范围下限
 * @param in_max  输入范围上限
 * @param out_min 输出范围下限
 * @param out_max 输出范围上限
 * @return        映射后的值，范围 [out_min, out_max]
 *
 * 公式：(x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
 * 用途：把缓动后的进度（0~1000）映射到实际的 start~end 数值。
 */
static inline int32_t map_range(int32_t x, int32_t in_min, int32_t in_max,
                                int32_t out_min, int32_t out_max) {
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

/**
 * @brief 从空闲链表分配一个动画节点
 * @param 无
 * @return 可用的 anim_t 指针；NULL 表示池满
 *
 * 操作：取空闲链表头部节点，链表头后移。
 * 时间复杂度 O(1)。
 */
static anim_t* anim_alloc(void) {
    if (!anim_idle_head) return NULL;
    anim_t* a = anim_idle_head;
    anim_idle_head = anim_idle_head->next;
    a->next = NULL;
    return a;
}

/**
 * @brief 将节点归还到空闲链表
 * @param a 要释放的节点指针。传 NULL 安全无操作
 * @return 无
 *
 * 操作：把节点插到空闲链表头部，状态重置为 IDLE。
 * 时间复杂度 O(1)。
 */
static void anim_free(anim_t* a) {
    if (!a) return;
    a->state = ANIM_STATE_IDLE;
    a->next = anim_idle_head;
    anim_idle_head = a;
}

/**
 * @brief 从活跃链表中移除指定节点
 * @param a 要移除的节点指针
 * @return 无
 *
 * 操作：单向链表遍历找前驱，跳过当前节点。
 * 时间复杂度 O(n)，n <= ANIM_MAX_COUNT。
 * 注意：只移除，不释放。调用方需自行 anim_free。
 */
static void anim_remove_active(anim_t* a) {
    if (!anim_active_head || !a) return;

    if (anim_active_head == a) {
        anim_active_head = a->next;
        a->next = NULL;
        return;
    }

    anim_t* prev = anim_active_head;
    while (prev->next) {
        if (prev->next == a) {
            prev->next = a->next;
            a->next = NULL;
            return;
        }
        prev = prev->next;
    }
}

/**
 * @brief 将节点插入活跃链表头部
 * @param a 要插入的节点指针
 * @return 无
 *
 * 操作：新节点成为活跃链表头。
 * 时间复杂度 O(1)。
 */
static void anim_add_active(anim_t* a) {
    a->next = anim_active_head;
    anim_active_head = a;
}

/* ========== 缓动函数实现 ========== */

int32_t anim_path_linear_impl(const anim_t* a, int32_t p1000) {
    (void)a;
    return p1000;
}

int32_t anim_path_ease_in_impl(const anim_t* a, int32_t p1000) {
    (void)a;
    return (int32_t)((int64_t)p1000 * p1000 / 1000);
}

int32_t anim_path_ease_out_impl(const anim_t* a, int32_t p1000) {
    (void)a;
    return p1000 * (2000 - p1000) / 1000;
}

int32_t anim_path_ease_in_out_impl(const anim_t* a, int32_t p1000) {
    (void)a;
    if (p1000 < 500) {
        return (int32_t)((int64_t)p1000 * p1000 * 2 / 1000);
    } else {
        int32_t t = 1000 - p1000;
        return 1000 - (int32_t)((int64_t)t * t * 2 / 1000);
    }
}

int32_t anim_path_overshoot_impl(const anim_t* a, int32_t p1000) {
    (void)a;
    if (p1000 < 700) {
        return map_range(p1000, 0, 700, 0, 1100);
    } else {
        return map_range(p1000, 700, 1000, 1100, 1000);
    }
}

int32_t anim_path_bounce_impl(const anim_t* a, int32_t p1000) {
    (void)a;
    if (p1000 < 600) {
        return map_range(p1000, 0, 600, 0, 1000);
    } else if (p1000 < 800) {
        return map_range(p1000, 600, 800, 1000, 600);
    } else if (p1000 < 900) {
        return map_range(p1000, 800, 900, 600, 1000);
    } else if (p1000 < 950) {
        return map_range(p1000, 900, 950, 1000, 850);
    } else {
        return map_range(p1000, 950, 1000, 850, 1000);
    }
}

/**
 * @brief 根据动画配置的 path_type 调用对应缓动函数
 * @param a     动画实例，从中读取 path_type 和 path_custom
 * @param p1000 线性进度 [0, 1000]
 * @return      变换后的进度
 *
 * 说明：内部调度函数，用户通常不直接调用。
 */
static int32_t anim_path_apply(const anim_t* a, int32_t p1000) {
    switch (a->path_type) {
        case ANIM_PATH_LINEAR:      return anim_path_linear_impl(a, p1000);
        case ANIM_PATH_EASE_IN:     return anim_path_ease_in_impl(a, p1000);
        case ANIM_PATH_EASE_OUT:    return anim_path_ease_out_impl(a, p1000);
        case ANIM_PATH_EASE_IN_OUT: return anim_path_ease_in_out_impl(a, p1000);
        case ANIM_PATH_OVERSHOOT:   return anim_path_overshoot_impl(a, p1000);
        case ANIM_PATH_BOUNCE:      return anim_path_bounce_impl(a, p1000);
        case ANIM_PATH_STEP:        return a->end;

#if MORE_ANIM_FUNK
        case ANIM_PATH_LINEAR2:     return anim_path_linear(a,p1000);
        case ANIM_PATH_QUAD_IN:     return anim_path_quad_in(a,p1000);
        case ANIM_PATH_QUAD_OUT:    return anim_path_quad_out(a,p1000);
        case ANIM_PATH_QUAD_INOUT:  return anim_path_quad_inout(a,p1000);
        case ANIM_PATH_CUBIC_IN:    return anim_path_cubic_in(a,p1000);
        case ANIM_PATH_CUBIC_OUT:   return anim_path_cubic_out(a,p1000);
        case ANIM_PATH_CUBIC_INOUT: return anim_path_cubic_inout(a,p1000);
        case ANIM_PATH_SINE_IN:     return anim_path_sine_in(a,p1000);
        case ANIM_PATH_SINE_OUT:    return anim_path_sine_out(a,p1000);
        case ANIM_PATH_SINE_INOUT:  return anim_path_sine_inout(a,p1000);
        case ANIM_PATH_EXPO_OUT:    return anim_path_expo_out(a,p1000);
        case ANIM_PATH_EXPO_IN:     return anim_path_expo_in(a,p1000);
        case ANIM_PATH_BACK_IN:     return anim_path_back_in(a,p1000);
        case ANIM_PATH_BACK_OUT:    return anim_path_back_out(a,p1000);
        case ANIM_PATH_ELSTIC_OUT:  return anim_path_elastic_out(a,p1000);
        case ANIM_PATH_PAUSE_MID:   return anim_path_pause_mid(a,p1000);
#endif

        case ANIM_PATH_CUSTOM:
            if (a->path_custom) return a->path_custom(a, p1000);
            return p1000;
        default: return p1000;
    }
}

/* ========== 用户 API 实现 ========== */

void anim_init(void) {
    memset(anim_pool, 0, sizeof(anim_pool));
    anim_idle_head = NULL;
    anim_active_head = NULL;
    for (int i = ANIM_MAX_COUNT - 1; i >= 0; i--) {
        anim_pool[i].state = ANIM_STATE_IDLE;
        anim_pool[i].next = anim_idle_head;
        anim_idle_head = &anim_pool[i];
    }
}


/**
 * @brief 查找变量正在运行的动画（取第一个匹配的）
 */
static anim_t* anim_find_running(void* var) {
    anim_t* cur = anim_active_head;
    while (cur) {
        if (cur->var == var && cur->state != ANIM_STATE_IDLE) {
            return cur;
        }
        cur = cur->next;
    }
    return NULL;
}

/**
 * @brief 热更新正在运行的动画目标值
 * @param a     正在运行的动画实例
 * @param end   新的目标值
 * @param duration 新的持续时间（0 表示保持原时长不变）
 * @return      true=更新成功；false=参数非法
 *
 * 原理：不重启动画，只修改终点和剩余时长，从当前位置继续跑。
 * 这样无论编码器拧多快，同一变量始终只有一个动画在跑。
 */
bool anim_set_end(anim_t* a, int32_t end, uint32_t duration) {
    if (!a || a->state == ANIM_STATE_IDLE) return false;

    // 更新终点
    a->end = end;

    // 重新计算起点为当前值，避免跳变
    a->start = a->current;

    // 更新时间参数
    if (duration > 0) {
        a->duration = duration;
    }

    // 重置计时，从当前帧开始新的缓动
    a->start_time = 0;  // anim_update 下次遇到时会用当前 tick 初始化
    a->delay = 0;


    // 如果正在 backward，切回正向（新目标来了，优先追新目标）
    if (a->state == ANIM_STATE_BACKWARD) {
        a->state = ANIM_STATE_PLAYING;
    }

    return true;
}


anim_t* anim_start(anim_t* a) {
    if (!a || !a->exec_cb) return NULL;

    // 查找同变量正在跑的动画
    anim_t* running = anim_find_running(a->var);

    if (running) {
        // 热更新：只改终点，不重启，不占用新槽位
        anim_set_end(running, a->end, a->duration);
        return running;
    }

    anim_t* real = anim_alloc();
    if (!real) return NULL;

    *real = *a;
    real->state = ANIM_STATE_PLAYING;
    real->start_time = 0;   // 0 表示"尚未开始计时"
    real->next = NULL;

    // 立即初始化变量到 start 值，避免第一帧显示旧值
    if (real->exec_cb) {
        real->exec_cb(real->var, real->start);
    }
    real->current = real->start;

    anim_add_active(real);
    return real;
}

void anim_stop(anim_t* a) {
    if (!a) return;
    // 释放 ID
    if (a->must_complete && a->_completion_id < 32) {
        s_used_ids &= ~(1u << a->_completion_id);
        s_done_ids &= ~(1u << a->_completion_id);
    }
    anim_remove_active(a);
    anim_free(a);
}

void anim_stop_all(void* var) {
    anim_t* cur = anim_active_head;
    while (cur) {
        anim_t* next = cur->next;
        if (cur->var == var) {
            // 释放 ID
            if (cur->must_complete && cur->_completion_id < 32) {
                s_used_ids &= ~(1u << cur->_completion_id);
                s_done_ids &= ~(1u << cur->_completion_id);
            }
            anim_remove_active(cur);
            anim_free(cur);
        }
        cur = next;
    }
}

void anim_update(uint32_t tick) {
    anim_t* cur = anim_active_head;

    while (cur) {
        anim_t* next = cur->next;

        if (cur->state == ANIM_STATE_IDLE) {
            cur = next;
            continue;
        }

        /* 首次遇到这个动画，初始化启动时间 */
        if (cur->start_time == 0) {
            cur->start_time = tick;
        }

        /* 还在 delay 阶段 */
        if (tick < cur->start_time + cur->delay) {
            cur = next;
            continue;
        }

        uint32_t elapsed = tick - (cur->start_time + cur->delay);
        int32_t p1000;
        bool finished = false;

        if (elapsed >= cur->duration) {
            p1000 = 1000;
            finished = true;
        } else {
            p1000 = (int32_t)((int64_t)elapsed * 1000 / cur->duration);
        }

        int32_t eased = anim_path_apply(cur, p1000);
        int32_t value;

        if (cur->state == ANIM_STATE_BACKWARD && cur->playback) {
            value = map_range(eased, 0, 1000, cur->end, cur->start);
        } else {
            value = map_range(eased, 0, 1000, cur->start, cur->end);
        }

        cur->current = value;

        if (cur->exec_cb) {
            cur->exec_cb(cur->var, value);
        }

        if (finished) {
            if (cur->must_complete && cur->_completion_id < 32) {
                s_done_ids |= (1u << cur->_completion_id);
            }
            if (cur->playback && cur->state != ANIM_STATE_BACKWARD) {
                cur->state = ANIM_STATE_BACKWARD;
                cur->start_time = tick;
                cur->delay = 0;
            } else {
                if (cur->repeat_cnt > 0 || cur->repeat_cnt == 0xFFFF) {
                    if (cur->repeat_cnt != 0xFFFF) cur->repeat_cnt--;
                    cur->state = ANIM_STATE_PLAYING;
                    cur->start_time = tick;
                    cur->delay = 0;
                } else {
                    if (cur->ready_cb) cur->ready_cb(cur);
                    anim_remove_active(cur);
                    anim_free(cur);
                }
            }
        }

        cur = next;
    }
}




void anim_must_complete_reset(void) {
    s_used_ids = 0;
    s_done_ids = 0;
}





/* ========== 查询 API ========== */

bool anim_is_running(void) {
    return (anim_active_head != NULL);
}

bool anim_is_running_var(void* var) {
    if (var == NULL) return false;
    anim_t* cur = anim_active_head;
    while (cur) {
        if (cur->var == var) {
            return true;
        }
        cur = cur->next;
    }
    return false;
}

uint8_t anim_get_running_count(void) {
    uint8_t count = 0;
    anim_t* cur = anim_active_head;
    while (cur) {
        count++;
        cur = cur->next;
    }
    return count;
}



// 查询：是否所有"必须完成"的动画都结束了
bool anim_all_must_complete_done(void) {
    return (s_done_ids & s_used_ids) == s_used_ids;
}



/* ========== 配置辅助函数 ========== */

anim_t* anim_set_var(anim_t* a, void* var) {
    if (a) a->var = var;
    return a;
}

anim_t* anim_set_exec_cb(anim_t* a, anim_exec_cb_t cb) {
    if (a) a->exec_cb = cb;
    return a;
}

anim_t* anim_set_ready_cb(anim_t* a, anim_ready_cb_t cb) {
    if (a) a->ready_cb = cb;
    return a;
}

anim_t* anim_set_values(anim_t* a, int32_t start, int32_t end) {
    if (a) { a->start = start; a->end = end; }
    return a;
}

anim_t* anim_set_time(anim_t* a, uint32_t duration) {
    if (a) a->duration = duration;
    return a;
}

anim_t* anim_set_delay(anim_t* a, uint32_t delay) {
    if (a) a->delay = delay;
    return a;
}

anim_t* anim_set_repeat(anim_t* a, uint16_t cnt, bool playback) {
    if (a) {
        a->repeat_total = cnt;
        a->repeat_cnt = cnt;
        a->playback = playback;
    }
    return a;
}

anim_t* anim_set_path(anim_t* a, anim_path_type_t type) {
    if (a) a->path_type = type;
    return a;
}


anim_t* anim_set_must_complete(anim_t* a, bool en) {
    if (!a) return NULL;
    a->must_complete = en;
    if (en) {
        // 自动分配一个空闲 ID
        for (int i = 0; i < 32; i++) {
            if (!(s_used_ids & (1u << i))) {
                s_used_ids |= (1u << i);
                a->_completion_id = i;
                return a;
            }
        }
        // 没有空闲 ID，降级为不阻塞（或断言）
        a->must_complete = false;
        a->_completion_id = 0xFF;
    }
    return a;
}


#if MORE_ANIM_FUNK
/** @brief 线性 */
int32_t anim_path_linear(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    return p1000;
}

/* ==================== 二次方 ==================== */

/** @brief 二次缓入 (t^2) */
int32_t anim_path_quad_in(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    return (p1000 * p1000) / 1000;
}

/** @brief 二次缓出 (1 - (1-t)^2) */
int32_t anim_path_quad_out(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    int32_t inv = 1000 - p1000;
    return 1000 - (inv * inv) / 1000;
}

/** @brief 二次缓入缓出 */
int32_t anim_path_quad_inout(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    if (p1000 < 500) {
        return (p1000 * p1000 * 2) / 1000;
    } else {
        int32_t inv = 1000 - p1000;
        return 1000 - (inv * inv * 2) / 1000;
    }
}

/* ==================== 三次方 ==================== */

/** @brief 三次缓入 (t^3) */
int32_t anim_path_cubic_in(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    int64_t t = p1000;
    return (int32_t)((t * t * t) / 1000000LL);
}

/** @brief 三次缓出 (1 - (1-t)^3) */
int32_t anim_path_cubic_out(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    int64_t inv = 1000 - p1000;
    return (int32_t)(1000 - (inv * inv * inv) / 1000000LL);
}

/** @brief 三次缓入缓出 */
int32_t anim_path_cubic_inout(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    if (p1000 < 500) {
        int64_t t = p1000 * 2;
        return (int32_t)((t * t * t) / 4000000LL);  // 4*t^3/1000^3 * 1000
    } else {
        int64_t inv = (1000 - p1000) * 2;
        return (int32_t)(1000 - (inv * inv * inv) / 4000000LL);
    }
}

/* ==================== 正弦 ==================== */

/** 正弦查表: sin(i/64 * π/2) * 1000, i = 0..64 */
static const int16_t anim_sin_table[65] = {
    0,    49,   98,   147,  196,  245,  293,  342,
    390,  438,  485,  532,  579,  625,  671,  716,
    760,  804,  848,  890,  932,  974,  1014, 1054,
    1093, 1131, 1169, 1205, 1241, 1275, 1309, 1342,
    1374, 1405, 1435, 1464, 1492, 1519, 1545, 1570,
    1594, 1617, 1639, 1660, 1680, 1699, 1717, 1734,
    1750, 1765, 1779, 1792, 1804, 1815, 1825, 1834,
    1842, 1849, 1855, 1860, 1864, 1867, 1869, 1871,
    1872
};

/** @brief 正弦缓出 (sin(t * π/2)) */
int32_t anim_path_sine_out(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    int32_t idx = (p1000 * 64) / 1000;
    if (idx > 64) idx = 64;
    return anim_sin_table[idx];
}

/** @brief 正弦缓入 (1 - cos(t * π/2)) */
int32_t anim_path_sine_in(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    int32_t idx = 64 - (p1000 * 64) / 1000;
    if (idx < 0) idx = 0;
    return 1000 - anim_sin_table[idx];
}

/** @brief 正弦缓入缓出 ((1 - cos(t * π)) / 2) */
int32_t anim_path_sine_inout(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    // 映射到 0~128，查前半段和后半段
    int32_t idx = (p1000 * 128) / 1000;
    if (idx > 128) idx = 128;
    if (idx <= 64) {
        return anim_sin_table[idx] / 2;
    } else {
        return 1000 - anim_sin_table[128 - idx] / 2;
    }
}

/* ==================== 指数/其他 ==================== */

/** @brief 指数缓出近似 (1 - (1-t)^4) */
int32_t anim_path_expo_out(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    int64_t inv = 1000 - p1000;
    int64_t val = (inv * inv) / 1000;
    val = (val * val) / 1000;  // (1000-p)^4 / 1000^3
    return (int32_t)(1000 - val);
}

/** @brief 指数缓入近似 (t^4) */
int32_t anim_path_expo_in(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    int64_t t = p1000;
    int64_t val = (t * t) / 1000;
    val = (val * val) / 1000;
    return (int32_t)val;
}

/* ==================== 回弹/弹性 ==================== */

/** @brief 回弹缓出 (Back Ease-Out, overshoot ≈ 1.702) */
int32_t anim_path_back_out(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    int32_t td  = p1000 - 1000;          // -1000 ~ 0
    int32_t td2 = (td * td) / 1000;     //  1000 ~ 0
    int32_t td3 = (td2 * td) / 1000;    // -1000 ~ 0

    // overshoot = 1.70158 ≈ 1702/1000
    return 1000 + td3 + (1702 * td2) / 1000;
}

/** @brief 回弹缓入 */
int32_t anim_path_back_in(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    int32_t td  = p1000;                // 0 ~ 1000
    int32_t td2 = (td * td) / 1000;    // 0 ~ 1000
    int32_t td3 = (td2 * td) / 1000;   // 0 ~ 1000

    return td3 - (1702 * td2) / 1000;
}

/** @brief 弹性缓出 (Elastic Ease-Out, 简化衰减版) */
int32_t anim_path_elastic_out(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    if (p1000 == 0) return 0;
    if (p1000 >= 1000) return 1000;

    // 衰减因子: (1000-p)/1000
    int32_t decay = 1000 - p1000;

 // 查表索引: p1000 * 3 * 64 / 1000，模拟 1.5π 周期
    int32_t idx = (p1000 * 192) / 1000;
    if (idx > 64) idx = 64;

    // 正弦振荡 * 衰减
    int32_t osc = anim_sin_table[idx];           // 0~1872
    int64_t val = (int64_t)osc * decay / 1000;   // 衰减后

    return (int32_t)(1000 - val);
}

/* ==================== 阶跃/特殊 ==================== */

/** @brief 中间停顿 (0→500 快速，500~900 停顿，900→1000 快速) */
int32_t anim_path_pause_mid(const struct anim_t* a, int32_t p1000)
{
    (void)a;
    if (p1000 < 300) {
        return (p1000 * 1000) / 300;
    } else if (p1000 < 800) {
        return 1000;
    } else {
        return 1000 - ((1000 - p1000) * 1000) / 200;
    }
}
#endif