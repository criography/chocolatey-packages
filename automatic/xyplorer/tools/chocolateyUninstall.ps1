. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageTitle   = "XYplorer"
$trySilent      = 0;
$silentArgs     = '/S'



try {

    AutoUninstall `
        -programName    $packageTitle `
        -trySilent      $trySilent `
        -silentargs     $silentArgs

} catch {
    throw $_.Exception
}
