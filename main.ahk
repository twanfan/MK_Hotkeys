#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force


;设置ImageSearch全屏进行
CoordMode Pixel
;设置MouseMove全屏进行
CoordMode Mouse
;设置ToolTip全屏进行
CoordMode ToolTip
;鼠标速度设置为最快
SetDefaultMouseSpeed, 0

; debug
; ToolTip, running, 0, 0, 19

;定义程序窗口名称
SetTitleMatchMode, RegEx
win_title := "Martial Kingdoms"
; win_title := "ahk_class Notepad"


;检测程序运行情况并显示通知
on_start := True
old_activity := False
detect_active(){
    global on_start
    global old_activity
    global win_title
    if (on_start){
        old_activity := (WinActive(win_title) != 0)
        on_start := False
        if (old_activity){
            HideTrayTip()
            TrayTip 霸图快捷键工具提示, 检测到天下霸图启动, , 1
        }else{
            HideTrayTip()
            TrayTip 霸图快捷键工具提示, 等待天下霸图启动, , 1
        }
        return
    }
    current_activity := (WinActive(win_title) != 0)
    if (current_activity != old_activity){
        if (old_activity){
            old_activity := current_activity
            HideTrayTip()
            TrayTip 霸图快捷键工具提示, 快捷键功能暂停, , 1
        }else{
            old_activity := current_activity
            HideTrayTip()
            TrayTip 霸图快捷键工具提示, 快捷键功能启动, , 1
        }
    }
    return
}
HideTrayTip() { ;清除托盘提示
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}



;从配置文件读取基本信息
IniRead, k_tooltip, .\config.ini, Keys, k_tooltip
hold_k_tooltip := "*"k_tooltip
IniRead, tooltip_prop_x, .\config.ini, General, tooltip_prop_x
IniRead, tooltip_prop_y, .\config.ini, General, tooltip_prop_y
IniRead, operation_interval, .\config.ini, General, operation_interval

;计算主要提示显示位置
tooltip_prop_xy = %tooltip_prop_x%,%tooltip_prop_y%
tooltip_x := find_pos(tooltip_prop_xy)[1]
tooltip_y := find_pos(tooltip_prop_xy)[2]
;鼠标点击后是否回到原始位置
Iniread, if_pos_res, .\config.ini, General, mouse_position_restore
;是否使用绝对位置
Iniread, use_abs_pos, .\config.ini, General, use_abs_pos
;是否显示任务栏提示
Iniread, show_tray_tips, .\config.ini, General, show_tray_tips
if (show_tray_tips){
    SetTimer, detect_active, 1000
}
;计算使用的半间隔时间
half_interval := Ceil(Abs(operation_interval/2))
; MsgBox, %half_interval%

WinWait, %win_title%
sleep, 500

ToolTip, 快捷键辅助程序启动中..., tooltip_x, tooltip_y, 20

;从配置文件读取位置信息
IniRead, op_history, .\config.ini, Proportions, op_history
IniRead, op_analyze, .\config.ini, Proportions, op_analyze
IniRead, op_system, .\config.ini, Proportions, op_system
IniRead, op_characters, .\config.ini, Proportions, op_characters
IniRead, op_buildings, .\config.ini, Proportions, op_buildings
IniRead, op_market, .\config.ini, Proportions, op_market
IniRead, op_move, .\config.ini, Proportions, op_move
IniRead, op_attack, .\config.ini, Proportions, op_attack
IniRead, op_scout, .\config.ini, Proportions, op_scout
IniRead, op_negotiate, .\config.ini, Proportions, op_negotiate
IniRead, op_info, .\config.ini, Proportions, op_info
IniRead, op_assign, .\config.ini, Proportions, op_assign
IniRead, op_incident, .\config.ini, Proportions, op_incident
IniRead, sys_save, .\config.ini, Proportions, sys_save
IniRead, sys_load, .\config.ini, Proportions, sys_load
IniRead, sys_resume, .\config.ini, Proportions, sys_resume
IniRead, sys_exit, .\config.ini, Proportions, sys_exit
IniRead, sys_speed1, .\config.ini, Proportions, sys_speed1
IniRead, sys_speed5, .\config.ini, Proportions, sys_speed5
IniRead, sys_speed0, .\config.ini, Proportions, sys_speed0
IniRead, sys_exit_ok, .\config.ini, Proportions, sys_exit_ok
IniRead, sys_exit_cancel, .\config.ini, Proportions, sys_exit_cancel
IniRead, sl_ok, .\config.ini, Proportions, sl_ok
IniRead, sl_cancel, .\config.ini, Proportions, sl_cancel
IniRead, sl_slot, .\config.ini, Proportions, sl_slot

