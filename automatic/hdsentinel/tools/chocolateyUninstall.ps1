. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageTitle   = "Hard Disk Sentinel"
$trySilent      = 1;
$silentArgs     = "/sp- /verysilent /norestart"



try {

    AutoUninstall `
        -programName    $packageTitle `
        -trySilent      $trySilent `
        -silentargs     $silentArgs

} catch {
    throw $_.Exception
}
