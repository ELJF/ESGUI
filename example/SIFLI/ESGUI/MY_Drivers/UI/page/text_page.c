//
// Created by E_LJF on 2026/8/17.
//

#include "text_page.h"
#include "ESGUI_PageDefaltVtbl.h"
#include "stdio.h"
#include "string.h"
#include "bmp_page.h"
#include "ESGUI_3D.h"
#include "model_page.h"
#include "MY_BMP.h"
#include "model_3d.h"

#if ESGUI_ENABLE_TEXT_MENU

//页面实例
ESGUI_MenuPage_T text_page;

//弹窗实例及演示变量
static ESGUI_PopWindow_T pop_window;
static bool b_val = 0;
static eui_uint16_t u16_val = 0;

#if  ESGUI_ENABLE_POPUP_VALUE || ESGUI_ENABLE_POPUP_VALUE_SCROLL_TITLE
/**
     * @brief 获取当前值的千分比位置
     * @param ctx  用户数据指针
     * @return     0~1000 的千分比，用于进度条显示
     */
uint16_t ValueDesc_uint16_get_permille(void *ctx) {
    if (ctx == ESGUI_NULL) return 0;

    return  *(uint16_t*)ctx * 1000 / 100;
}


/**
     * @brief 将当前值格式化为显示字符串
     * @param ctx   用户数据指针
     * @param buf   输出缓冲区
     * @param size  缓冲区大小
     * @return      实际写入长度
     *
     * 示例：int 值 → "123"，float → "3.14"，枚举 → "模式A"
     */
uint8_t ValueDesc_uint16_to_string(void *ctx, char *buf, uint16_t size) {
    if (ctx == ESGUI_NULL) return 0;
    snprintf(buf, size, "%d", *(uint16_t*)ctx);
    return strlen(buf);
}




/**
 * @brief 步进值
 * @param ctx       用户数据指针
 * @param direction +1=增加，-1=减少
 * @return          true=值发生了变化；false=到达边界无法继续
 *
 * 用户在此函数内部实现限幅、循环、步长控制等逻辑
 */
bool ValueDesc_uint16_step(void *ctx, int8_t direction) {
    if (ctx == ESGUI_NULL) return false;

    uint16_t val = *((uint16_t*)ctx);

    if (direction > 0) {
        val += val < 100 ? 1 : 0;
    }else {
        val -= val > 0 ? 1 : 0;
    }

    *(uint16_t*)ctx =val;

    return true;
}



//uint_16类型对应的值描述符
static ESGUI_ValueDesc_T value_desc =
    {
    .ctx = &u16_val,
    .get_permille = ValueDesc_uint16_get_permille,
    .to_string = ValueDesc_uint16_to_string,
    .step = ValueDesc_uint16_step,
};
#endif



#if ESGUI_ENABLE_BMP_MENU
//文本菜单----图形页面条目回调
static ESGUI_MenuAction_T bmp_menu_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认图形页面
    ESGUI_DefaultBMPMenuCreate(&bmp_page,"Label",bmp_menu_item,ESGUI_ITEM_NUM_COUNT(bmp_menu_item));
    return (ESGUI_MenuAction_T){ACT_PUSH_PAGE,arg};
}
#endif




#if ESGUI_ENABLE_3D && ESGUI_ENABLE_3D_MENU
//文本菜单----3D菜单创建回调
static ESGUI_MenuAction_T three_d_menu_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    (void)page;
    ESGUI_Default3DMenuCreate(&three_d_page,"3D Menu",three_d_menu_item,ESGUI_ITEM_NUM_COUNT(three_d_menu_item));
    return (ESGUI_MenuAction_T){ACT_PUSH_PAGE,arg};
}
#endif




eui_uint8_t esgui_overlay_en = 0;
ESGUI_Overlay_T overlay;
extern ESGUI_T ui;

static void over_item_on_draw(ESGUI_Overlay_T *ov){
#if ESGUI_ENABLE_3D
    ESGUI_3DTransform_T t;
    static eui_uint16_t angle = 0;
    angle = (angle + 1) % 360;
    ESGUI_3DTransformInit(&t);
    t.ty = 20;
    t.scale_q8 = 150;
    ESGUI_3DTransformRotate(&t,ESGUI_3D_AXIS_Z,angle);
    ESGUI_3DWireframeDiagram(((CanvasStripIter*)ov->render_ctx)->canvas,&cube,&t,ESGUI_3D_MENU_FOCAL,128,128,EUI_MODE_SET);
    angle++;
#else
    eui_draw_circle_box(((CanvasStripIter*)ov->render_ctx)->canvas,20,20,10,EUI_MODE_SET);
    eui_draw_rect_fill(((CanvasStripIter*)ov->render_ctx)->canvas,40,0,60,20,EUI_MODE_SET);
#endif

}

