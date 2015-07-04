. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageTitle   = "BitMeter"
$silentArgs     = "/S /NCRC"



try {

    AutoUninstall `
        -programName    $packageTitle `
        -silentargs     $silentArgs

} catch {
    throw $_.Exception
}
