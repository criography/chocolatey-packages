. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageTitle   = 'Cheat Engine {{PackageVersion}}'
$silentArgs     = '/VERYSILENT /NORESTART'



try {

    AutoUninstall `
        -programName    $packageTitle `
        -silentargs     $silentArgs

} catch {
    throw $_.Exception
}
