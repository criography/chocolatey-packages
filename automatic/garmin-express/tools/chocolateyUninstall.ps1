. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageName    = "garmin-express"
$packageTitle   = 'Garmin Express'
$installerType  = "EXE"
$silentArgs     = ''


try {

  # find uninstall string in registry
  $uninstallString = GetUninstallString $packageTitle 1

  if( $uninstallString -is [System.Array] ){
    $uninstallString = $uninstallString | ?{ $_ -NotLike "MsiExec.exe*" }
  }

  $silentArgs      = $uninstallString -replace '^\".*?\"\s+(.*?)$', '$1'
  $uninstallString = $uninstallString | %{  $_  -replace '\"\s+.*?$', '"' }


  # attempt uninstall
  Uninstall-ChocolateyPackage $packageName $installerType $($silentArgs) $($uninstallString)

  # profit
  write-host "$packageTitle uninstalled successfully"


} catch {

  #cry
  throw $_.Exception.Message

}