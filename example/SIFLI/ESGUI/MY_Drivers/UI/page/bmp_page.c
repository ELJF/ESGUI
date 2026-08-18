//
// Created by E_LJF on 2026/8/17.
//

#include "bmp_page.h"
#include "MY_BMP.h"
#include "ESGUI_PageDefaltVtbl.h"

#if ESGUI_ENABLE_BMP_MENU

ESGUI_MenuPage_T bmp_page;

//图形页面条目描述
ESGUI_MenuItem_T bmp_menu_item[] =
{
    {0,0,"Computer",&bmp_Computer32x32,ESGUI_NULL,ESGUI_NULL},
    {0,0,"File",&bmp_File32x32,ESGUI_NULL,ESGUI_NULL},
    {0,0,"MCU",&bmp_MCU32x32,ESGUI_NULL,ESGUI_NULL},
    {0,0,"闪电",&bmp_Lightning8x16,ESGUI_NULL,ESGUI_NULL},
    {0,0,"Picture",&bmp_Picture32x32,ESGUI_NULL,ESGUI_NULL},
    {0,0,"Setting",&bmp_Setting32x32,ESGUI_NULL,ESGUI_NULL},
};
#endif
