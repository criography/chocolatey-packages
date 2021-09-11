$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "garmin-basecamp"
$installerType  = "EXE"
$packageVersion = "4.7.4"
$url            = "https://download.garmin.com/software/BaseCamp_474.exe"
$silentArgs     = "/quiet"
$validExitCodes = @(0)
$checksum       = "70a9474959be4f24babe10e71dc1482730674f9a844558be5db1c3de78deb523"
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
