$packageName    = "{{PackageName}}"
$driversTitle   = "Garmin` USB` Drivers"
$installerType  = "msi"
$url            = "{{DownloadUrl}}"
$silentArgs     = '/qn /norestart'
$tempDir        = Join-Path $env:TEMP "chocolatey" | Join-Path -ChildPath "$packageName" | Join-Path -ChildPath "extracted-msi"

try{


	Install-ChocolateyZipPackage "$packageName" "$url" "$tempDir"

	#determine system version
	$osType = Get-ProcessorBits

	#install usb drivers
	$driverName = Join-Path $tempDir 'USB_Drivers' | Join-Path -ChildPath "USB_$osType.msi"
	Install-ChocolateyInstallPackage "$driversTitle" $installerType $silentArgs $driverName

	# find .msi installer
	$msiName = (Get-ChildItem "$tempDir" -force | ? {$_.Name -like "*.msi"}).Name

	# install basecamp
	if($msiName -ne $null){
		Install-ChocolateyInstallPackage $packageName $installerType $silentArgs (Join-Path $tempDir $msiName)
	}

	# profit
  write-host "$packageTitle uninstalled successfully"

} catch {
  #cry
  throw $_.Exception.Message
}


