#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;debug
ToolTip, script running...%main_1%, 0, 0, 19

;设置ImageSearch全屏进行
CoordMode Pixel
;设置MouseMove全屏进行
CoordMode Mouse
;设置ToolTip全屏进行
CoordMode ToolTip

;检测程序运行情况并显示通知
on_start := True
old_activity := False
detect_active(){
    global on_start
    global old_activity
    if (on_start){
        old_activity := (WinActive("ahk_class Notepad") != 0)
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
    current_activity := (WinActive("ahk_class Notepad") != 0)
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
SetTimer, detect_active, 1000

;从配置文件读取
IniRead, tooltip_key, .\config.ini, Key, tooltip_key
IniRead, tooltip_prop_x, .\config.ini, Position, tooltip_prop_x
IniRead, tooltip_prop_y, .\config.ini, Position, tooltip_prop_y
IniRead, data_generated, .\config.ini, Others, data_generated

;读取位置信息
IniRead, main_1, .\config.ini, Position, main_1
IniRead, main_2, .\config.ini, Position, main_2
IniRead, main_3, .\config.ini, Position, main_3
IniRead, main_4, .\config.ini, Position, main_4
IniRead, sys_1, .\config.ini, Position, sys_1
IniRead, sys_2, .\config.ini, Position, sys_2
IniRead, sl_1, .\config.ini, Position, sl_1
IniRead, sl_2, .\config.ini, Position, sl_2

;根据原始位置信息，计算比例
find_pos(pos_info){
    pos_lst := []
    info := StrSplit(pos_info, ",")
    x1 := info[1]
    y1 := info[2]
    x2 := info[3]
    y2 := info[4]
    xic := info[6] - 1 ;x axis interval count
    yic := info[5] - 1 ;y axis interval count
}

WinWait, ahk_class Notepad
HideTrayTip()
TrayTip info, running detected, , 1

;清除托盘提示
HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}

tooltip_x := A_ScreenWidth * tooltip_prop_x
tooltip_y := A_ScreenHeight * tooltip_prop_y


; if (WinActive("ahk_class Martial Kindom"))
; {
;     MsgBox, activenow
; }
; if (WinActive("ahk_class Notepad"))
; {
;     MsgBox, act
; }
; if (!WinActive("ahk_class Notepad"))
; {
;     MsgBox, notAct
; }

array := {ten: 10, twenty: 20, thirty: 30}
relative_positions := {"tooltip_main": [tooltip_prop_x, tooltip_prop_y]
    ,"tmp1":    [.2, .3]
    ,"tmp2":    [.5, .8]}
tmp := relative_positions["tmp2"][2]
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
;     If GetKeyState(1, "P")
;     {
;         SetTimer detect_key_press, off
;         ImageSearch, OutputVarX, OutputVarY, 0, 0, 2000, 2000, .\Images\m1.png
;         if ErrorLevel   ; i.e. it's not blank or zero.
;             MsgBox, an error occur, level %ErrorLevel%
;         If (OutputVarX = "")
;         {
;             MsgBox NF, %A_ScreenWidth%, %A_ScreenHeight%
;         }
;         Else
;         {
;             MouseMove, OutputVarX, OutputVarY
;             MsgBox %OutputVarX%,%OutputVarY%
;         }
;         return
;     }
;     If GetKeyState(2, "P")
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
; If WinActive("ahk_class Chrome_WidgetWin_1") and WinActive(" - Google Chrome$")
; {
;     MsgBox, %a%
; }
; Else
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

#IfWinActive ahk_class Notepad

current_mode := "main"

show_tips(mode:="main")
{
    ToolTip, %mode%, 200, 200, 18
    return
}

;按住中键进行模式选择
~*LShift::
ToolTip, 
(
im
fs
dfsf
dsaf
), 0, 0, 19

show_tips(current_mode)
Loop
{
    Sleep, 10
    if !GetKeyState("LShift", "P")  ; The key has been released, so break out of the loop.
        break
    ; ... insert here any other actions you want repeated.
}
ToolTip, , 0, 0, 19
ToolTip, , 0, 0, 18
return

;Ctrl+Alt+Shift+s 进行设置
^!+s::
MsgBox, setting
return

#If

;退出键，debug用
^!+[::ExitApp