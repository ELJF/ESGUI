// //
// // Created by E_LJF on 2026/6/6.
// //
//
// #include "eui_test_page.h"
#include "ESGUI_PageDefaltVtbl.h"
#include "MY_BMP.h"
#include "stdio.h"
#include "string.h"


//页面实例
ESGUI_MenuPage_T text_page,bmp_page;
//弹窗实例及演示变量
static ESGUI_PopWindow_T pop_window;
static bool b_val = 0;
static uint16_t u16_val = 0;





/**
     * @brief 获取当前值的千分比位置
     * @param ctx  用户数据指针
     * @return     0~1000 的千分比，用于进度条显示
     */
uint16_t ValueDesc_uint16_get_permille(void *ctx) {
    if (ctx == NULL) return 0;

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
    if (ctx == NULL) return 0;
    sniprintf(buf, size, "%d", *(uint16_t*)ctx);
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
    if (ctx == NULL) return false;

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



//文本列表弹窗条目描述
static ESGUI_MenuItem_T text_list_popwindow_item[] =
    {
    {0,0,"wen ben ",NULL,NULL,NULL},
    {0,0,"文本一",NULL,NULL,NULL},
    {0,0,"文本二",NULL,NULL,NULL},
    {0,0,"长文本演示----chang wen ben yan shi ",NULL,NULL,NULL},
};



//图形列表弹窗条目描述
static ESGUI_MenuItem_T bmp_list_popwindow_item[] =
{
    {0,0,"Computer",&bmp_Computer32x32,NULL,NULL},
    {0,0,"File",&bmp_File32x32,NULL,NULL},
    {0,0,"MCU",&bmp_MCU32x32,NULL,NULL},
};



//文本菜单----消息弹窗条目回调
static ESGUI_MenuAction_T message_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认消息弹窗
    // ESGUI_DefaultMessagePopWindowCreate(&pop_window,"TEST MESSAGE\n123",100,50,1);
    ESGUI_DefaultMessageScrollTitlePopWindowCreate(&pop_window,"TEST MESSAGE 123",100,50,1);
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}


//文本菜单----布尔弹窗条目回调
static ESGUI_MenuAction_T bool_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认布尔弹窗
    // ESGUI_DefaultBoolPopWindowCreate(&pop_window,"  Bool Pop\n  Window",100,50,arg);
    ESGUI_DefaultBoolScrollTitlePopWindowCreate(&pop_window,"  Bool Pop  Window",100,50,arg);
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}


//文本菜单----值弹窗条目回调
static ESGUI_MenuAction_T value_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认值弹窗
    // ESGUI_DefaultValuePopWindowCreate(&pop_window,"  Value Pop\n  Window",100,50,&value_desc);
    ESGUI_DefaultValueScrollTitlePopWindowCreate(&pop_window,"  Value Pop  Window",100,50,&value_desc);
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}


//文本菜单----文本列表条目回调
static ESGUI_MenuAction_T text_list_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认文本列表弹窗
    // ESGUI_DefaultTextListPopWindowCreate(&pop_window,100,50,text_list_popwindow_item,ESGUI_ITEM_NUM_COUNT(text_list_popwindow_item));
    ESGUI_DefaultTextListScrollTitlePopWindowCreate(&pop_window,"长标题12345789------abcdef",100,50,text_list_popwindow_item,ESGUI_ITEM_NUM_COUNT(text_list_popwindow_item));
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}







//图形菜单----图片条目回调
static ESGUI_MenuAction_T bmp_list_window_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    // ESGUI_DefaultBMPListPopWindowCreate(&pop_window,"BMP W",100,50,bmp_list_popwindow_item,ESGUI_ITEM_NUM_COUNT(bmp_list_popwindow_item));
    ESGUI_DefaultBMPListScrollTitlePopWindowCreate(&pop_window,"BMP W------0123456----",100,50,bmp_list_popwindow_item,ESGUI_ITEM_NUM_COUNT(bmp_list_popwindow_item));
    return (ESGUI_MenuAction_T){ACT_SHOW_POPUP,&pop_window};
}








//前向声明
static ESGUI_MenuAction_T bmp_menu_item_on_enter(ESGUI_MenuPage_T *page,void *arg);

//文本页面条目描述
static ESGUI_MenuItem_T text_menu_item[] =
    {
    {0,0,"123",NULL,NULL,NULL},
    {0,0,"页面一\x03/0",NULL,NULL,NULL},
    {0,0,"消息弹窗",NULL,message_window_item_on_enter,NULL},
    {0,0,"布尔弹窗\x03/2",NULL,bool_window_item_on_enter,&b_val},
    {0,0,"值弹窗\x03/2",NULL,value_window_item_on_enter,&u16_val},
    {0,0,"文本列表弹窗\x03/2",NULL,text_list_window_item_on_enter,&pop_window.focus_idx},
    {0,0,"图形页面",NULL,bmp_menu_item_on_enter,&bmp_page},
    {0,0,"长文本测试chang wen ben ce shi 12345",NULL,NULL,NULL},
};





//图形页面条目描述
static ESGUI_MenuItem_T bmp_menu_item[] =
    {
    {0,0,"Computer",&bmp_Computer32x32,NULL,NULL},
    {0,0,"File",&bmp_File32x32,NULL,NULL},
    {0,0,"MCU",&bmp_MCU32x32,NULL,NULL},
    {0,0,"闪电",&bmp_Lightning8x16,NULL,NULL},
    {0,0,"Picture",&bmp_Picture32x32,bmp_list_window_item_on_enter,NULL},
    {0,0,"Setting",&bmp_Setting32x32,NULL,NULL},
};

//文本菜单----图形页面条目回调
static ESGUI_MenuAction_T bmp_menu_item_on_enter(ESGUI_MenuPage_T *page,void *arg) {
    //创建默认图形页面
    ESGUI_DefaultBMPMenuCreate(&bmp_page,"Label",bmp_menu_item,ESGUI_ITEM_NUM_COUNT(bmp_menu_item));
    return (ESGUI_MenuAction_T){ACT_PUSH_PAGE,arg};
}



//演示页面初始化
void eui_test_page_init() {
    //创建默认文本页面
    ESGUI_DefaltTextMenuCreate(&text_page,text_menu_item,"Text Page",ESGUI_ITEM_NUM_COUNT(text_menu_item));
}



