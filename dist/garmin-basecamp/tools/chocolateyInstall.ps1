$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "garmin-basecamp"
$installerType  = "EXE"
$packageVersion = "4.7.5"
$url            = "https://download.garmin.com/software/BaseCamp_475.exe"
$silentArgs     = "/quiet"
$validExitCodes = @(0)
$checksum       = "12c753fc067acb51b4a28cb01946edfb6a2545e8865fa2a346689526aeba30ca"
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
