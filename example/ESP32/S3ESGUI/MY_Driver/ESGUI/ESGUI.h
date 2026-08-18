//
// Created by E_LJF on 2026/5/28.
//

#ifndef ESGUI_ESGUI_H
#define ESGUI_ESGUI_H

#include "ESGUI_Menu.h"
#include "ESGUI_DefaultConfig.h"
#include "ESGUI_Def.h"

typedef struct esgui ESGUI_T;
typedef struct anim_t anim_t;

/* ==================== 编译器原子适配层 ====================
 * 统一命令队列 / 生产者收件箱 head/tail 的跨任务访问方式：
 *  - GCC / Clang / ARM Compiler 6：使用内建原子 __atomic_*，
 *    支持 ACQUIRE/RELEASE 内存序，多核安全；
 *  - 其他编译器（MSVC / IAR / Keil ARMCC5 等）：退化为普通 volatile
 *    读写（单核语义，需满足单核 + 单生产者前提）。
 *  - ESGUI_SYNC_MODE=1 时强制使用 volatile 版（纯软件模式）。
 * 所有队列代码只依赖"对齐 32 位读写"，不依赖 RMW/CAS，
 * 因此上述两类实现均可在任意主流 MCU（ARM / Xtensa / RISC-V）上正确运行。 */
#if (defined(__GNUC__) || defined(__clang__)) && (ESGUI_SYNC_MODE == 0)
    #define ESGUI_SYNC_LOAD32(p)            __atomic_load_n((p), __ATOMIC_RELAXED)
    #define ESGUI_SYNC_LOAD32_ACQUIRE(p)    __atomic_load_n((p), __ATOMIC_ACQUIRE)
    #define ESGUI_SYNC_STORE32(p, v)        __atomic_store_n((p), (v), __ATOMIC_RELAXED)
    #define ESGUI_SYNC_STORE32_RELEASE(p,v) __atomic_store_n((p), (v), __ATOMIC_RELEASE)
#else
    #define ESGUI_SYNC_LOAD32(p)            (*(volatile eui_uint32_t *)(p))
    #define ESGUI_SYNC_LOAD32_ACQUIRE(p)    (*(volatile eui_uint32_t *)(p))
    #define ESGUI_SYNC_STORE32(p, v)        (*(volatile eui_uint32_t *)(p) = (v))
    #define ESGUI_SYNC_STORE32_RELEASE(p,v) (*(volatile eui_uint32_t *)(p) = (v))
#endif


typedef enum {
    ESGUI_DRAW_PAGE,
    ESGUI_DRAW_POPWINDOW,
}ESGUI_DRAW_TYPE_ENU;


typedef void (*refresh)(struct esgui *ui,void *page,void *window);
typedef void (*anim_tick)(struct esgui *ui,eui_uint32_t tick);


/* ==================== 覆盖层（Overlay） ==================== */

typedef struct esgui_overlay ESGUI_Overlay_T;

/** 覆盖层绘制回调：框架在 page/window 之后调用，参数为覆盖层自身 */
typedef void (*esgui_overlay_draw_cb)(ESGUI_Overlay_T *ov);

struct esgui_overlay {
    esgui_overlay_draw_cb on_draw;   /**< 绘制回调，不可为 ESGUI_NULL */
    void *render_ctx;                /**< 渲染上下文，框架注入 */
    void *user_data;                 /**< 用户私有数据，框架不操作 */
    eui_uint8_t visible      : 1;    /**< 1=可见 */
    eui_uint8_t always_dirty : 1;    /**< 1=每帧强制重绘（常驻动态内容） */
};


#if ESGUI_ENABLE_MULTITHREAD

/* ==================== 无锁命令队列（单生产者-单消费者） ==================== */

