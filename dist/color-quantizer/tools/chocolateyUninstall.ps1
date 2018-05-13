. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\GetMenuStartPath.ps1')

$packageTitle = "Color Quantizer"
$packageName  = "color-quantizer"
$installDir   = Join-Path $(Get-ToolsLocation) "$packageName"
$startMenu    = $(GetMenuStartPath)


Remove-Item "$installDir" -Force -Recurse
Remove-Item "$startMenu\Programs\$packageTitle" -Force -Recurse
