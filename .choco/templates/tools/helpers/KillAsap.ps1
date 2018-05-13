# ====================================================
# KillAsap
# ====================================================
# Kills process as soon as it launches
#
# @param   {string}    Process Name
# @return  {void}
# ====================================================
Function KillAsap([string]$appName){
    if($appName -ne $null){
        $process = (Get-Process $($appName))
        if(!$process){
            start-sleep -m 250
            KillAsap $appName
        }else{
            $process | Stop-Process -force
        }

    }
}