IniRead, sub_start_load, .\config.ini, Proportions, sub_start_load
IniRead, sub_start_exit, .\config.ini, Proportions, sub_start_exit

IniRead, back_op_history, .\config.ini, Proportions, back_op_history
IniRead, back_op_analyze, .\config.ini, Proportions, back_op_analyze
IniRead, back_op_characters, .\config.ini, Proportions, back_op_characters
IniRead, back_op_buildings, .\config.ini, Proportions, back_op_buildings
IniRead, back_op_market, .\config.ini, Proportions, back_op_market
IniRead, back_op_move, .\config.ini, Proportions, back_op_move
IniRead, back_op_attack, .\config.ini, Proportions, back_op_attack
IniRead, back_op_scout, .\config.ini, Proportions, back_op_scout
IniRead, back_op_negotiate, .\config.ini, Proportions, back_op_negotiate
IniRead, back_op_info, .\config.ini, Proportions, back_op_info
IniRead, back_op_assign, .\config.ini, Proportions, back_op_assign
IniRead, back_op_incident, .\config.ini, Proportions, back_op_incident

IniRead, region_s_equipment, .\config.ini, Proportions, region_s_equipment
IniRead, region_e_equipment, .\config.ini, Proportions, region_e_equipment
IniRead, region_s_inventory, .\config.ini, Proportions, region_s_inventory
IniRead, region_e_inventory, .\config.ini, Proportions, region_e_inventory
IniRead, region_s_storage, .\config.ini, Proportions, region_s_storage
IniRead, region_e_storage, .\config.ini, Proportions, region_e_storage
IniRead, item_portrait, .\config.ini, Proportions, item_portrait
IniRead, item_inv_1, .\config.ini, Proportions, item_inv_1
IniRead, item_storage_1, .\config.ini, Proportions, item_storage_1
IniRead, item_equipment_1, .\config.ini, Proportions, item_equipment_1
IniRead, item_equipment_2, .\config.ini, Proportions, item_equipment_2
IniRead, item_equipment_3, .\config.ini, Proportions, item_equipment_3
IniRead, item_equipment_4, .\config.ini, Proportions, item_equipment_4

IniRead, region_s_combat_i, .\config.ini, Proportions, region_s_combat_i
IniRead, region_e_combat_i, .\config.ini, Proportions, region_e_combat_i
IniRead, item_combat_weapon, .\config.ini, Proportions, item_combat_weapon
IniRead, item_combat_weapon_1, .\config.ini, Proportions, item_combat_weapon_1




;从配置文件读取快捷键信息
Iniread, k_op_history, .\config.ini, Keys, k_op_history
Iniread, k_op_analyze, .\config.ini, Keys, k_op_analyze
Iniread, k_op_system, .\config.ini, Keys, k_op_system
Iniread, k_op_characters, .\config.ini, Keys, k_op_characters
Iniread, k_op_buildings, .\config.ini, Keys, k_op_buildings
Iniread, k_op_market, .\config.ini, Keys, k_op_market
Iniread, k_op_move, .\config.ini, Keys, k_op_move
Iniread, k_op_attack, .\config.ini, Keys, k_op_attack
Iniread, k_op_scout, .\config.ini, Keys, k_op_scout
Iniread, k_op_negotiate, .\config.ini, Keys, k_op_negotiate
Iniread, k_op_info, .\config.ini, Keys, k_op_info
Iniread, k_op_assign, .\config.ini, Keys, k_op_assign
Iniread, k_op_incident, .\config.ini, Keys, k_op_incident

Iniread, k_op_backs_origin, .\config.ini, Keys, k_op_backs_origin

Iniread, k_comb_max_speed, .\config.ini, Keys, k_comb_max_speed
Iniread, k_comb_min_speed, .\config.ini, Keys, k_comb_min_speed
Iniread, k_comb_quick_save, .\config.ini, Keys, k_comb_quick_save
Iniread, k_comb_quick_load, .\config.ini, Keys, k_comb_quick_load

Iniread, k_comb_fast_exit, .\config.ini, Keys, k_comb_fast_exit

