$packageName = 'xyplorer'    
$programName = 'XYplorer'
$installerType = 'EXE'
$silentArgs = '/S'

try {
 
  $local_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
  $machine_key32 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
  $machine_key64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'

  $uninstaller = Get-ItemProperty -Path @($local_key, $machine_key32, $machine_key64) | ?{ $_.DisplayName -match $programName }

  Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $uninstaller.UninstallString
 
  write-host "$packageName uninstalled successfully"
 
} catch {
  throw $_.Exception.Message
}