$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "garmin-basecamp"
$installerType  = "EXE"
$packageVersion = "4.7.0"
$url            = "http://download.garmin.com/software/BaseCamp_470.exe"
$silentArgs     = "/quiet"
$validExitCodes = @(0)
$checksum       = "a51931fbdf85e4308b659bdda25c5e39767214bcd531f712703ba291b7509b06"
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