;按键字符转换为前缀
key_to_prefix(key){
    map := {"Shift":"+", "LShift":"<+", "RShift":">+", "Ctrl":"^", "LCtrl":"<^", "RCtrl":">^", "Alt":"!", "LAlt":"<!", "RAlt":">!"}
    if (map.haskey(key)){
        return map[key]
    }else{
        return key
    }
}
k_op_backs := key_to_prefix(k_op_backs_origin)
; MsgBox, %k_op_backs_origin%%k_op_backs%

;根据位置比例信息及当前分辨率计算实际位置
find_pos(pos_info){
    global use_abs_pos
    info := StrSplit(pos_info, ",")
    if (use_abs_pos){
        x := info[1] * 800
        y := info[2] * 600
    }else{
        x := info[1] * A_ScreenWidth
        y := info[2] * A_ScreenHeight
    }
    return [x, y]
}
abs_op_history := find_pos(op_history)
abs_op_analyze := find_pos(op_analyze)
abs_op_system := find_pos(op_system)
abs_op_characters := find_pos(op_characters)
abs_op_buildings := find_pos(op_buildings)
abs_op_market := find_pos(op_market)
abs_op_move := find_pos(op_move)
abs_op_attack := find_pos(op_attack)
abs_op_scout := find_pos(op_scout)
abs_op_negotiate := find_pos(op_negotiate)
abs_op_info := find_pos(op_info)
abs_op_assign := find_pos(op_assign)
abs_op_incident := find_pos(op_incident)
abs_sys_save := find_pos(sys_save)
abs_sys_load := find_pos(sys_load)
abs_sys_resume := find_pos(sys_resume)
abs_sys_exit := find_pos(sys_exit)
abs_sys_speed1 := find_pos(sys_speed1)
abs_sys_speed5 := find_pos(sys_speed5)
abs_sys_speed0 := find_pos(sys_speed0)
abs_sys_exit_ok := find_pos(sys_exit_ok)
abs_sys_exit_cancel := find_pos(sys_exit_cancel)
abs_sl_ok := find_pos(sl_ok)
abs_sl_cancel := find_pos(sl_cancel)
abs_sl_slot := find_pos(sl_slot)

abs_sub_start_load := find_pos(sub_start_load)
abs_sub_start_exit := find_pos(sub_start_exit)

abs_back_op_history := find_pos(back_op_history)
abs_back_op_analyze := find_pos(back_op_analyze)
abs_back_op_characters := find_pos(back_op_characters)
abs_back_op_buildings := find_pos(back_op_buildings)
abs_back_op_market := find_pos(back_op_market)
abs_back_op_move := find_pos(back_op_move)
abs_back_op_attack := find_pos(back_op_attack)
abs_back_op_scout := find_pos(back_op_scout)
abs_back_op_negotiate := find_pos(back_op_negotiate)
abs_back_op_info := find_pos(back_op_info)
abs_back_op_assign := find_pos(back_op_assign)
abs_back_op_incident := find_pos(back_op_incident)

abs_region_s_equipment := find_pos(region_s_equipment)
abs_region_e_equipment := find_pos(region_e_equipment)
abs_region_s_inventory := find_pos(region_s_inventory)
abs_region_e_inventory := find_pos(region_e_inventory)
abs_region_s_storage := find_pos(region_s_storage)
abs_region_e_storage := find_pos(region_e_storage)

abs_item_portrait := find_pos(item_portrait)
abs_item_inv_1 := find_pos(item_inv_1)
abs_item_storage_1 := find_pos(item_storage_1)
abs_item_equipment_1 := find_pos(item_equipment_1)
abs_item_equipment_2 := find_pos(item_equipment_2)
abs_item_equipment_3 := find_pos(item_equipment_3)
abs_item_equipment_4 := find_pos(item_equipment_4)

abs_region_s_combat_i := find_pos(region_s_combat_i)
abs_region_e_combat_i := find_pos(region_e_combat_i)
abs_item_combat_weapon := find_pos(item_combat_weapon)
abs_item_combat_weapon_1 := find_pos(item_combat_weapon_1)



