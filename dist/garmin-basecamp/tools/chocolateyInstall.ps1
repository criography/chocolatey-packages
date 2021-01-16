$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "garmin-basecamp"
$installerType  = "EXE"
$packageVersion = "4.7.3"
$url            = "https://download.garmin.com/software/BaseCamp_473.exe"
$silentArgs     = "/quiet"
$validExitCodes = @(0)
$checksum       = "f1d925ce0ac870b1cb28586bcd8591e13f40a48c7f42d6cc830b4290f708e86d"
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
