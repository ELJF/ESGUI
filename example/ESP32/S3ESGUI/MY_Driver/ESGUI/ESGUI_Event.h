//
// Created by E_LJF on 2026/6/4.
//

#ifndef ESGUI_ESGUI_EVENT_H
#define ESGUI_ESGUI_EVENT_H

//事件代码枚举
typedef enum {
    EVT_NONE = 0,
    EVT_DRAW,            // 绘制请求
    EVT_FOCUS_ENTER,     // 获得焦点
    EVT_FOCUS_LEAVE,     // 失去焦点
    EVT_KEY_UP,
    EVT_KEY_DOWN,
    EVT_KEY_LEFT,
    EVT_KEY_RIGHT,
    EVT_KEY_OK,
    EVT_KEY_BACK,
    EVT_CLICKED,         // 触摸/编码器按下后释放，等价于 KEY_OK
    EVT_VALUE_CHANGED,   // 值被修改（弹窗用）
    EVT_REFRESH,         // 手动触发刷新
    EVT_CUSTOM = 0x100   // 用户自定义起始
} ESGUI_EventCode_t;

#endif //ESGUI_ESGUI_EVENT_H