static ESGUI_MenuAction_T over_lay_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    if (page == ESGUI_NULL) return (ESGUI_MenuAction_T){ACT_NONE,ESGUI_NULL};
    switch (page->focus_idx) {
        case 4:
            overlay.on_draw = over_item_on_draw;
            /* render_ctx 由框架在每次绘制前自动注入，无需手动设置 */
            overlay.visible = 1;
            overlay.always_dirty = 1;
            ESGUI_OverlayAdd(&ui,&overlay);
            break;

        case 5:
            ESGUI_OverlayRemoveAsync(&ui,&overlay);
            break;

        default:
            break;
    }
    return (ESGUI_MenuAction_T){ACT_NONE,ESGUI_NULL};
}





#if ESGUI_ENABLE_POPUP_TEXTLIST || ESGUI_ENABLE_POPUP_TEXTLIST_SCROLL_TITLE
//文本列表弹窗条目描述
static ESGUI_MenuItem_T text_list_popwindow_item[] =
{
    {0,0,"wen ben ",ESGUI_NULL,ESGUI_NULL,ESGUI_NULL},
    {0,0,"文本一",ESGUI_NULL,ESGUI_NULL,ESGUI_NULL},
    {0,0,"文本二",ESGUI_NULL,ESGUI_NULL,ESGUI_NULL},
    {0,0,"长文本演示----chang wen ben yan shi ",ESGUI_NULL,ESGUI_NULL,ESGUI_NULL},
};


#if ESGUI_ENABLE_POPUP_TEXTLIST_SCROLL_TITLE
//文本菜单----滚动文本列表条目回调
static ESGUI_MenuAction_T text_list_scroll_window_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    ESGUI_DefaultTextListScrollTitlePopWindowCreate(&pop_window,"滚动文本列表弹窗----abcdef",100,50,text_list_popwindow_item,ESGUI_ITEM_NUM_COUNT(text_list_popwindow_item));
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}
#endif



#if ESGUI_ENABLE_POPUP_TEXTLIST
//文本菜单----普通文本列表条目回调
static ESGUI_MenuAction_T text_list_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认文本列表弹窗
    ESGUI_DefaultTextListPopWindowCreate(&pop_window,100,50,text_list_popwindow_item,ESGUI_ITEM_NUM_COUNT(text_list_popwindow_item));
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}
#endif


#endif




#if ESGUI_ENABLE_POPUP_MESSAGE
//文本菜单----普通消息弹窗条目回调
static ESGUI_MenuAction_T message_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认消息弹窗
    ESGUI_DefaultMessagePopWindowCreate(&pop_window,"普通消息弹窗\nTEST MESSAGE",100,50,1);
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}
#endif


#if ESGUI_ENABLE_POPUP_MESSAGE_SCROLL_TITLE
//文本菜单----滚动消息弹窗条目回调
static ESGUI_MenuAction_T message_scroll_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认消息弹窗
    ESGUI_DefaultMessageScrollTitlePopWindowCreate(&pop_window,"滚动消息弹窗 TEST MESSAGE 123",100,50,1);
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}
#endif



#if ESGUI_ENABLE_POPUP_BOOL
//文本菜单----布尔弹窗条目回调
static ESGUI_MenuAction_T bool_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认布尔弹窗
    ESGUI_DefaultBoolPopWindowCreate(&pop_window,"普通布尔弹窗\n  Bool",100,50,arg);
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}
#endif

#if ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE
//文本菜单----滚动布尔弹窗条目回调
static ESGUI_MenuAction_T bool_scroll_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认布尔弹窗
    // ESGUI_DefaultBoolPopWindowCreate(&pop_window,"  Bool Pop\n  Window",100,50,arg);
    ESGUI_DefaultBoolScrollTitlePopWindowCreate(&pop_window,"滚动布尔弹窗-----Bool",100,50,arg);
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}
#endif



#if ESGUI_ENABLE_POPUP_VALUE
//文本菜单----普通值弹窗条目回调
static ESGUI_MenuAction_T value_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认值弹窗
    ESGUI_DefaultValuePopWindowCreate(&pop_window,"  普通值弹窗",100,50,&value_desc);
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}
#endif


#if ESGUI_ENABLE_POPUP_VALUE_SCROLL_TITLE
//文本菜单----滚动值弹窗条目回调
static ESGUI_MenuAction_T value_scroll_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认值弹窗
    ESGUI_DefaultValueScrollTitlePopWindowCreate(&pop_window,"  滚动值弹窗-----Value Pop  Window",100,50,&value_desc);
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}
#endif





