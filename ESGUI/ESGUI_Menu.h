//
// Created by E_LJF on 2026/6/4.
//

#ifndef ESGUI_ESGUI_MENU_H
#define ESGUI_ESGUI_MENU_H

#include "ESGUI_Event.h"
#include "main.h"
#include "stdbool.h"


#define ESGUI_MAX_MENU_DEPTH    8   //最大菜单深度
#define ESGUI_ITEM_NUM_COUNT(arr)  (sizeof(arr) / sizeof((arr)[0]))  //item_num自动计算宏


//移动焦点到下一个位置，自动限位
#define FocusUP(focus,num) ((focus) = ((focus) + 1) > ((num) - 1) ? ((num) - 1) : ((focus) + 1))
//移动焦点到上一个位置，自动限位
#define FocusDOWN(focus) ((focus) = (focus) == 0 ? 0 : ((focus) - 1))


typedef enum menu_action_enum {
    ACT_NONE = 0,       // 无动作
    ACT_PUSH_PAGE,      // param = menu_page_t*  压入新页面
    ACT_POP_PAGE,       // 无参数，返回上一页
    ACT_SHOW_POPUP,     // param = menu_page_t*  显示弹窗
    ACT_CLOSE_POPUP,    // 无参数，关闭弹窗
    ACT_REFRESH,        // 无参数，标记需要重绘
    ACT_EXIT_APP,       // 无参数，退出应用
}ESGUI_MenuAction_ENUM;


typedef struct menu_action{
    ESGUI_MenuAction_ENUM act;
    void *param;        // 根据 act 携带不同数据
} ESGUI_MenuAction_T;


typedef struct esgui_menu_page ESGUI_MenuPage_T;

/* 页面虚函数表：面向对象思想，C 里用函数指针表实现多态 */
typedef struct {
    void (*on_create)(ESGUI_MenuPage_T *page);      // 分配资源，初始化页面
    void (*on_destroy)(ESGUI_MenuPage_T *page);     // 释放图片、内存等
    void (*on_draw)(ESGUI_MenuPage_T *page); // 绘制背景 + 所有项
    uint16_t (*special_item_draw)(ESGUI_MenuPage_T *page,uint16_t indx);//特殊条目绘制函数，返回特殊绘制需要的空间(像素)
    uint16_t (*get_special_item_draw_w)(ESGUI_MenuPage_T *page,uint16_t indx);//获取特殊条目所占宽度函数，返回特殊绘制需要的空间(像素)
    ESGUI_MenuAction_T (*on_input)(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e); // 默认框架处理焦点，特殊情况覆盖
    void (*on_focus_change)(ESGUI_MenuPage_T *page, uint16_t old_idx, uint16_t new_idx); // 焦点变化通知（播放音效、启动动画）
    void (*on_page_chenge)(ESGUI_MenuPage_T *page,ESGUI_MenuAction_T *action);//页面切换回调函数，页面切换时触发
} esgui_page_vtable_t;



//统一条目抽象，将文本菜单和图形菜单条目抽象成一个类型
typedef struct esgui_menu_item
{
    int x;  //条目横坐标
    int y;  //条目纵坐标

    const char *label;          // 文本，图形菜单可为 NULL 或作为图注
    void *icon;                 // 图片数据（你的图形库格式），NULL 表示无图
    ESGUI_MenuAction_T (*on_enter)(ESGUI_MenuPage_T *page,void *arg); // 回调函数,按确定后跳转/执行
    void *arg;  //用户自定义参数

}ESGUI_MenuItem_T;



//统一页面抽象，文本菜单和图形菜单抽象成同一类型
typedef struct esgui_menu_page {
    const esgui_page_vtable_t *vtbl;    //方法函数表
    const char *title;  //页面标题，可有可无

    ESGUI_MenuItem_T *items;    //页面条目数组指针
    uint16_t item_num;          //条目数量,自动计算
    uint16_t focus_idx;         //焦点条目索引，即哪个条目被选中

    void *render_ctx;           // 系统渲染上下文（如 CanvasStripIter），由 ESGUI_Tick 注入，页面不用操作

    void *draw_data;            // 页面私有绘制数据，由 vtbl 的 on_create 分配，on_destroy 释放

    void *user_data;            // 用户自定义数据，框架完全不操作
}ESGUI_MenuPage_T;



typedef struct esgui_pop_window {
    const esgui_page_vtable_t *vtbl;    //方法函数表
    const char *title;  //页面标题，可有可无

    ESGUI_MenuItem_T *items;    //页面条目数组指针
    uint16_t item_num;          //条目数量,自动计算
    uint16_t focus_idx;         //焦点条目索引，即哪个条目被选中

    void *render_ctx;           // 系统渲染上下文，由 ESGUI_Tick 注入

    void *draw_data;            // 页面私有绘制数据，由 vtbl 的 on_create 分配，on_destroy 释放

    void *user_data;            // 用户自定义数据，框架完全不操作

    uint16_t window_w;          //弹窗宽度
    uint16_t window_h;          //弹窗高度

    int window_x;
    int window_y;
}ESGUI_PopWindow_T;


//菜单管理器
typedef struct esgui_menu_ctrl {
    ESGUI_MenuPage_T *page_stack[ESGUI_MAX_MENU_DEPTH];
    uint8_t menu_depth;
    ESGUI_PopWindow_T *pop_window;
    ESGUI_EventCode_t last_event;
    uint32_t last_key_tick;
    uint32_t repeat_delay_ms;
    uint8_t running_en  : 1;
    uint8_t pop_window_en : 1;
    uint8_t need_refresh : 1;
    uint8_t anim_running : 1;
    uint8_t pending_pop : 1;
    uint8_t pending_done : 1;
    ESGUI_MenuPage_T *pending_destroy_page;

    /* 新增：Push 页面时先让旧页面执行退出动画，再真正压栈 */
    uint8_t pending_push : 1;
    ESGUI_MenuPage_T *pending_push_page;
} ESGUI_MenuCtrl_T;


void ESGUI_MenuCtrlInit(ESGUI_MenuCtrl_T *emc);
void ESGUI_MenuCtrlPushPage(ESGUI_MenuCtrl_T *emc, ESGUI_MenuPage_T *page); // 进入新页面
void ESGUI_MenuCtrlPopPage(ESGUI_MenuCtrl_T *emc);                     // 返回
void ESGUI_MenuCtrlShowPopWindow(ESGUI_MenuCtrl_T *emc, ESGUI_PopWindow_T *popup); // 显示弹窗（模态）
void ESGUI_MenuCtrlClosePopWindow(ESGUI_MenuCtrl_T *emc);
void ESGUI_MenuCtrlHandleAction(ESGUI_MenuCtrl_T *emc, ESGUI_MenuAction_T *act);

bool ESGUI_MenuCtrlPreparePopPage(ESGUI_MenuCtrl_T *emc);
void ESGUI_MenuCtrlExecPendingPop(ESGUI_MenuCtrl_T *emc);

#endif //ESGUI_ESGUI_MENU_H
