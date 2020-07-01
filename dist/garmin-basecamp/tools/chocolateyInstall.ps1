$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "garmin-basecamp"
$installerType  = "EXE"
$packageVersion = "4.7.2"
$url            = "https://download.garmin.com/software/BaseCamp_472.exe"
$silentArgs     = "/quiet"
$validExitCodes = @(0)
$checksum       = "2d827ef9fa48cbe1e047818dacdb5d59427778917890b0a911f4df9ce15b6c66"
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