mouse_position_stored := [10, 10]
;进行单次鼠标点击（位置、是否更新位置信息、点击后是否还原位置）
one_click(abs_pos, update_stored_position:=True, to_restore:=True){
    global mouse_position_stored
    global half_interval
    if (update_stored_position){
        MouseGetPos, x, y
        mouse_position_stored := [x, y]
    }
    if not (abs_pos = "Here"){
        if (abs_pos = "click_stored_position"){
            MouseMove, % mouse_position_stored[1], % mouse_position_stored[2]
        }else{
            MouseMove, % abs_pos[1], % abs_pos[2]
        }
    }
    sleep %half_interval%
    MouseClick
    sleep %half_interval%
    if (to_restore){
        MouseMove % mouse_position_stored[1], % mouse_position_stored[2]
    }
    return
}
; 进行多次鼠标点击（位置、是否还原）
multi_clicks(abs_poss, to_restore:=True, latency:=0){
    for k, v in abs_poss{
        if (k=1){
            one_click(v, True, False)
        }else if (k=abs_poss.Length()){
            one_click(v, False, to_restore)
        }else{
            one_click(v, False, False)
        }
        sleep, %latency%
    }
    return
}
; 判断鼠标当前所在区域
get_mouse_region(){
    global abs_region_s_equipment
    global abs_region_e_equipment
    global abs_region_s_inventory
    global abs_region_e_inventory
    global abs_region_s_storage
    global abs_region_e_storage
    global abs_region_s_combat_i
    global abs_region_e_combat_i

    MouseGetPos, x, y
    if ((x > abs_region_s_equipment[1]) and (x < abs_region_e_equipment[1]) and (y > abs_region_s_equipment[2]) and (y < abs_region_e_equipment[2])){
        return "equipment"
    }else if ((x > abs_region_s_inventory[1]) and (x < abs_region_e_inventory[1]) and (y > abs_region_s_inventory[2]) and (y < abs_region_e_inventory[2])){
        return "inventory"
    }else if ((x > abs_region_s_storage[1]) and (x < abs_region_e_storage[1]) and (y > abs_region_s_storage[2]) and (y < abs_region_e_storage[2])){
        return "storage"
    }else if ((x > abs_region_s_combat_i[1]) and (x < abs_region_e_combat_i[1]) and (y > abs_region_s_combat_i[2]) and (y < abs_region_e_combat_i[2])){
        return "combat_i"
    }else{
        return "undefined"
    }
}
; 物品操作点击
item_clicks(operation:="move", to_restore:=True){
    global comb_equipment_to_storage
    global comb_equipment_to_inventory
    global comb_storage_to_inventory
    global comb_storage_to_equipment
    global comb_use_item
    global comb_change_weapon
    current_region := get_mouse_region()
    ; MsgBox, %current_region%
    if (operation = "move"){
        if ((current_region = "equipment") or (current_region = "inventory")){
            multi_clicks(comb_equipment_to_storage, to_restore)
        }else if (current_region = "storage"){
            multi_clicks(comb_storage_to_inventory, to_restore)
        }
    }else if (operation = "equip"){
        if ((current_region = "storage") or (current_region = "inventory")){
            multi_clicks(comb_storage_to_equipment, to_restore)
        }
    }else if (operation = "use"){
        if ((current_region = "storage") or (current_region = "inventory")){
            multi_clicks(comb_use_item, to_restore)
        }
    }else if (operation = "change_weapon"){
        ; if ((current_region = "combat_i") or (current_region = "storag")){
        ;     multi_clicks(comb_change_weapon, to_restore)
        ; }
        multi_clicks(comb_change_weapon, to_restore)
    }
    return
}

;定义多次点击进行的活动
; 调整为最大速度
comb_max_speed := [abs_op_system, abs_sys_speed5, abs_sys_resume]
; 调整为最小速度
comb_min_speed := [abs_op_system, abs_sys_speed1, abs_sys_speed0, abs_sys_resume]
; 快速保存
comb_quick_save := [abs_op_system, abs_sys_save, abs_sl_slot, abs_sl_ok]
; 快速读取
comb_quick_load := [abs_op_system, abs_sub_start_load, abs_sys_load, abs_sl_slot, abs_sl_ok]

; 装备/包袱至仓库
comb_equipment_to_storage := ["Here", abs_item_storage_1]
; 装备至包袱
comb_equipment_to_inventory := ["Here", abs_item_inv_1]
; 仓库至包袱
comb_storage_to_inventory := ["Here", abs_item_inv_1]
; 仓库/包袱至装备
comb_storage_to_equipment := ["Here", abs_item_equipment_1, abs_item_equipment_2, abs_item_equipment_3, abs_item_equipment_4]
; 使用物品
comb_use_item := ["Here", abs_item_portrait]

