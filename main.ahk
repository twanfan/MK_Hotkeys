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

TrayTip_title := "提示"


;从配置文件读取
IniRead, tooltip_key, .\Config.ini, Key, tooltip_key
IniRead, tooltip_prop_x, .\Config.ini, Position, tooltip_prop_x
IniRead, tooltip_prop_y, .\Config.ini, Position, tooltip_prop_y
IniRead, data_generated, .\Config.ini, Others, data_generated

;debug
ToolTip, script running..., 0, 0, 19

HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}

    WinWait, ahk_class Notepad
        HideTrayTip()
        TrayTip %TrayTip_title%, running detected, , 33
    WinWaitActive, ahk_class Notepad
        HideTrayTip()
        TrayTip %TrayTip_title%, active detected, , 33
    WinWaitNotActive, ahk_class Notepad
        HideTrayTip()
        TrayTip %TrayTip_title%, not active detected, , 33
    

;数据文件未生成时，先进行数据文件生成
if not %data_generated%
{
    tooltip_x := A_ScreenWidth * tooltip_prop_x
    tooltip_y := A_ScreenHeight * tooltip_prop_y
    HideTrayTip()
    TrayTip %TrayTip_title%, Waiting for running, , 1
    ; WinWait, ahk_class Notepad
    ;     TrayTip %TrayTip_title%, running detected
    ; WinWaitActive, ahk_class Notepad
    ;     TrayTip %TrayTip_title%, active detected
    ; WinWaitNotActive, ahk_class Notepad
    ;     TrayTip %TrayTip_title%, not active detected
    ; IfWinActive, ahk_class Notepad
    ; Loop
    ; {
    ;     if A_Index > 25
    ;         break  ; Terminate the loop
    ;     if A_Index < 20
    ;         continue ; Skip the below and start a new iteration
    ;     MsgBox, A_Index = %A_Index% ; This will display only the numbers 20 through 25
    ; }
    IfWinActive, ahk_class Notepad
        ToolTip, config..., tooltip_x, tooltip_y, 20
        return
    IfWinNotActive, ahk_class Notepad
        ToolTip
        TrayTip #1, This is TrayTip #1
        return
}
array := {ten: 10, twenty: 20, thirty: 30}
relative_positions := {"tooltip_main": [tooltip_prop_x, tooltip_prop_y]
    ,"tmp1":    [.2, .3]
    ,"tmp2":    [.5, .8]}
tmp := relative_positions["tmp2"][2]
MsgBox %tmp%

;计算所有位置

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
return


^!+[::ExitApp