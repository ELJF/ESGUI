//
// Created by E_LJF on 2026/8/17.
//

#include "model_page.h"
#include "ESGUI.h"
#include "model_3d.h"


#if (ESGUI_ENABLE_3D && ESGUI_ENABLE_3D_MENU)
ESGUI_MenuPage_T three_d_page;

//3D 菜单条目描述（icon 指向 ESGUI_3D_T 模型）
ESGUI_MenuItem_T three_d_menu_item[] =
{
    {0,0,"Cube",&cube,ESGUI_NULL,ESGUI_NULL},
    {0,0,"Penguin",&penguin,ESGUI_NULL,ESGUI_NULL},
    {0,0,"sphere",&sphere,ESGUI_NULL,ESGUI_NULL},
    {0,0,"house",&house,ESGUI_NULL,ESGUI_NULL},
    {0,0,"tower",&tower,ESGUI_NULL,ESGUI_NULL},
    {0,0,"fish",&fish,ESGUI_NULL,ESGUI_NULL},
};

#endif