typedef enum {
    ESGUI_CMD_KEY = 0,          /**< 按键事件 */
    ESGUI_CMD_ACTION,           /**< 菜单动作（入栈/出栈/弹窗/刷新/退出等） */
    ESGUI_CMD_OVERLAY_ADD,      /**< 添加覆盖层 */
    ESGUI_CMD_OVERLAY_REMOVE,   /**< 移除覆盖层 */
    ESGUI_CMD_OVERLAY_VISIBLE,  /**< 设置覆盖层可见性 */
    ESGUI_CMD_ANIM_START,       /**< 启动动画 */
    ESGUI_CMD_ANIM_STOP_ALL,    /**< 按 var 停止动画 */
} ESGUI_CmdType_t;

typedef struct {
    ESGUI_CmdType_t type;
    union {
        struct { ESGUI_EventCode_t key; eui_uint32_t now_ms; } key;
        ESGUI_MenuAction_T act;
        struct { ESGUI_Overlay_T *ov; } overlay;                   /**< add / remove */
        struct { ESGUI_Overlay_T *ov; bool visible; } overlay_vis; /**< set visible */
        struct { anim_t *a; } anim_start;                          /**< 动画配置（须保持有效） */
        struct { void *var; } anim_stop_all;                       /**< 匹配的动画 var */
    } u;
} ESGUI_Cmd_T;

typedef struct {
    ESGUI_Cmd_T cmds[ESGUI_CMD_QUEUE_SIZE];
    /* volatile：原子模式配合 __atomic_* 使用；纯软件模式（ESGUI_SYNC_MODE=1）靠它保证发布顺序 */
    volatile eui_uint32_t head;   /**< 生产者写指针 */
    volatile eui_uint32_t tail;   /**< 消费者写指针 */
} ESGUI_CmdQueue_T;

/* ==================== 多生产者收拢（单生产者收件箱） ==================== */

/**
 * @brief 生产者收件箱（单生产者-单消费者，无锁）
 * @note  用于"单生产者收拢"：当有多个任务需要调用 UI 时，
 *        让每个任务各自持有一个收件箱（本任务是唯一生产者），
 *        UI 线程在 ESGUI_Tick 内轮询所有已注册收件箱并统一处理（唯一消费者）。
 *        每个收件箱与主命令队列使用相同的 SPSC 不变量与同步宏，
 *        因此同样支持 ESGUI_SYNC_MODE=0（多核安全）与 =1（纯软件单核）。
 */
typedef struct esgui_producer_box {
    ESGUI_Cmd_T cmds[ESGUI_PRODUCER_BOX_CAP];
    volatile eui_uint32_t head;   /**< 生产者（所属任务）写指针 */
    volatile eui_uint32_t tail;   /**< 消费者（UI 线程）读指针 */
} ESGUI_ProducerBox_T;

#endif /* ESGUI_ENABLE_MULTITHREAD */


typedef struct esgui {
    void *draw_ctx;

    refresh refresh_cb;  // 刷新回调

    anim_tick anim_tick_cb;    //动画刷新回调

    ESGUI_MenuCtrl_T menu_ctrl;

#if ESGUI_ENABLE_MULTITHREAD
    /* 命令队列：ESGUI_FeedKey / ESGUI_*Async 入队，ESGUI_Tick 出队处理 */
    ESGUI_CmdQueue_T cmd_queue;

    /* 多生产者收拢：各任务注册自己的 SPSC 收件箱，UI 线程在 Tick 内轮询收拢 */
    ESGUI_ProducerBox_T *producer_boxes[ESGUI_MAX_PRODUCER];
    eui_uint8_t producer_box_count;
#endif

    /* 覆盖层列表：常驻显示的组件，叠加在页面/弹窗之上（下标越小越靠底层） */
    ESGUI_Overlay_T *overlays[ESGUI_MAX_OVERLAY];
    eui_uint8_t overlay_count;
}ESGUI_T;


//初始化函数
void ESGUI_Init(ESGUI_T *ui,
                ESGUI_MenuPage_T *first_page,
                refresh refresh_cb,
                anim_tick anim_tick_cb
                );

/* 外部输入入口：将按键事件入队（无锁，可从任意任务或中断调用） */
void ESGUI_FeedKey(ESGUI_T *ui, ESGUI_EventCode_t key,eui_uint32_t now_ms);

