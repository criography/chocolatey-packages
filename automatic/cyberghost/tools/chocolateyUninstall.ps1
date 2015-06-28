. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageTitle   = "CyberGhost 5"
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
