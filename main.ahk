#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;设置ImageSearch全屏进行
CoordMode Pixel
;设置MouseMove全屏进行
CoordMode Mouse
;设置ToolTip全屏进行
CoordMode ToolTip

;从配置文件读取
IniRead, tooltip_key, .\Config.ini, KeyConfig, tooltip_key
IniRead, tooltip_prop_x, .\Config.ini, PosConfig, tooltip_prop_x
IniRead, tooltip_prop_y, .\Config.ini, PosConfig, tooltip_prop_y



array := {ten: 10, twenty: 20, thirty: 30}
relative_positions := {"tooltip_main": [tooltip_prop_x, tooltip_prop_y]
    ,"tmp1":    [.2, .3]
    ,"tmp2":    [.5, .8]}
tmp := relative_positions["tmp2"][2]
MsgBox %tmp%

;计算所有位置
tooltip_x := A_ScreenWidth * tooltip_prop_x
tooltip_y := A_ScreenHeight * tooltip_prop_y
; MsgBox, %tooltip_key%, %tooltip_x%, %tooltip_y%

Hotkey, %tooltip_key%, func

func:
    KeyWait %tooltip_key%, D
    ToolTip, altdownnow, tooltip_x, tooltip_y, 20
    ; ToolTip, altdownnow, A_ScreenWidth/2, A_ScreenHeight/2, 1
    SetTimer detect_key_press, 0
    KeyWait %tooltip_key%
    SetTimer detect_key_press, off
    ToolTip,,,, 20
    ToolTip,,,, 1
    return


detect_key_press:
    If GetKeyState(1, "P")
    {
        SetTimer detect_key_press, off
        ImageSearch, OutputVarX, OutputVarY, 0, 0, 2000, 2000, .\Images\m1.png
        if ErrorLevel   ; i.e. it's not blank or zero.
            MsgBox, an error occur, level %ErrorLevel%
        If (OutputVarX = "")
        {
            MsgBox NF, %A_ScreenWidth%, %A_ScreenHeight%
        }
        Else
        {
            MouseMove, OutputVarX, OutputVarY
            MsgBox %OutputVarX%,%OutputVarY%
        }
        return
    }
    If GetKeyState(2, "P")
    {
        SetTimer detect_key_press, off
        MouseMove, 500, 500
        MsgBox 2 pressed
        return
    }
return

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

;Ctrl+Alt+Shift+s 进行设置
^!+s::
MsgBox, setting


^!+[::
ExitApp