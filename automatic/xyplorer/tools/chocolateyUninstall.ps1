$packageName = 'xyplorer'    
$programName = 'XYplorer'
$installerType = 'EXE'
$silentArgs = '/S'



try {

  # establish all possible locations for uninstaller to be stored
  $local_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
  $machine_key32 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
  $machine_key64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'

  # find the actual uninstaller path
  $uninstaller = Get-ItemProperty -Path @($local_key, $machine_key32, $machine_key64) | ?{ $_.DisplayName -match $programName }

  # uninstall package
  Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $uninstaller.UninstallString

  # profit
  write-host "$packageName uninstalled successfully"
 
} catch {

  #cry
  throw $_.Exception.Message

}