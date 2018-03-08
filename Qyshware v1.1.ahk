cversion := 11
global cversion
If(A_IsAdmin)
{
	IfExist, C:\Users\%A_UserName%\check.txt
	{
		FileDelete, C:\Users\%A_UserName%\check.txt
	}
    URLDownloadToFile, https://raw.githubusercontent.com/MoHatKnock/Qyshware/master/status.txt, C:\Users\%A_UserName%\check.txt
    FileSetAttrib, +H, C:\Users\%A_UserName%\check.txt
	ToolTip
	IfNotExist, C:\Users\%A_UserName%\check.txt
	{
		MsgBox, 64, Update check, Error while checking for Updates.
		Goto, checked
	}
	IfExist, C:\Users\%A_UserName%\check.txt
	{
		FileReadLine, check, C:\Users\%A_UserName%\check.txt, 1
		FileReadLine, version, C:\Users\%A_UserName%\check.txt, 2
		FileReadLine, line1, C:\Users\%A_UserName%\check.txt, 3
		FileReadLine, line2, C:\Users\%A_UserName%\check.txt, 4
		FileReadLine, line3, C:\Users\%A_UserName%\check.txt, 5
		FileReadLine, line4, C:\Users\%A_UserName%\check.txt, 6
		Sleep, 1000
		if(check==2)
		{
			MsgBox, 64, Info, %line1%`n%line2%`n%line3%`n%line4%
		}
		else if(check==1)
		{
			if(cversion != version)
			{
				version := version / 10
				ver := Rtrim(version, "0")
				MsgBox, 68, Update, Qyshware v%ver% is out! do you want to go to the Github page?
				IfMsgBox, Yes
				{
					Run, https://github.com/MoHatKnock/Qyshware
				}
				IfMsgBox, No
				{
					Goto, checked
				}
			}
			else
			{
				Goto, checked
			}
		}
	}
}
If(!A_IsAdmin)
{
	MsgBox, 16, Admin request, You have to run this Script as an Admin!
}
return
checked:
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#MaxThreadsPerHotkey 255
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, 0, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetWorkingDir %A_ScriptDir%
SendMode Input
configname := "cfg.ini"
;-------------------------------------------------------------
IfNotExist, %configname%
{
	IniWrite, 255, %configname%, Color, Red
	IniWrite, 255, %configname%, Color, Green
	IniWrite, 255, %configname%, Color, Blue
	IniWrite, 0, %configname%, Rifles, abSpeed
	IniWrite, 0, %configname%, Rifles, abDelay
	IniWrite, a, %configname%, Keys, Aimbot
	IniWrite, 0, %configname%, Rifles, lrSpeed
	IniWrite, 0, %configname%, Rifles, lrDelay
	IniWrite, b, %configname%, Keys, LessRecoil
	IniWrite, c, %configname%, Keys, Trigger
	IniWrite, 0, %configname%, Rifles, b_r_h
	IniWrite, 0, %configname%, Rifles, b_r_t
	IniWrite, 0, %configname%, Rifles, ab_r_h
	IniWrite, 0, %configname%, Rifles, ab_r_t
	IniWrite, 0, %configname%, Rifles, lr_r_t
	IniWrite, 0, %configname%, Rifles, lr_r_h
	IniWrite, 0, %configname%, Rifles, lr_r_a
	IniWrite, 0, %configname%, Rifles, b_active
	IniWrite, 0, %configname%, Rifles, lr_active
	IniWrite, 0, %configname%, Rifles, ab_active
}
;--------------------------------------------------------------
IfExist, %configname%
{
	IniRead, IniRed, %configname%, Color, Red
	IniRead, IniGreen, %configname%, Color, Green
	IniRead, IniBlue, %configname%, Color, Blue
	IniRead, Ini_ab_s, %configname%, Rifles, abSpeed
	IniRead, Ini_ab_d, %configname%, Rifles, abDelay
	IniRead, Ini_ab_k, %configname%, Keys, Aimbot
	IniRead, Ini_lr_s, %configname%, Rifles, lrSpeed
	IniRead, Ini_lr_d, %configname%, Rifles, lrDelay
	IniRead, Ini_lr_k, %configname%, Keys, LessRecoil
	IniRead, Ini_b_k, %configname%, Keys, Trigger
}
;--------------------------------------------------------------
Hotkey, ~$*%Ini_ab_k%, toggleaimbot
Hotkey, ~$*%Ini_lr_k%, togglelessrecoil
Hotkey, ~$*%Ini_b_k%, toggletrigger
;--------------------------------------------------------------
toggleaimbot=0
togglelessrecoil=0
toggletrigger=0
Goto, Gui
;--------------------------------------------------------------
toggleaimbot:
Gui, submit, nohide
if(ab_h==1 and ab_active==1)
{
	while(GetKeyState(Ini_ab_k, "p"))
	{
		PixelSearch, x, y, 100, 60, 176, 179, 0x1515FF, 30, Fast
		if(y!=null)
		{
			math := ab_s
			if(x>=139)
			{
				DllCall("mouse_event", uint, 1, int, math, int, 0, uint, 0, int, 0)
			}
			else if(x<=137)
			{
				DllCall("mouse_event", uint, 1, int, -math / 2, int, 0, uint, 0, int, 0)
			}
		}
		Sleep, %ab_d%
	}
}
else if(ab_t==1 and ab_active==1)
{
	if(toggleaimbot==0)
	{
		toggleaimbot=1
		while(GetKeyState(Ini_ab_k, "t"))
		{
			PixelSearch, x, y, 100, 66, 176, 179, 0x1515FF, 30, Fast
			if(y!=null)
			{
				math := ab_s
				if(x>=139)
				{
					DllCall("mouse_event", uint, 1, int, math / 2, int, 0, uint, 0, int, 0)
				}
				else if(x<=137)
				{
					DllCall("mouse_event", uint, 1, int, -math / 2, int, 0, uint, 0, int, 0)
				}
			}
			Sleep, %ab_d%
		}
	}
	else if(toggleaimbot==1)
	{
		toggleaimbot=0
	}
}
return

togglelessrecoil:
if(togglelessrecoil==0)
	{
		togglelessrecoil=1
	}
	else if(togglelessrecoil==1)
	{
		togglelessrecoil=0
	}
return

toggletrigger:
if(b_h==1 and b_active)
{
	while(GetKeyState(Ini_b_k, "p"))
	{
		PixelSearch, xt, yt, 100, 66, 176, 179, 0x1515FF, 30, Fast
		if(xt<140 and xt>136)
		{
			Click
			Sleep, 100
		}
		Sleep, 1
	}
}
else if(b_t==1 and b_active)
{
	if(toggletrigger==0)
	{
		toggletrigger=1
		while(GetKeyState(Ini_b_k, "t"))
		{
			PixelSearch, xt, yt, 100, 66, 176, 179, 0x1515FF, 30, Fast
			if(xt<140 and xt>136)
			{
				Click
				Sleep, 100
			}
			Sleep, 1
		}
	}
	else
	{
		toggletrigger=0
	}
}
return
;--------------------------------------------------------------
Gui:
Inicolor := RGB(IniRed *  5, IniGreen * 5, IniBlue * 5)
Gui, color, %Inicolor%
Gui, Add, GroupBox, x2 y-1 w280 h170 , Aimbot
Gui, Add, CheckBox, x12 y19 w70 h20 vab_active gUpdate, Active
Gui, Add, Button, x192 y109 w80 h20 gAimbotHelp, Help
Gui, Add, Text, x12 y49 w50 h20 , Speed:
Gui, Add, Slider, x72 y49 w200 h20 vab_s gUpdate +ToolTip AltSubmit Range1-50, %Ini_ab_s%
Gui, Add, Text, x12 y79 w50 h20 , Delay:
Gui, Add, Slider, x72 y79 w200 h20 vab_d gUpdate +ToolTip AltSubmit Range0-10, %Ini_ab_d%
Gui, Add, Radio, x12 y109 w80 h20 vab_h gUpdate, Hold
Gui, Add, Radio, x102 y109 w80 h20 vab_t gUpdate, Toggle
Gui, Add, Text, x12 y141 w50 h20 , Key:
Gui, Add, Edit, x72 y139 w60 h20 ReadOnly, %Ini_ab_k%
Gui, Add, Text, x152 y141 w50 h20 , Change:
Gui, Add, Hotkey, x212 y139 w60 h20 vab_h_key gab_h_key, 
Gui, Add, GroupBox, x292 y-1 w320 h170 , LessRecoil
Gui, Add, CheckBox, x302 y19 w70 h20 vlr_active gUpdate, Active
Gui, Add, Text, x302 y49 w50 h20 , Speed:
Gui, Add, Slider, x362 y49 w200 h20 vlr_s gUpdate +ToolTip AltSubmit Range1-20, %Ini_lr_s%
Gui, Add, Text, x302 y79 w50 h20 , Delay:
Gui, Add, Slider, x362 y79 w200 h20 vlr_d gUpdate +ToolTip AltSubmit Range0-100, %Ini_lr_d%
Gui, Add, Radio, x302 y109 w80 h20 vlr_h gUpdate, Hold
Gui, Add, Radio, x392 y109 w80 h20 vlr_t gUpdate, Toggle
Gui, Add, Radio, x482 y109 w80 h20 vlr_a gUpdate, Always
Gui, Add, Text, x302 y141 w60 h20 , Current Key:
Gui, Add, Edit, x362 y139 w60 h20 ReadOnly, %Ini_lr_k%
Gui, Add, Text, x442 y141 w60 h20 , Change:
Gui, Add, Hotkey, x502 y139 w60 h20 vlr_h_key glr_h_key, 
Gui, Add, GroupBox, x2 y169 w280 h110 , Triggerbot
Gui, Add, CheckBox, x12 y189 w70 h20 vb_active gUpdate, Active
Gui, Add, Radio, x12 y219 w70 h20 vb_h gUpdate, Hold
Gui, Add, Radio, x92 y219 w80 h20 vb_t gUpdate, Toggle
Gui, Add, Text, x12 y251 w60 h20 , Current Key:
Gui, Add, Edit, x72 y249 w60 h20 ReadOnly, %Ini_b_k%
Gui, Add, Text, x152 y251 w60 h20 , Change:
Gui, Add, Hotkey, x212 y249 w60 h20 vb_h_key gb_h_key, 
Gui, Add, Button, x182 y219 w90 h20 gtriggerhelp, Help
Gui, Add, GroupBox, x292 y169 w320 h110 , Color
Gui, Add, Progress, x522 y189 w80 h60 +Border Background vprogress, 0
Gui, Add, Button, x521 y251 w82 h18 gSubmitColor, Submit
Gui, Add, Slider, x342 y189 w170 h20 vRed gUpdateColor +ToolTip AltSubmit Range0-51, %IniRed%
Gui, Add, Slider, x342 y219 w170 h20 vGreen gUpdateColor +ToolTip AltSubmit Range0-51, %IniGreen%
Gui, Add, Slider, x342 y249 w170 h20 vBlue gUpdateColor +ToolTip AltSubmit Range0-51, %IniBlue%
Gui, Add, Text, x302 y189 w40 h20 , Red:
Gui, Add, Text, x302 y219 w40 h20 , Green:
Gui, Add, Text, x302 y249 w40 h20 , Blue:
Gui, Add, GroupBox, x622 y-1 w210 h280 , Config
Gui, Add, Text, x632 y19 w50 h20 , Config:
Gui, Add, DropDownList, x692 y19 w130 h100 gUpdate vddl, Rifles||Mps|Pistols|MM|Deathmatch
Gui, Add, Button, x632 y49 w90 h20 gLoad, Load
Gui, Add, Button, x732 y49 w90 h20 gSave, Save
Gui, Add, GroupBox, x632 y79 w190 h190 , Custom - Config
Gui, Add, Text, x642 y101 w50 h20 , Filename:
Gui, Add, Edit, x702 y99 w110 h20 vcconfig gUpdate, config
Gui, Add, Button, x642 y129 w80 h20 gcustomsave, Save
Gui, Add, Button, x732 y129 w80 h20 gcustomdelete, Delete
Gui, Add, Button, x642 y159 w170 h20 gcustomload, Load
Gui, Add, GroupBox, x642 y179 w170 h80 , Credits
Gui, Add, Button, x652 y229 w150 h20 gtl, Thread Link
Gui, Add, Text, x652 y201 w150 h20 , Made by MoHatKnock from UC
Gui, Show, w834 h280, CS:GO - Qyshware
GuiControl,+Background%Inicolor%, progress
;--------------------------------------------------------------
global ab_s
global ab_d
global ab_k
global lr_s
global lr_d
global lr_k
global ddl
global Red
global Green
global Blue
global b_h
global b_t
global ab_h
global ab_t
global lr_h
global lr_t
global lr_a
global lr_active
global ab_active
global b_active
;--------------------------------------------------------------
return

ab_h_key:
	Gui, submit, nohide
	IniWrite, %ab_h_key%, %configname%, Keys, Aimbot
	MouseGetPos, x, y
	ToolTip, Saving Hotkey.., %x%, %y%
	Loop, 50
	{
		MouseGetPos, x, y
		ToolTip, Saving Hotkey.., %x%, %y%
		Sleep, 10
	}
	reload
return

lr_h_key:
	Gui, submit, nohide
	IniWrite, %lr_h_key%, %configname%, Keys, LessRecoil
	MouseGetPos, x, y
	ToolTip, Saving Hotkey.., %x%, %y%
	Loop, 50
	{
		MouseGetPos, x, y
		ToolTip, Saving Hotkey.., %x%, %y%
		Sleep, 10
	}
	reload
return

b_h_key:
	Gui, submit, nohide
	IniWrite, %b_h_key%, %configname%, Keys, Trigger
	MouseGetPos, x, y
	ToolTip, Saving Hotkey.., %x%, %y%
	Loop, 50
	{
		MouseGetPos, x, y
		ToolTip, Saving Hotkey.., %x%, %y%
		Sleep, 10
	}
	reload
return

customsave:
	Gui, submit, nohide
	pass := cconfig ".ini"
	saveall(pass, "Custom")
return

customload:
	Gui, submit, nohide
	pass := cconfig ".ini"
	IfNotExist, %pass%
	{
		MsgBox, 16, Error, The config file: %pass% doesnt exist!
	}
	IfExist, %pass%
	{
		loadall(pass, "Custom")
	}
return

customdelete:
	Gui, submit, nohide
	pass := cconfig ".ini"
	IfNotExist, %pass%
	{
		MsgBox, 16, Error, The config file: %pass% doesnt exist!
	}
	IfExist, %pass%
	{
		MsgBox, 20, Delete Config, Do you really want to delete the config: %pass% ?
		IfMsgBox, Yes
		{
			FileDelete, %cconfig%.ini
		}
	}
return

~$*LButton::
	while(GetKeyState("LButton", "p") and WinActive("Counter-Strike: Global Offensive") and lr_active==1)
	{
		if(lr_a==1)
		{
			DllCall("mouse_event", uint, 1, int, 0, int, lr_s, uint, 0, int, 0)
			Sleep, %lr_d%
		}
		if(togglelessrecoil==1 and lr_t==1)
		{
			DllCall("mouse_event", uint, 1, int, 0, int, lr_s, uint, 0, int, 0)
			Sleep, %lr_d%
		}
		if(GetKeyState(Ini_lr_k, "p") and lr_h==1)
		{
			DllCall("mouse_event", uint, 1, int, 0, int, lr_s, uint, 0, int, 0)
			Sleep, %lr_d%
		}
	}
return

Update:
Gui, submit, nohide
return

UpdateColor:
	Gui, submit, nohide
	color := RGB(Red * 5, Green * 5, Blue * 5)
	GuiControl,+Background%color%, progress
return

AimbotHelp:
	MsgBox, 36, Aimbot Help, Do you want to open the Help page?
	IfMsgBox, Yes
	{
		Run, https://raw.githubusercontent.com/MoHatKnock/Qyshware/master/Aimbothelp.txt
	}
return

triggerhelp:
MsgBox, 36, Triggerbot Help, Do you want to open the Help page?
	IfMsgBox, Yes
	{
		Run, https://raw.githubusercontent.com/MoHatKnock/Qyshware/master/Triggerbothelp.txt
	}
return

SubmitColor:
	Gui, submit, nohide
	MouseGetPos, x, y
	ToolTip, Saving Colors.., %x%, %y%
	IniWrite, %Red%, %configname%, Color, Red
	IniWrite, %Green%, %configname%, Color, Green
	IniWrite, %Blue%, %configname%, Color, Blue
	Loop, 50
	{
		MouseGetPos, x, y
		ToolTip, Saving Colors.., %x%, %y%
		Sleep, 10
	}
	reload
return

tl:
	MsgBox, Temporarily disabled!
return

RGB(r, g, b) {
	var:=(r << 16) + (g << 8) + b
	Old := A_FormatInteger
	SetFormat, Integer, Hex
	var += 0
	SetFormat, Integer, %Old%
	return var
}

Load:
	Gui, submit, nohide
	loadall(configname, ddl)
return

Save:
	Gui, submit, nohide
	saveall(configname, ddl)
return

saveall(configname, cfgname)
{
	Gui, submit, nohide
	IniWrite, %ab_s%, %configname%, %cfgname%, abSpeed
	IniWrite, %ab_d%, %configname%, %cfgname%, abDelay
	IniWrite, %lr_s%, %configname%, %cfgname%, lrSpeed
	IniWrite, %lr_d%, %configname%, %cfgname%, lrDelay
	IniWrite, %b_h%, %configname%, %cfgname%, b_r_h
	IniWrite, %b_t%, %configname%, %cfgname%, b_r_t
	IniWrite, %ab_h%, %configname%, %cfgname%, ab_r_h
	IniWrite, %ab_t%, %configname%, %cfgname%, ab_r_t
	IniWrite, %lr_t%, %configname%, %cfgname%, lr_r_t
	IniWrite, %lr_h%, %configname%, %cfgname%, lr_r_h
	IniWrite, %lr_a%, %configname%, %cfgname%, lr_r_a
	IniWrite, %b_active%, %configname%, %cfgname%, b_active
	IniWrite, %lr_active%, %configname%, %cfgname%, lr_active
	IniWrite, %ab_active%, %configname%, %cfgname%, ab_active
}

loadall(configname, cfgname)
{
	Gui, submit, nohide
	IniRead, Ini_ab_s, %configname%, %cfgname%, abSpeed
	IniRead, Ini_ab_d, %configname%, %cfgname%, abDelay
	IniRead, Ini_lr_s, %configname%, %cfgname%, lrSpeed
	IniRead, Ini_lr_d, %configname%, %cfgname%, lrDelay
	IniRead, Ini_b_h, %configname%, %cfgname%, b_r_h
	IniRead, Ini_b_t, %configname%, %cfgname%, b_r_t
	IniRead, Ini_ab_h, %configname%, %cfgname%, ab_r_h
	IniRead, Ini_ab_t, %configname%, %cfgname%, ab_r_t
	IniRead, Ini_lr_t, %configname%, %cfgname%, lr_r_t
	IniRead, Ini_lr_h, %configname%, %cfgname%, lr_r_h
	IniRead, Ini_lr_a, %configname%, %cfgname%, lr_r_a
	IniRead, Ini_b_active, %configname%, %cfgname%, b_active
	IniRead, Ini_lr_active, %configname%, %cfgname%, lr_active
	IniRead, Ini_ab_active, %configname%, %cfgname%, ab_active
	GuiControl,, ab_s, %Ini_ab_s%
	GuiControl,, ab_d, %Ini_ab_d%
	GuiControl,, lr_s, %Ini_lr_s%
	GuiControl,, lr_d, %Ini_lr_d%
	GuiControl,, lr_t, %Ini_lr_t%
	GuiControl,, lr_h, %Ini_lr_h%
	GuiControl,, lr_a, %Ini_lr_a%
	GuiControl,, ab_t, %Ini_ab_t%
	GuiControl,, ab_h, %Ini_ab_h%
	GuiControl,, b_h, %Ini_b_h%
	GuiControl,, b_t, %Ini_b_t%
	GuiControl,, b_active, %Ini_b_active%
	GuiControl,, lr_active, %Ini_lr_active%
	GuiControl,, ab_active, %Ini_ab_active%
}

GuiClose:
ExitApp
return