; 切换武器
comb_change_weapon := ["Here", abs_item_combat_weapon, "click_stored_position"]

; 快速退出
comb_fast_exit := [abs_op_system, abs_sys_exit, abs_sys_exit_ok, abs_sub_start_exit]




;显示提示
show_tips(info){
    global tooltip_x
    global tooltip_y
    global k_tooltip
    ToolTip, %info%, tooltip_x, tooltip_y, 20
    loop
    {
        Sleep, 10
        if !GetKeyState(k_tooltip, "P")
            break
    }
    ToolTip, , , , 20
    return
}
info_main =
(
显示提示: %k_tooltip%
历史: %k_op_history%
分析: %k_op_analyze%
系统: %k_op_system%
人物: %k_op_characters%
建筑: %k_op_buildings%
交易: %k_op_market%
移动: %k_op_move%
出击: %k_op_attack%
侦察: %k_op_scout%
交涉: %k_op_negotiate%
情报: %k_op_info%
任命: %k_op_assign%
调整为最大速度: %k_comb_max_speed%
调整为最小速度: %k_comb_min_speed%
快速保存: %k_comb_quick_save%
快速读取: %k_comb_quick_load%
快速关闭某个子菜单：
    %k_op_backs_origin% + 对应子菜单快捷键
在人物包袱/装备栏与仓库间移动物品：
    Shift + 左键点击要移动的物品
使用包袱/仓库中的物品：
    Ctrl + Shift + 左键点击要使用的物品
战斗中切换武器：
    Alt + 左键点击要切换的武器
快速退出游戏：
    Ctrl + Alt + Shift + %k_comb_fast_exit%
)
info_to_show := info_main

;生成点击函数对象
;一般快捷键
click_abs_op_history := Func("one_click").Bind(abs_op_history, , if_pos_res)
click_abs_op_analyze := Func("one_click").Bind(abs_op_analyze, , if_pos_res)
click_abs_op_system := Func("one_click").Bind(abs_op_system, , if_pos_res)
click_abs_op_characters := Func("one_click").Bind(abs_op_characters, , if_pos_res)
click_abs_op_buildings := Func("one_click").Bind(abs_op_buildings, , if_pos_res)
click_abs_op_market := Func("one_click").Bind(abs_op_market, , if_pos_res)
click_abs_op_move := Func("one_click").Bind(abs_op_move, , if_pos_res)
click_abs_op_attack := Func("one_click").Bind(abs_op_attack, , if_pos_res)
click_abs_op_scout := Func("one_click").Bind(abs_op_scout, , if_pos_res)
click_abs_op_negotiate := Func("one_click").Bind(abs_op_negotiate, , if_pos_res)
click_abs_op_info := Func("one_click").Bind(abs_op_info, , if_pos_res)
click_abs_op_assign := Func("one_click").Bind(abs_op_assign, , if_pos_res)
click_abs_op_incident := Func("one_click").Bind(abs_op_incident, , if_pos_res)
;返回快捷键
click_abs_back_op_history := Func("one_click").Bind(abs_back_op_history, , if_pos_res)
click_abs_back_op_analyze := Func("one_click").Bind(abs_back_op_analyze, , if_pos_res)
click_abs_sys_resume := Func("one_click").Bind(abs_sys_resume, , if_pos_res)
click_abs_back_op_characters := Func("one_click").Bind(abs_back_op_characters, , if_pos_res)
click_abs_back_op_buildings := Func("one_click").Bind(abs_back_op_buildings, , if_pos_res)
click_abs_back_op_market := Func("one_click").Bind(abs_back_op_market, , if_pos_res)
click_abs_back_op_move := Func("one_click").Bind(abs_back_op_move, , if_pos_res)
click_abs_back_op_attack := Func("one_click").Bind(abs_back_op_attack, , if_pos_res)
click_abs_back_op_scout := Func("one_click").Bind(abs_back_op_scout, , if_pos_res)
click_abs_back_op_negotiate := Func("one_click").Bind(abs_back_op_negotiate, , if_pos_res)
click_abs_back_op_info := Func("one_click").Bind(abs_back_op_info, , if_pos_res)
click_abs_back_op_assign := Func("one_click").Bind(abs_back_op_assign, , if_pos_res)
click_abs_back_op_incident := Func("one_click").Bind(abs_back_op_incident, , if_pos_res)