/* 异步入栈/出栈/弹窗：从任意任务投递命令，UI 线程在 ESGUI_Tick 内执行 */
void ESGUI_PushPageAsync(ESGUI_T *ui, ESGUI_MenuPage_T *page);
void ESGUI_PopPageAsync(ESGUI_T *ui);
void ESGUI_ShowPopupAsync(ESGUI_T *ui, ESGUI_PopWindow_T *popup);
void ESGUI_ClosePopupAsync(ESGUI_T *ui);

/* 异步覆盖层管理：从任意任务投递命令，UI 线程在 ESGUI_Tick 内执行 */
void ESGUI_OverlayAddAsync(ESGUI_T *ui, ESGUI_Overlay_T *ov);
void ESGUI_OverlayRemoveAsync(ESGUI_T *ui, ESGUI_Overlay_T *ov);
void ESGUI_OverlaySetVisibleAsync(ESGUI_T *ui, ESGUI_Overlay_T *ov, bool visible);

/* 异步执行任意菜单动作（ACT_REFRESH / ACT_EXIT_APP / 自定义动作等） */
void ESGUI_HandleActionAsync(ESGUI_T *ui, ESGUI_MenuAction_T act);

/* 异步动画：启动 / 按 var 停止（动画配置 a 需保持有效直到 UI 线程处理） */
void ESGUI_AnimStartAsync(ESGUI_T *ui, anim_t *a);
void ESGUI_AnimStopAllAsync(ESGUI_T *ui, void *var);

#if ESGUI_ENABLE_MULTITHREAD
/* ==================== 生产者收件箱（多生产者收拢） ====================
 * 当有多个任务需要调用 UI 时，为每个任务分配一个收件箱并注册：
 *   任务内    ：ESGUI_ProducerBoxPushKey / PushAction / Push 入自己的收件箱（SPSC 无锁）
 *   UI 线程   ：ESGUI_Tick 自动轮询所有已注册收件箱，统一处理命令
 * 前提：每个收件箱只允许"所属任务"这一个生产者；注册须在任务启动前（init 阶段）完成。 */

/** @brief 初始化收件箱（所属任务启动时调用一次） */
void ESGUI_ProducerBoxInit(ESGUI_ProducerBox_T *box);

/** @brief 将收件箱注册到 UI（init 阶段、单线程调用；重复注册安全） */
bool ESGUI_ProducerBoxRegister(ESGUI_T *ui, ESGUI_ProducerBox_T *box);

/** @brief 投递一个命令（可自行构造 ESGUI_Cmd_T 以支持覆盖层/动画等） */
void ESGUI_ProducerBoxPush(ESGUI_ProducerBox_T *box, const ESGUI_Cmd_T *cmd);

/** @brief 便捷：投递按键事件（等价于 ESGUI_FeedKey 的异步版） */
void ESGUI_ProducerBoxPushKey(ESGUI_ProducerBox_T *box, ESGUI_EventCode_t key, eui_uint32_t now_ms);

/** @brief 便捷：投递菜单动作（等价于 ESGUI_HandleActionAsync 的异步版） */
void ESGUI_ProducerBoxPushAction(ESGUI_ProducerBox_T *box, ESGUI_MenuAction_T act);
#endif /* ESGUI_ENABLE_MULTITHREAD */

/* UI 线程调用：先取出并处理排队的命令（按键 + 菜单动作），再更新动画与绘制 */
void ESGUI_Tick(ESGUI_T *ui, eui_uint32_t now_ms);

/* 覆盖层管理：常驻显示的图形/组件，叠加在页面与弹窗之上 */
bool ESGUI_OverlayAdd(ESGUI_T *ui, ESGUI_Overlay_T *ov);
bool ESGUI_OverlayRemove(ESGUI_T *ui, ESGUI_Overlay_T *ov);
void ESGUI_OverlaySetVisible(ESGUI_T *ui, ESGUI_Overlay_T *ov, bool visible);

#endif //ESGUI_ESGUI_H
