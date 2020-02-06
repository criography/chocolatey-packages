$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "garmin-basecamp"
$installerType  = "EXE"
$packageVersion = "4.7.1"
$url            = "http://download.garmin.com/software/BaseCamp_471.exe"
$silentArgs     = "/quiet"
$validExitCodes = @(0)
$checksum       = "d7f50a48b81f9678fed236834989c6fe36d9d74549ea1879b69c9f55658d94bb"
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
