//
// Created by E_LJF on 2026/5/28.
//

#include "ESGUI.h"
#include "ESGUI_Anim.h"
#include "string.h"


#if ESGUI_ENABLE_MULTITHREAD

#if ESGUI_ENABLE_CMD_QUEUE
/* ==================== 命令队列（单生产者-单消费者） ====================
 * head/tail 统一通过 ESGUI_SYNC_* 宏访问（见 ESGUI.h 编译器原子适配层）：
 *   ESGUI_SYNC_MODE=0 + GCC/Clang → 内建原子（多核安全）；
 *   其他编译器或 ESGUI_SYNC_MODE=1 → volatile（单核语义）。
 * 不变量：生产者"先写数据、后发布 head"；消费者"先读 head、再读数据、最后发布 tail"。 */

static void esgui_cmd_queue_push(ESGUI_T *ui, const ESGUI_Cmd_T *cmd)
{
    ESGUI_CmdQueue_T *q = &ui->cmd_queue;
    eui_uint32_t head = ESGUI_SYNC_LOAD32(&q->head);
    eui_uint32_t tail = ESGUI_SYNC_LOAD32_ACQUIRE(&q->tail);

    if ((eui_uint32_t)(head - tail) >= ESGUI_CMD_QUEUE_SIZE) {
        return;   /* 队列满：丢弃本次命令（可接受） */
    }

    q->cmds[head & (ESGUI_CMD_QUEUE_SIZE - 1)] = *cmd;   /* 先写数据 */
    ESGUI_SYNC_STORE32_RELEASE(&q->head, head + 1);      /* 后发布 head */
}

static bool esgui_cmd_queue_pop(ESGUI_T *ui, ESGUI_Cmd_T *out)
{
    ESGUI_CmdQueue_T *q = &ui->cmd_queue;
    eui_uint32_t tail = ESGUI_SYNC_LOAD32(&q->tail);
    eui_uint32_t head = ESGUI_SYNC_LOAD32_ACQUIRE(&q->head);

    if (tail == head) {
        return false;   /* 队列空 */
    }

    *out = q->cmds[tail & (ESGUI_CMD_QUEUE_SIZE - 1)];   /* 先读数据 */
    ESGUI_SYNC_STORE32_RELEASE(&q->tail, tail + 1);      /* 后发布 tail */
    return true;
}
#endif /* ESGUI_ENABLE_CMD_QUEUE */


#if ESGUI_ENABLE_PRODUCER_BOX
/* ==================== 生产者收件箱（多生产者收拢） ====================
 * 每个需要跨任务调用 UI 的任务持有一个收件箱（本任务=唯一生产者），
 * UI 线程在 ESGUI_Tick 内轮询所有已注册收件箱统一处理（唯一消费者）。
 * 收件箱与主命令队列使用相同的 SPSC 不变量与同步宏，无新增同步原语。 */

void ESGUI_ProducerBoxInit(ESGUI_ProducerBox_T *box)
{
    if (box == ESGUI_NULL) return;
    memset(box, 0, sizeof(*box));
}

bool ESGUI_ProducerBoxRegister(ESGUI_T *ui, ESGUI_ProducerBox_T *box)
{
    if (ui == ESGUI_NULL || box == ESGUI_NULL) return false;

    /* 防重复注册 */
    for (eui_uint8_t i = 0; i < ui->producer_box_count; i++) {
        if (ui->producer_boxes[i] == box) return true;
    }
    if (ui->producer_box_count >= ESGUI_MAX_PRODUCER) return false;

    ui->producer_boxes[ui->producer_box_count++] = box;
    return true;
}

