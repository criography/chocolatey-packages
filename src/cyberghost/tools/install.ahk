#NoEnv
#NoTrayIcon
SetTitleMatchMode RegEx




; initiate first listener
WinWaitActive, Setup - CyberGhost \d.*
    ProceedOnInstaller()




; Proceed on webinstaller's prompt
ProceedOnInstaller()
{
    IfWinExist
    {
        ControlSend, , {Tab}{Tab}{Space}
        sleep, 100
        ProceedOnInstaller()

    } else {
        KillAll()

    }
}




; Kill all autospawning windows and processes
KillAll(){
    WinWait, ^CyberGhost.*
        WinKill
        Process, Close, CyberGhost.exe
        Process, Close, cg.exe
}

