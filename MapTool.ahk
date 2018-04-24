CoordMode, Caret, Screen

~$*X::
dly:=50
Random, random, 1000000, 9999999
Gui, 5:destroy
Gui, 1:destroy
MouseGetPos, x, y
Gui, 5:Color, 0x0000ff
Gui, 5: -Caption +E0x80000 +LastFound +OwnDialogs +Owner +AlwaysOnTop +E0x20
gui, 5:margin,, 0
Gui, 5:Show, y%y% x%x% w1 h1 NoActivate, %random%
WinSet, TransColor, c0000ff 60
Gui, 5: Color, 0xff00ff
Gui, 1:Color, 0x00ff00
Gui, 1:Add, GroupBox, x20 y400 w800 h3
Gui, 1:Add, GroupBox, x400 y20 w1 h800
Gui, 1: -Caption +E0x80000 +LastFound +OwnDialogs +Owner +AlwaysOnTop +E0x20
xc := x - 400 -1
yc := y - 400 - 4
Gui, 1:Show, x%xc% y%yc% NoActivate, 456ztrf45tz6hfdy4wrrz646
WinSet, TransColor, c00ff00 60, 456ztrf45tz6hfdy4wrrz646
return

~$*B::
Reload
return

~$*C::
MouseGetPos, nx, ny
spx := nx - x
spy := ny - y
WinMove, %random%,,,, %spx%, %spy%
return

~$*V::
running=0
Gui, 5:destroy
IniWrite, %x%, pos.ini, First, X
IniWrite, %y%, pos.ini, First, Y
IniWrite, %nx%, pos.ini, Second, X
IniWrite, %ny%, pos.ini, Second, Y
IniWrite, %spx%, pos.ini, Size, Width
IniWrite, %spy%, pos.ini, Size, Height
ExitApp
return

GuiClose:
ExitApp
return