void ESGUI_ProducerBoxPush(ESGUI_ProducerBox_T *box, const ESGUI_Cmd_T *cmd)
{
    if (box == ESGUI_NULL || cmd == ESGUI_NULL) return;

    eui_uint32_t head = ESGUI_SYNC_LOAD32(&box->head);
    eui_uint32_t tail = ESGUI_SYNC_LOAD32_ACQUIRE(&box->tail);

    if ((eui_uint32_t)(head - tail) >= ESGUI_PRODUCER_BOX_CAP) {
        return;   /* 收件箱满：丢弃本次命令（可接受） */
    }

    box->cmds[head & (ESGUI_PRODUCER_BOX_CAP - 1)] = *cmd;   /* 先写数据 */
    ESGUI_SYNC_STORE32_RELEASE(&box->head, head + 1);        /* 后发布 head */
}

void ESGUI_ProducerBoxPushKey(ESGUI_ProducerBox_T *box, ESGUI_EventCode_t key, eui_uint32_t now_ms)
{
    if (box == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type         = ESGUI_CMD_KEY;
    cmd.u.key.key    = key;
    cmd.u.key.now_ms = now_ms;
    ESGUI_ProducerBoxPush(box, &cmd);
}

void ESGUI_ProducerBoxPushAction(ESGUI_ProducerBox_T *box, ESGUI_MenuAction_T act)
{
    if (box == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type  = ESGUI_CMD_ACTION;
    cmd.u.act = act;
    ESGUI_ProducerBoxPush(box, &cmd);
}

/* 收件箱出队（仅 UI 线程调用，与主队列同构的 SPSC pop） */
static bool esgui_producer_box_pop(ESGUI_ProducerBox_T *box, ESGUI_Cmd_T *out)
{
    eui_uint32_t tail = ESGUI_SYNC_LOAD32(&box->tail);
    eui_uint32_t head = ESGUI_SYNC_LOAD32_ACQUIRE(&box->head);

    if (tail == head) return false;

    *out = box->cmds[tail & (ESGUI_PRODUCER_BOX_CAP - 1)];
    ESGUI_SYNC_STORE32_RELEASE(&box->tail, tail + 1);
    return true;
}
#endif /* ESGUI_ENABLE_PRODUCER_BOX */

#endif /* ESGUI_ENABLE_MULTITHREAD */


/* 执行一个菜单动作（供 UI 线程调用）：Push 页面时先让旧页面退出动画再延迟压栈 */
static void esgui_execute_action(ESGUI_T *ui, ESGUI_MenuAction_T *act)
{
    if (act->act == ACT_PUSH_PAGE && act->param != ESGUI_NULL && ui->menu_ctrl.menu_depth > 0) {
        ESGUI_MenuPage_T *old_top = ui->menu_ctrl.page_stack[ui->menu_ctrl.menu_depth - 1];
        if (old_top && old_top->vtbl && old_top->vtbl->on_page_chenge) {
            ESGUI_MenuAction_T exit_act = {ACT_POP_PAGE, ESGUI_NULL};
            old_top->vtbl->on_page_chenge(old_top, &exit_act);  /* 启动旧页面退出动画 */
        }
        ui->menu_ctrl.pending_push = 1;
        ui->menu_ctrl.pending_push_page = (ESGUI_MenuPage_T*)act->param;
        ui->menu_ctrl.need_refresh = 1;
    } else {
        ESGUI_MenuCtrlHandleAction(&ui->menu_ctrl, act);
    }
}


void ESGUI_Init(ESGUI_T *ui,
                ESGUI_MenuPage_T *first_page,
                refresh refresh_cb,
                anim_tick anim_tick_cb
                )
{
    if (ui == ESGUI_NULL || first_page == ESGUI_NULL) return;

    memset(ui, 0, sizeof(*ui));

    ui->menu_ctrl.need_refresh = 1;
    ui->refresh_cb = refresh_cb;
    ui->anim_tick_cb = anim_tick_cb;

    ESGUI_MenuCtrlInit(&ui->menu_ctrl);

    //第一页入栈
    ESGUI_MenuCtrlPushPage(&ui->menu_ctrl,first_page);
}


/* 处理单个按键事件（仅供 UI 线程调用） */
static void ESGUI_FeedKey_impl(ESGUI_T *ui, ESGUI_EventCode_t key, eui_uint32_t now_ms) {
    if (ui == ESGUI_NULL) return;

    /* Push/Pop 过渡动画期间屏蔽按键，防止重复触发 */
    if (ui->menu_ctrl.pending_push || ui->menu_ctrl.pending_pop) return;

    /* 消抖与长按加速 */
    if (key == ui->menu_ctrl.last_event && (now_ms - ui->menu_ctrl.last_key_tick) < ui->menu_ctrl.repeat_delay_ms) return;

    ui->menu_ctrl.last_event = key;
    ui->menu_ctrl.last_key_tick = now_ms;
    if (ui->menu_ctrl.repeat_delay_ms > 50) ui->menu_ctrl.repeat_delay_ms -= 40;

    ESGUI_MenuAction_T act = {ACT_NONE, ESGUI_NULL};

    /* 1. 收集动作：发给弹窗或栈顶页面 */
    if (ui->menu_ctrl.pop_window_en && ui->menu_ctrl.pop_window) {
        if (ui->menu_ctrl.pop_window->vtbl->on_input) {
            act = ui->menu_ctrl.pop_window->vtbl->on_input((ESGUI_MenuPage_T*)ui->menu_ctrl.pop_window, key);
        }
    } else if (ui->menu_ctrl.menu_depth > 0) {
        if (ui->menu_ctrl.page_stack[ui->menu_ctrl.menu_depth - 1]->vtbl->on_input) {
            act = ui->menu_ctrl.page_stack[ui->menu_ctrl.menu_depth - 1]->vtbl->on_input(
                ui->menu_ctrl.page_stack[ui->menu_ctrl.menu_depth - 1], key);
        }
    }

    /* 2. 执行动作 */
    if (act.act != ACT_NONE) {
        esgui_execute_action(ui, &act);
    } else {
        ui->menu_ctrl.repeat_delay_ms = 300;
    }
}

/* 外部输入入口：多线程时入队（可从任意任务/中断调用），单线程时直接处理 */
void ESGUI_FeedKey(ESGUI_T *ui, ESGUI_EventCode_t key, eui_uint32_t now_ms) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_KEY;
    cmd.u.key.key = key;
    cmd.u.key.now_ms = now_ms;
    esgui_cmd_queue_push(ui, &cmd);
#else
    ESGUI_FeedKey_impl(ui, key, now_ms);
#endif
}

/* 异步入栈 */
void ESGUI_PushPageAsync(ESGUI_T *ui, ESGUI_MenuPage_T *page) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL || page == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_ACTION;
    cmd.u.act.act = ACT_PUSH_PAGE;
    cmd.u.act.param = page;
    esgui_cmd_queue_push(ui, &cmd);
#else
    if (ui == ESGUI_NULL || page == ESGUI_NULL) return;
    ESGUI_MenuAction_T act = {ACT_PUSH_PAGE, page};
    esgui_execute_action(ui, &act);
#endif
}

