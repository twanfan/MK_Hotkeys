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

;debug
; ToolTip, script running..., 0, 0, 19

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
SetTimer, detect_active, 1000


;从配置文件读取基本信息
IniRead, k_tooltip, .\config.ini, Keys, k_tooltip
hold_k_tooltip := "*"k_tooltip
IniRead, tooltip_prop_x, .\config.ini, General, tooltip_prop_x
IniRead, tooltip_prop_y, .\config.ini, General, tooltip_prop_y

;计算主要提示显示位置
tooltip_prop_xy = %tooltip_prop_x%,%tooltip_prop_y%
tooltip_x := find_pos(tooltip_prop_xy)[1]
tooltip_y := find_pos(tooltip_prop_xy)[2]
;鼠标点击后是否回到原始位置
Iniread, if_pos_res, .\config.ini, General, mouse_position_restore
;是否使用绝对
Iniread, use_abs_pos, .\config.ini, General, use_abs_pos

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



mouse_position_stored := [0, 0]
;进行单次鼠标点击（位置、是否更新位置信息、点击后是否还原位置）
one_click(abs_pos, update_stored_position:=True, to_restore:=True){
    global mouse_position_stored
    if (update_stored_position){
        MouseGetPos, x, y
        mouse_position_stored := [x, y]
    }
    MouseMove, % abs_pos[1], % abs_pos[2]
    sleep 1
    MouseClick
    sleep 1
    ; MouseClick, left, % abs_pos[1], % abs_pos[2]
    ; sleep 20
    if (to_restore){
        MouseMove % mouse_position_stored[1], % mouse_position_stored[2]
    }
    return
}
; 进行多次鼠标点击（位置、是否还原）
multi_clicks(abs_poss, to_restore:=True){
    for k, v in abs_poss{
        if (k=1){
            one_click(v, True, False)
        }else if (k=abs_poss.Length()){
            one_click(v, False, to_restore)
        }else{
            one_click(v, False, False)
        }
        ; sleep, 50
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


;绑定提示
Hotkey, %hold_k_tooltip%, % show_tip_func



ToolTip, , , , 20


; mode_main := ["info_main", abs_main_1, abs_main_2, abs_main_3, abs_main_4]
; mode_sys := ["info_sys", abs_sys_1, abs_sys_2]
; mode_sl := ["info_sl", abs_sl_1, abs_sl_2]



; array := {ten: 10, twenty: 20, thirty: 30}
; relative_positions := {"tooltip_main": [tooltip_prop_x, tooltip_prop_y]
;     ,"tmp1":    [.2, .3]
;     ,"tmp2":    [.5, .8]}
; tmp := relative_positions["tmp2"][2]
; MsgBox %tmp%


; func:
;     KeyWait %k_tooltip%, D
;     ToolTip, altdownnow, tooltip_x, tooltip_y, 20
;     ; ToolTip, altdownnow, A_ScreenWidth/2, A_ScreenHeight/2, 1
;     SetTimer detect_key_press, 0
;     KeyWait %k_tooltip%
;     SetTimer detect_key_press, off
;     ToolTip,,,, 20
;     ToolTip,,,, 1
;     return


; detect_key_press:
;     if GetKeyState(1, "P")
;     {
;         SetTimer detect_key_press, off
;         ImageSearch, OutputVarX, OutputVarY, 0, 0, 2000, 2000, .\Images\m1.png
;         if ErrorLevel   ; i.e. it's not blank or zero.
;             MsgBox, an error occur, level %ErrorLevel%
;         if (OutputVarX = "")
;         {
;             MsgBox NF, %A_ScreenWidth%, %A_ScreenHeight%
;         }
;         else
;         {
;             MouseMove, OutputVarX, OutputVarY
;             MsgBox %OutputVarX%,%OutputVarY%
;         }
;         return
;     }
;     if GetKeyState(2, "P")
;     {
;         SetTimer detect_key_press, off
;         MouseMove, 500, 500
;         MsgBox 2 pressed
;         return
;     }
; return

; ~LAlt::
; ToolTip, altdownnow, A_ScreenWidth, A_ScreenHeight
; KeyWait, 1, D
; ToolTip, 1down, A_ScreenWidth, A_ScreenHeight
; KeyWait, LAlt
; ToolTip

; AltIsDown := GetKeyState(Alt)

; if (GetKeyState(Alt))
; {
;     #Persistent
;     ToolTip, altdownnow, A_ScreenWidth, A_ScreenHeight
;     return
; }







; ; 
; ;显示提示
; #Persistent
; ToolTip, %OutputVar%, A_ScreenWidth, A_ScreenHeight
; SetTimer, RemoveToolTip, 600
; return

; RemoveToolTip:
; SetTimer, RemoveToolTip, Off
; ToolTip
; ;
; ExitApp


; SetTitleMatchMode, RegEx
; a = "a"
; b = "b"
; if WinActive("ahk_class Chrome_WidgetWin_1") and WinActive(" - Google Chrome$")
; {
;     MsgBox, %a%
; }
; else
; {
;     MsgBox, %b%
; }




;脚本部分↑
;========================================================================================
;========================================================================================
;========================================================================================
;========================================================================================
;========================================================================================
;========================================================================================
;========================================================================================
;快捷键部分↓


; tmp := [100, 100]
; move_click(target){
;     x := target[1]
;     y := target[2]
;     Send, {Click %x%, %y%}
; }


; Hotkey, IfWinActive, %win_title%
; Hotkey, +a, % move_click(tmp)
; Hotkey, +b, % move_click(tmp)



; move_click(tmp)



/*显示提示
mode_points := []
show_tips(mode)
{
    global tooltip_x
    global tooltip_y
    global mode_points
    mode_info := mode[1]
    mode.RemoveAt(1)
    mode_points :=[]
    for k in mode{
        mode_points.push(mode[k]*)
    }
    mode_len_points := mode_points.Length()
    ;显示主要提示
    ToolTip, %mode_info%, tooltip_x, tooltip_y, 20
    ;显示此模式下所有提示
    for k in mode_points{
        ToolTip, 1, mode_points[k][1], mode_points[k][2], k
    }
    return
}
hide_tips()
{
    global mode_points
    ToolTip, , , , 20
    for k in mode_points{
        ToolTip, , , , k
    }
    return
}


;快捷键仅在程序进行时启用
#if WinActive(win_title)

;按住中键？显示提示进行模式选择
; ~*LShift::
~*MButton::
current_mode := mode_main.Clone()
show_tips(current_mode)
loop
{
    Sleep, 10
    ; if !GetKeyState("LShift", "P")
    if !GetKeyState("MButton", "P")
        break
}
hide_tips()
return

#if

*/


;退出键，debug用
^!+[::ExitApp