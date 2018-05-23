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
IniRead, OutputVar, .\Config.ini, KeyConfig, function_key

function_key := OutputVar

Hotkey, %function_key%, func

func:
    KeyWait %function_key%, D
    ToolTip, altdownnow, 0, 0, 20
    ; ToolTip, altdownnow, A_ScreenWidth/2, A_ScreenHeight/2, 1
    SetTimer detect_key_press, 0
    KeyWait %function_key%
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
; ; 222222 2
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




^!+[::
ExitApp