/* 异步出栈 */
void ESGUI_PopPageAsync(ESGUI_T *ui) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_ACTION;
    cmd.u.act.act = ACT_POP_PAGE;
    cmd.u.act.param = ESGUI_NULL;
    esgui_cmd_queue_push(ui, &cmd);
#else
    if (ui == ESGUI_NULL) return;
    ESGUI_MenuAction_T act = {ACT_POP_PAGE, ESGUI_NULL};
    esgui_execute_action(ui, &act);
#endif
}

/* 异步显示弹窗 */
void ESGUI_ShowPopupAsync(ESGUI_T *ui, ESGUI_PopWindow_T *popup) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL || popup == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_ACTION;
    cmd.u.act.act = ACT_SHOW_POPUP;
    cmd.u.act.param = popup;
    esgui_cmd_queue_push(ui, &cmd);
#else
    if (ui == ESGUI_NULL || popup == ESGUI_NULL) return;
    ESGUI_MenuAction_T act = {ACT_SHOW_POPUP, popup};
    esgui_execute_action(ui, &act);
#endif
}

/* 异步关闭弹窗 */
void ESGUI_ClosePopupAsync(ESGUI_T *ui) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_ACTION;
    cmd.u.act.act = ACT_CLOSE_POPUP;
    cmd.u.act.param = ESGUI_NULL;
    esgui_cmd_queue_push(ui, &cmd);
