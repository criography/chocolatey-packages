#NoEnv
#NoTrayIcon
SetTitleMatchMode RegEx
SetKeyDelay, 10, 10


; Vars
RegWindowTitle = Hard Disk Sentinel Evaluation Version



; Trigger Listener
WinWaitActive, %RegWindowTitle%
    CloseReg()





; Close Registration popup once possible to close (buttons on delay)
CloseReg()
{
    IfWinExist, %RegWindowTitle%
    {
        ControlSend, , !c
        sleep, 100
        CloseReg()

    } else {
        CloseWindow()

    }
}




; Close main window once possible to close
CloseWindow()
{
    IfWinExist, Hard Disk Sentinel \d.*
    {
        WinActivate
        Send {LAlt down}
        Send {f down}
        Send x
        Send {f up}
        Send {LAlt up}
        sleep, 100
        CloseWindow()
    }
}

