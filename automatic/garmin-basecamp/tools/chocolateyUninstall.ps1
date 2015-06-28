. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageName    = "garmin-basecamp"
$packageTitle   = 'Garmin Basecamp'
$installerType  = "msi"
$silentArgs     = '/qn /norestart'


try {

  # find uninstall string in registry
  $clsid = GetUninstallString $packageTitle | % {$_ -replace 'MsiExec.exe /X', ''}

  # attempt uninstall
  Uninstall-ChocolateyPackage $packageName $installerType "$clsid $silentArgs" -validExitCodes @(0)

  # profit
  write-host "$packageTitle uninstalled successfully"


} catch {

  #cry
  throw $_.Exception.Message

}