#else
    if (ui == ESGUI_NULL) return;
    ESGUI_MenuAction_T act = {ACT_CLOSE_POPUP, ESGUI_NULL};
    esgui_execute_action(ui, &act);
#endif
}

/* 异步添加覆盖层 */
void ESGUI_OverlayAddAsync(ESGUI_T *ui, ESGUI_Overlay_T *ov) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL || ov == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_OVERLAY_ADD;
    cmd.u.overlay.ov = ov;
    esgui_cmd_queue_push(ui, &cmd);
#else
    ESGUI_OverlayAdd(ui, ov);
#endif
}

/* 异步移除覆盖层 */
void ESGUI_OverlayRemoveAsync(ESGUI_T *ui, ESGUI_Overlay_T *ov) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL || ov == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_OVERLAY_REMOVE;
    cmd.u.overlay.ov = ov;
    esgui_cmd_queue_push(ui, &cmd);
#else
    ESGUI_OverlayRemove(ui, ov);
#endif
}

/* 异步设置覆盖层可见性 */
void ESGUI_OverlaySetVisibleAsync(ESGUI_T *ui, ESGUI_Overlay_T *ov, bool visible) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL || ov == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_OVERLAY_VISIBLE;
    cmd.u.overlay_vis.ov = ov;
    cmd.u.overlay_vis.visible = visible;
    esgui_cmd_queue_push(ui, &cmd);
#else
    ESGUI_OverlaySetVisible(ui, ov, visible);
#endif
}

/* 异步执行任意菜单动作（ACT_REFRESH / ACT_EXIT_APP / 自定义动作等） */
void ESGUI_HandleActionAsync(ESGUI_T *ui, ESGUI_MenuAction_T act) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_ACTION;
    cmd.u.act = act;
    esgui_cmd_queue_push(ui, &cmd);
#else
    if (ui == ESGUI_NULL) return;
    esgui_execute_action(ui, &act);
#endif
}

/* 异步启动动画：a 为动画配置，多线程时须保持有效直到 UI 线程处理 */
void ESGUI_AnimStartAsync(ESGUI_T *ui, anim_t *a) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL || a == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_ANIM_START;
    cmd.u.anim_start.a = a;
    esgui_cmd_queue_push(ui, &cmd);
#else
    if (ui == ESGUI_NULL || a == ESGUI_NULL) return;
    anim_start(a);
#endif
}

/* 异步停止与 var 匹配的所有动画 */
void ESGUI_AnimStopAllAsync(ESGUI_T *ui, void *var) {
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    if (ui == ESGUI_NULL) return;
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_ANIM_STOP_ALL;
    cmd.u.anim_stop_all.var = var;
    esgui_cmd_queue_push(ui, &cmd);
#else
    if (ui == ESGUI_NULL) return;
    anim_stop_all(var);
#endif
}


#if ESGUI_ENABLE_MENU_RUNTIME_ITEMS
/* 异步运行时条目增删：投递命令由 UI 线程在 ESGUI_Tick 内执行（等效同步版）。
 * 单线程（ESGUI_ENABLE_MULTITHREAD=0）下直接调用同步版。 */
