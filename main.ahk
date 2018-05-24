#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;debug
ToolTip, script running..., 0, 0, 19

;设置ImageSearch全屏进行
CoordMode Pixel
;设置MouseMove全屏进行
CoordMode Mouse
;设置ToolTip全屏进行
CoordMode ToolTip


;定义程序窗口名称
; SetTitleMatchMode, RegEx
; win_title := "Martial Kingdoms"
win_title := "ahk_class Notepad"


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
            TrayTip info, detected running1, , 1
        }else{
            HideTrayTip()
            TrayTip info, Waiting for running2, , 1
        }
        return
    }
    current_activity := (WinActive(win_title) != 0)
    if (current_activity != old_activity){
        if (old_activity){
            old_activity := current_activity
            HideTrayTip()
            TrayTip info, Waiting for running3, , 1
        }else{
            old_activity := current_activity
            HideTrayTip()
            TrayTip info, detected running4, , 1
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

WinWait, %win_title%
sleep, 500

;从配置文件读取基本信息
IniRead, tooltip_key, .\config.ini, Key, tooltip_key
IniRead, tooltip_prop_x, .\config.ini, Position, tooltip_prop_x
IniRead, tooltip_prop_y, .\config.ini, Position, tooltip_prop_y
; IniRead, data_generated, .\config.ini, Others, data_generated

tooltip_x := A_ScreenWidth * tooltip_prop_x
tooltip_y := A_ScreenHeight * tooltip_prop_y
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


;根据位置比例信息及当前分辨率计算实际位置
find_pos(pos_info){
    info := StrSplit(pos_info, ",")
    x := info[1] * A_ScreenWidth
    y := info[2] * A_ScreenHeight
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

ToolTip, , , , 20

to_click(abs_pos){
    MouseClick, , % abs_pos[1], % abs_pos[2], , 0
}


Hotkey, IfWinActive, %win_title%
Hotkey, *h, % to_click(abs_op_history)

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
;     KeyWait %tooltip_key%, D
;     ToolTip, altdownnow, tooltip_x, tooltip_y, 20
;     ; ToolTip, altdownnow, A_ScreenWidth/2, A_ScreenHeight/2, 1
;     SetTimer detect_key_press, 0
;     KeyWait %tooltip_key%
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