# MK_Hotkeys
基于AutoHotkey天下霸图的快捷键工具

下载地址：  
[度盘](https://pan.baidu.com/s/1KxJ7imfTDixIGjzY_gS9yg)  
[Github](https://github.com/wf4gh/MK_Hotkeys/releases)  


#### 一、简单使用说明
（想尽快体验游戏的，只看这些就够了)  
1. 下载至任意位置  
2. 解压缩  
3. 以管理员权限运行main.exe    
4. 在游戏中按右Shift键，查看快捷键  
5. 使用

#### 二、进阶使用说明
- 自定义快捷键：  
	打开config.ini，修改“按键设置”部分。
	字母、数字直接用对应的字母、数字即可：
	```
	;系统
	k_op_system=s
	```
	Ctrl / Alt / Shift键单独使用时需要指定左右，如左Ctrl为LCtrl，右Shift为RShift:
	```
	;提示键，按下时显示提示
	k_tooltip=RShift
	```
- 自定义提示显示位置：
	修改以下两个值：
	```
	tooltip_prop_x=0.05
	tooltip_prop_y=0.1
	```
	tooltip_prop_x 取值0-1对应屏幕位置左到右，tooltip_prop_y 取值0-1对应屏幕位置上到下

#### 三、其他说明
虽然我没测试过，不过应该暂时不支持使用了分辨率补丁的版本。如果有需要的话，我会针对有分辨率补丁的版本做一些调整的。