static void esgui_menu_item_async(ESGUI_T *ui, ESGUI_MenuPage_T *page, eui_uint16_t idx,
                                  eui_uint8_t op, const ESGUI_MenuItem_T *item)
{
    if (ui == ESGUI_NULL || page == ESGUI_NULL) return;
#if (ESGUI_ENABLE_MULTITHREAD && ESGUI_ENABLE_CMD_QUEUE)
    ESGUI_Cmd_T cmd;
    cmd.type = ESGUI_CMD_MENU_ITEM;
    cmd.u.menu_item.page = page;
    cmd.u.menu_item.idx  = idx;
    cmd.u.menu_item.op   = op;
    if (item != ESGUI_NULL) cmd.u.menu_item.item = *item;   /* 条目值拷贝（Remove 无需） */
    esgui_cmd_queue_push(ui, &cmd);
#else
    switch (op) {
        case ESGUI_MENU_ITEM_OP_ADD:    ESGUI_MenuPageAddItem(page, item); break;
        case ESGUI_MENU_ITEM_OP_INSERT: ESGUI_MenuPageInsertItem(page, idx, item); break;
        case ESGUI_MENU_ITEM_OP_REMOVE: ESGUI_MenuPageRemoveItem(page, idx); break;
        default: break;
    }
#endif
}

void ESGUI_MenuPageAddItemAsync(ESGUI_T *ui, ESGUI_MenuPage_T *page, const ESGUI_MenuItem_T *item) {
    esgui_menu_item_async(ui, page, 0, ESGUI_MENU_ITEM_OP_ADD, item);
}

void ESGUI_MenuPageInsertItemAsync(ESGUI_T *ui, ESGUI_MenuPage_T *page, eui_uint16_t idx,
                                   const ESGUI_MenuItem_T *item) {
    esgui_menu_item_async(ui, page, idx, ESGUI_MENU_ITEM_OP_INSERT, item);
}

void ESGUI_MenuPageRemoveItemAsync(ESGUI_T *ui, ESGUI_MenuPage_T *page, eui_uint16_t idx) {
    esgui_menu_item_async(ui, page, idx, ESGUI_MENU_ITEM_OP_REMOVE, ESGUI_NULL);
}
#endif /* ESGUI_ENABLE_MENU_RUNTIME_ITEMS */



#if (ESGUI_ENABLE_MULTITHREAD && (ESGUI_ENABLE_CMD_QUEUE || ESGUI_ENABLE_PRODUCER_BOX))
/* 统一执行一条命令（供主命令队列与生产者收件箱共用，仅 UI 线程调用） */
static void esgui_execute_cmd(ESGUI_T *ui, const ESGUI_Cmd_T *cmd)
{
    switch (cmd->type) {
        case ESGUI_CMD_KEY:
            ESGUI_FeedKey_impl(ui, cmd->u.key.key, cmd->u.key.now_ms);
            break;
        case ESGUI_CMD_ACTION:
            esgui_execute_action(ui, (ESGUI_MenuAction_T *)&cmd->u.act);
            break;
        case ESGUI_CMD_OVERLAY_ADD:
            ESGUI_OverlayAdd(ui, cmd->u.overlay.ov);
            break;
        case ESGUI_CMD_OVERLAY_REMOVE:
            ESGUI_OverlayRemove(ui, cmd->u.overlay.ov);
            break;
        case ESGUI_CMD_OVERLAY_VISIBLE:
            ESGUI_OverlaySetVisible(ui, cmd->u.overlay_vis.ov, cmd->u.overlay_vis.visible);
            break;
        case ESGUI_CMD_ANIM_START:
            anim_start(cmd->u.anim_start.a);
            break;
        case ESGUI_CMD_ANIM_STOP_ALL:
            anim_stop_all(cmd->u.anim_stop_all.var);
            break;
#if ESGUI_ENABLE_MENU_RUNTIME_ITEMS
        case ESGUI_CMD_MENU_ITEM:
            switch (cmd->u.menu_item.op) {
                case ESGUI_MENU_ITEM_OP_ADD:
                    ESGUI_MenuPageAddItem(cmd->u.menu_item.page, &cmd->u.menu_item.item);
                    break;
                case ESGUI_MENU_ITEM_OP_INSERT:
                    ESGUI_MenuPageInsertItem(cmd->u.menu_item.page, cmd->u.menu_item.idx,
                                             &cmd->u.menu_item.item);
                    break;
                case ESGUI_MENU_ITEM_OP_REMOVE:
                    ESGUI_MenuPageRemoveItem(cmd->u.menu_item.page, cmd->u.menu_item.idx);
                    break;
                default:
                    break;
            }
            break;
#endif /* ESGUI_ENABLE_MENU_RUNTIME_ITEMS */
        default:
            break;
    }
}
#endif /* (ESGUI_ENABLE_MULTITHREAD && (CMD_QUEUE || PRODUCER_BOX)) */



