#NoEnv
#NoTrayIcon
SendMode Input
SetControlDelay -1
CoordMode, Mouse, Window
SetTitleMatchMode RegEx


steps := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

WinWaitActive, Setup - CyberGhost 6.*
    for each, value in steps {
        Sleep, 500
        ControlSend, , {Tab}{Tab}{Space}
    }


WinWait, ^CyberGhost.*
    WinKill


Process, close, CyberGhost.exe
Process, close, CyberGhost
Process, close, cg.exe
Process, close, cgsetup.*


WinWait, ^CyberGhost.*
    WinKill
