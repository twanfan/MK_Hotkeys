#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;设置MouseMove全屏进行
CoordMode Mouse
;设置ToolTip全屏进行
CoordMode ToolTip

^!z::
MouseGetPos, xpos, ypos
ToolTip, %xpos% `, %ypos%, 0, 0
Clipboard = %xpos%%A_Tab%%ypos%
Return

^!+[::ExitApp