void ESGUI_Tick(ESGUI_T *ui, eui_uint32_t now_ms) {
    if (ui == ESGUI_NULL) return;

#if ESGUI_ENABLE_MULTITHREAD
#if (ESGUI_ENABLE_CMD_QUEUE || ESGUI_ENABLE_PRODUCER_BOX)
    /* 0. 取出并处理排队的命令（按键/菜单动作/覆盖层/动画/增删，输入与渲染同属 UI 线程） */
    ESGUI_Cmd_T cmd;
#endif
#if ESGUI_ENABLE_CMD_QUEUE
    while (esgui_cmd_queue_pop(ui, &cmd)) {
        esgui_execute_cmd(ui, &cmd);
    }
#endif
#if ESGUI_ENABLE_PRODUCER_BOX
    /* 0.5 单生产者收拢：轮询所有已注册的生产者收件箱并统一处理 */
    for (eui_uint8_t i = 0; i < ui->producer_box_count; i++) {
        ESGUI_ProducerBox_T *box = ui->producer_boxes[i];
        if (box == ESGUI_NULL) continue;
        while (esgui_producer_box_pop(box, &cmd)) {
            esgui_execute_cmd(ui, &cmd);
        }
    }
#endif
#endif /* ESGUI_ENABLE_MULTITHREAD */

    /* 1. 先更新动画 */
    if (ui->menu_ctrl.menu_depth > 0 && ui->anim_tick_cb) {
        ui->anim_tick_cb(ui, now_ms);
    }

    /* 2. 动画完成后立即切换页面 */
    if (ui->menu_ctrl.pending_push && ui->menu_ctrl.pending_done) {
        ESGUI_MenuAction_T push_act = {ACT_PUSH_PAGE, ui->menu_ctrl.pending_push_page};
        ESGUI_MenuCtrlHandleAction(&ui->menu_ctrl, &push_act);
        ui->menu_ctrl.pending_push = 0;
        ui->menu_ctrl.pending_push_page = ESGUI_NULL;
        ui->menu_ctrl.pending_done = 0;
    }
    else if (ui->menu_ctrl.pending_pop && ui->menu_ctrl.pending_done) {
        ESGUI_MenuCtrlExecPendingPop(&ui->menu_ctrl);
    }

    /* 3. 判断是否需要绘制 */
    eui_uint8_t need = ui->menu_ctrl.need_refresh;
    if (ui->menu_ctrl.menu_depth > 0) {
        if (ui->menu_ctrl.anim_running) {
            need = 1;
        }
    }
    if (ui->menu_ctrl.pending_push || ui->menu_ctrl.pending_pop) {
        need = 1;
    }
    /* 覆盖层持续刷新：任一 always_dirty 的可见覆盖层都强制本帧重绘 */
    for (eui_uint8_t i = 0; i < ui->overlay_count; i++) {
        ESGUI_Overlay_T *ov = ui->overlays[i];
        if (ov) {
            ov->render_ctx = ui->draw_ctx;
            if (ov->visible && ov->always_dirty) {
                need = 1;
            }
            break;
        }
    }
    if (!need) {
        ui->menu_ctrl.need_refresh = 0;
        return;
    }

    /* 4. 绘制当前栈顶页面 */
    if (ui->menu_ctrl.menu_depth > 0 && ui->refresh_cb) {
        ESGUI_MenuPage_T *top = ui->menu_ctrl.page_stack[ui->menu_ctrl.menu_depth - 1];
        ESGUI_MenuAction_T act = {ACT_NONE, ESGUI_NULL};

        /* 绘制弹窗（模态覆盖） */
        if (ui->menu_ctrl.pop_window_en && ui->menu_ctrl.pop_window) {
            if (ui->menu_ctrl.pop_window->render_ctx == ESGUI_NULL && ui->menu_ctrl.pop_window->vtbl->on_create) {
                ui->menu_ctrl.pop_window->render_ctx = ui->draw_ctx;
                ui->menu_ctrl.pop_window->vtbl->on_create((ESGUI_MenuPage_T*)ui->menu_ctrl.pop_window);

                act.act = ACT_SHOW_POPUP;
                act.param = ui->menu_ctrl.pop_window;
                if (ui->menu_ctrl.pop_window->vtbl->on_page_chenge) {
                    ui->menu_ctrl.pop_window->vtbl->on_page_chenge((ESGUI_MenuPage_T*)ui->menu_ctrl.pop_window, &act);
                }
            } else {
                ui->menu_ctrl.pop_window->render_ctx = ui->draw_ctx;
            }
            ui->refresh_cb(ui, top, ui->menu_ctrl.pop_window);
        } else {
            /* 页面首次渲染时 render_ctx 为 ESGUI_NULL，注入后调用 on_create */
            if (top->render_ctx == ESGUI_NULL && top->vtbl->on_create) {
                top->render_ctx = ui->draw_ctx;
                top->vtbl->on_create(top);

                act.act = ACT_PUSH_PAGE;
                act.param = top;
                if (top->vtbl->on_page_chenge) {
                    top->vtbl->on_page_chenge(top, &act);
                }
            } else {
                top->render_ctx = ui->draw_ctx;
            }
            ui->refresh_cb(ui, top, ESGUI_NULL);
        }
    }

    ui->menu_ctrl.need_refresh = 0;
}