#if ESGUI_ENABLE_POPUP_BMPLIST || ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE
//图形列表弹窗条目描述
static ESGUI_MenuItem_T bmp_list_popwindow_item[] =
{
    {0,0,"Computer",&bmp_Computer32x32,ESGUI_NULL,ESGUI_NULL},
    {0,0,"File",&bmp_File32x32,ESGUI_NULL,ESGUI_NULL},
    {0,0,"MCU",&bmp_MCU32x32,ESGUI_NULL,ESGUI_NULL},
};


#if ESGUI_ENABLE_POPUP_BMPLIST
//图形菜单----普通图片条目回调
static ESGUI_MenuAction_T bmp_list_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    ESGUI_DefaultBMPListPopWindowCreate(&pop_window,"普通图片弹窗",100,60,bmp_list_popwindow_item,ESGUI_ITEM_NUM_COUNT(bmp_list_popwindow_item));
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}
#endif


#if ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE
//图形菜单----滚动图片条目回调
static ESGUI_MenuAction_T bmp_list_scroll_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    ESGUI_DefaultBMPListScrollTitlePopWindowCreate(&pop_window,"滚动图片弹窗------0123456----",100,60,bmp_list_popwindow_item,ESGUI_ITEM_NUM_COUNT(bmp_list_popwindow_item));
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}
#endif


#endif






//文本页面条目描述
static ESGUI_MenuItem_T text_menu_item[] =
    {
    {0,0,"长文本测试chang wen ben ce shi 12345",ESGUI_NULL,ESGUI_NULL,ESGUI_NULL},
    {0,0,"↓页面演示↓",ESGUI_NULL,ESGUI_NULL,ESGUI_NULL},

#if ESGUI_ENABLE_BMP_MENU
    {0,0,"图形页面",ESGUI_NULL,bmp_menu_item_on_enter,&bmp_page},
#endif


#if (ESGUI_ENABLE_3D && ESGUI_ENABLE_3D_MENU)
    {0,0,"3D 页面",ESGUI_NULL,three_d_menu_item_on_enter,&three_d_page},
#endif


    {0,0,"Over Lay ON",ESGUI_NULL,over_lay_item_on_enter,ESGUI_NULL},
    {0,0,"Over Lay OFF",ESGUI_NULL,over_lay_item_on_enter,ESGUI_NULL},


    {0,0,"↓弹窗演示↓",ESGUI_NULL,ESGUI_NULL,ESGUI_NULL},



#if ESGUI_ENABLE_POPUP_TEXTLIST
    {0,0,"普通文本列表弹窗\x03/2",ESGUI_NULL,text_list_window_item_on_enter,&pop_window.focus_idx},
#endif

#if ESGUI_ENABLE_POPUP_TEXTLIST_SCROLL_TITLE
    {0,0,"滚动文本列表弹窗\x03/2",ESGUI_NULL,text_list_scroll_window_on_enter,&pop_window.focus_idx},
#endif




#if ESGUI_ENABLE_POPUP_MESSAGE
    {0,0,"普通消息弹窗",ESGUI_NULL,message_window_item_on_enter,ESGUI_NULL},
#endif


#if ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE
    {0,0,"滚动消息弹窗",ESGUI_NULL,message_scroll_window_item_on_enter,ESGUI_NULL},
#endif



#if ESGUI_ENABLE_POPUP_BOOL
    {0,0,"普通布尔弹窗\x03/2",ESGUI_NULL,bool_window_item_on_enter,&b_val},
#endif


#if ESGUI_ENABLE_POPUP_BOOL_SCROLL_TITLE
    {0,0,"滚动布尔弹窗\x03/2",ESGUI_NULL,bool_scroll_window_item_on_enter,&b_val},
#endif


#if ESGUI_ENABLE_POPUP_VALUE
    {0,0,"普通值弹窗\x03/2",ESGUI_NULL,value_window_item_on_enter,&u16_val},
#endif


#if ESGUI_ENABLE_POPUP_VALUE_SCROLL_TITLE
    {0,0,"滚动值弹窗\x03/2",ESGUI_NULL,value_scroll_window_item_on_enter,&u16_val},
#endif


#if ESGUI_ENABLE_POPUP_BMPLIST
    {0,0,"普通图片弹窗",ESGUI_NULL,bmp_list_window_item_on_enter,&u16_val},
#endif

#if ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE
    {0,0,"滚动图片窗",ESGUI_NULL,bmp_list_scroll_window_item_on_enter,&u16_val},
#endif
};




//演示页面初始化
void eui_test_page_init() {
    //创建默认文本页面
    ESGUI_DefaltTextMenuCreate(&text_page,text_menu_item,"Text Page",ESGUI_ITEM_NUM_COUNT(text_menu_item));
}

#endif