;合成快捷键
click_comb_max_speed := Func("multi_clicks").Bind(comb_max_speed, if_pos_res)
click_comb_min_speed := Func("multi_clicks").Bind(comb_min_speed, if_pos_res)
click_comb_quick_save := Func("multi_clicks").Bind(comb_quick_save, if_pos_res)
click_comb_quick_load := Func("multi_clicks").Bind(comb_quick_load, if_pos_res)

click_comb_fast_exit := Func("multi_clicks").Bind(comb_fast_exit, if_pos_res, 100)

click_equipment_to_storage := Func("item_clicks").Bind("move", if_pos_res)
; click_equipment_to_inventory := Func("item_clicks").Bind("move", if_pos_res)
; click_storage_to_inventory := Func("item_clicks").Bind("move", if_pos_res)
click_storage_to_equipment := Func("item_clicks").Bind("equip", if_pos_res)
click_use_item := Func("item_clicks").Bind("use", if_pos_res)
click_change_weapon := Func("item_clicks").Bind("change_weapon", if_pos_res)


;显示提示
show_tip_func := Func("show_tips").Bind(info_to_show)

;绑定点击函数快捷键，仅在程序运行时启用
Hotkey, IfWinActive, %win_title%
;绑定一般快捷键
Hotkey, %k_op_history%, % click_abs_op_history
Hotkey, %k_op_analyze%, % click_abs_op_analyze
Hotkey, %k_op_system%, % click_abs_op_system
Hotkey, %k_op_characters%, % click_abs_op_characters
Hotkey, %k_op_buildings%, % click_abs_op_buildings
Hotkey, %k_op_market%, % click_abs_op_market
Hotkey, %k_op_move%, % click_abs_op_move
Hotkey, %k_op_attack%, % click_abs_op_attack
Hotkey, %k_op_scout%, % click_abs_op_scout
Hotkey, %k_op_negotiate%, % click_abs_op_negotiate
Hotkey, %k_op_info%, % click_abs_op_info
Hotkey, %k_op_assign%, % click_abs_op_assign
Hotkey, %k_op_incident%, % click_abs_op_incident
;绑定返回快捷键
Hotkey, %k_op_backs%%k_op_history%, % click_abs_back_op_history
Hotkey, %k_op_backs%%k_op_history%, % click_abs_back_op_history
Hotkey, %k_op_backs%%k_op_analyze%, % click_abs_back_op_analyze
Hotkey, %k_op_backs%%k_op_system%, % click_abs_sys_resume
Hotkey, %k_op_backs%%k_op_characters%, % click_abs_back_op_characters
Hotkey, %k_op_backs%%k_op_buildings%, % click_abs_back_op_buildings
Hotkey, %k_op_backs%%k_op_market%, % click_abs_back_op_market
Hotkey, %k_op_backs%%k_op_move%, % click_abs_back_op_move
Hotkey, %k_op_backs%%k_op_attack%, % click_abs_back_op_attack
Hotkey, %k_op_backs%%k_op_scout%, % click_abs_back_op_scout
Hotkey, %k_op_backs%%k_op_negotiate%, % click_abs_back_op_negotiate
Hotkey, %k_op_backs%%k_op_info%, % click_abs_back_op_info
Hotkey, %k_op_backs%%k_op_assign%, % click_abs_back_op_assign
Hotkey, %k_op_backs%%k_op_incident%, % click_abs_back_op_incident


;绑定合成快捷键
Hotkey, %k_comb_max_speed%, % click_comb_max_speed
Hotkey, %k_comb_min_speed%, % click_comb_min_speed
Hotkey, %k_comb_quick_save%, % click_comb_quick_save
Hotkey, %k_comb_quick_load%, % click_comb_quick_load

Hotkey, ^!+%k_comb_fast_exit%, % click_comb_fast_exit

Hotkey, +LButton, % click_equipment_to_storage
; Hotkey, !+LButton, % click_storage_to_equipment
Hotkey, ^+LButton, % click_use_item
Hotkey, !LButton, % click_change_weapon


;绑定提示
Hotkey, %hold_k_tooltip%, % show_tip_func



ToolTip, , , , 20
;退出键，debug用
^!+[::ExitApp