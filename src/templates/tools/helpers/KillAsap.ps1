# ====================================================
# KillAsap
# ====================================================
# Iniates Kill Listener
#
# @param   {string}    Process Name
# @return  {void}
# ====================================================
Function KillAsap([string]$appName){
    $timerStart = (Get-Date)
    $timeout    = 15 #seconds

    KillAttempt $appName $timeout
}




# ====================================================
# KillAttempt
# ====================================================
# Check for given process and try to kill it.
# If it doesn't exists, retry after specific delay.
# If retries exceed max allowed duration, give up.
#
# @param   {string}    Process Name
# @param   {int}       Timeout [s]
# @return  {void}
# ====================================================
Function KillAttempt([string]$appName, [int]$timeout){
    $countdown = $timeout - ((Get-Date) - $timerStart).Seconds


    # Exit after $timeout seconds if unseccessful
    if($countdown -le 0){
        Write-Host "`nNo '$appName' windows found. Proceeding."
        return;
    }



    # Kill the process if present, otherwise retry
    if($appName -ne $null){
        $process = (Get-Process $($appName) 2> $null)

        if(!$process){
            Write-Host -NoNewLine "`rWaiting for '$appName' to spawn its windows: $countdown "
            Start-Sleep -m 333
            KillAttempt $appName $timeout

        }else{
            $process | Stop-Process -force
            Write-Host "'$appName' windows found and closed. Proceeding."

        }

    }
}
