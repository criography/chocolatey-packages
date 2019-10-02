$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "garmin-basecamp"
$installerType  = "EXE"
$packageVersion = "4.7.0"
$url            = "http://download.garmin.com/software/BaseCamp_470.exe"
$silentArgs     = "/quiet"
$validExitCodes = @(0)
$checksum       = "257a272dee017ead646fc27ad297be2ee74c97880b80a1c279a3a95b5c57474b"
$checksumType   = "sha256"


# Install the package
Install-ChocolateyPackage `
  -PackageName $packageName `
  -FileType $installerType `
  -Url $url `
  -SilentArgs $silentArgs `
  -ValidExitCodes $validExitCodes `
  -Checksum $checksum `
  -ChecksumType $checksumType `
