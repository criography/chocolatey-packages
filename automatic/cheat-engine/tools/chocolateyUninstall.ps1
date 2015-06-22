$packageName = 'cheat-engine'
$programName = 'Cheat Engine {{PackageVersion}}'
$installerType = 'EXE'
$silentArgs = '/VERYSILENT /NORESTART'



try {

  # establish all possible locations for uninstaller to be stored
  $local_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall'
  $machine_key32 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
  $machine_key64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
  $reg_locations = @()

  if(Test-Path "$local_key"){
    $reg_locations += "$local_key\*"
  }

  if(Test-Path "$machine_key32"){
    $reg_locations += "$machine_key32\*"
  }

  if( ((Get-WmiObject Win32_Processor).AddressWidth -eq 64) -and (Test-Path "$machine_key64") ) {
    $reg_locations += "$machine_key64\*"
  }

  # find the actual uninstaller path
  $uninstaller = Get-ItemProperty -Path $reg_locations | ?{ $_.DisplayName -match $programName }

  # uninstall package
  Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $uninstaller.UninstallString

  # profit
  write-host "$packageName uninstalled successfully"
 
} catch {

  #cry
  throw $_.Exception.Message

}