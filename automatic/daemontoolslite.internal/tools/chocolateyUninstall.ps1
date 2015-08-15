. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageTitle   = "DAEMON Tools Lite"
$trySilent      = 0;
$silentArgs     = '/VERYSILENT /NORESTART'



try {

    AutoUninstall `
        -programName    $packageTitle `
        -silentargs     $silentArgs

    write-host "$packageTitle uninstalled successfully"

} catch {
    throw $_.Exception
}
