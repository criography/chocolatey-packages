. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageName    = 'cyberghost'
$packageTitle   = 'CyberGhost 5'
$installerType  = 'EXE'
$silentArgs     = '/VERYSILENT /NORESTART'



try {

  # find uninstall string in registry
  $uninstallString = GetUninstallString $packageTitle

  # attempt uninstall
  Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $uninstallString

  # profit
  write-host "$packageTitle uninstalled successfully"

} catch {

  #cry
  throw $_.Exception.Message

}