/* ==================== 覆盖层（Overlay）管理 ==================== */

bool ESGUI_OverlayAdd(ESGUI_T *ui, ESGUI_Overlay_T *ov)
{
    if (ui == ESGUI_NULL || ov == ESGUI_NULL || ov->on_draw == ESGUI_NULL) return false;

    /* 防重复添加 */
    for (eui_uint8_t i = 0; i < ui->overlay_count; i++) {
        if (ui->overlays[i] == ov) return true;
    }
    if (ui->overlay_count >= ESGUI_MAX_OVERLAY) return false;

    ui->overlays[ui->overlay_count++] = ov;
    ov->visible = 1;                      /* 添加后默认可见 */
    ui->menu_ctrl.need_refresh = 1;
    return true;
}

bool ESGUI_OverlayRemove(ESGUI_T *ui, ESGUI_Overlay_T *ov)
{
    if (ui == ESGUI_NULL || ov == ESGUI_NULL) return false;
    for (eui_uint8_t i = 0; i < ui->overlay_count; i++) {
        if (ui->overlays[i] == ov) {
            /* 前移保持顺序 */
            for (eui_uint8_t j = i; j < ui->overlay_count - 1; j++) {
                ui->overlays[j] = ui->overlays[j + 1];
            }
            ui->overlays[--ui->overlay_count] = ESGUI_NULL;
            ui->menu_ctrl.need_refresh = 1;
            return true;
        }
    }
    return false;
}

void ESGUI_OverlaySetVisible(ESGUI_T *ui, ESGUI_Overlay_T *ov, bool visible)
{
    if (ui == ESGUI_NULL || ov == ESGUI_NULL) return;
    ov->visible = visible ? 1 : 0;
    ui->menu_ctrl.need_refresh = 1;
}
