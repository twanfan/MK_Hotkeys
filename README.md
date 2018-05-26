# MK_Hotkeys
基于AutoHotkey天下霸图的快捷键工具

下载地址：  
[度盘](https://pan.baidu.com/s/1KxJ7imfTDixIGjzY_gS9yg)  
[Github](https://github.com/wf4gh/MK_Hotkeys/releases)  


#### 一、简单使用说明
（想尽快体验游戏的，只看这些就够了)  
1. 下载至任意位置  
2. 解压缩  
3. 以管理员权限运行  
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
	修改config.ini中以下两个值：
	```
	tooltip_prop_x=0.05
	tooltip_prop_y=0.1
	```
	tooltip_prop_x 取值0-1对应屏幕位置左到右，tooltip_prop_y 取值0-1对应屏幕位置上到下
---
## 更新记录
### v0.1.0
2018.05.26
- 最初版本，可通过快捷键实现：
	- 进入经营界面的主要子菜单
	- 一键存档 / 读档
	- 一键切换游戏速度最快 / 最慢

### v0.2.0
2018.05.26
- 增加了对各种不同分辨率的支持，使用了分辨率补丁版本的游戏应该也能正常使用了
- 支持在游戏开始界面直接按快速读取快捷键读取快速保存的存档
- 增加了各子菜单（人物、交易等）的返回快捷键