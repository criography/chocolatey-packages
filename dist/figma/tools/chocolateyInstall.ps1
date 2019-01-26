$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "figma"
$installerType  = "EXE"
$packageVersion = "68.0.5"
$url            = "https://www.figma.com/download/desktop/win"
$silentArgs     = "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT"
$validExitCodes = @(0)
$checksum       = "0b2abb0cee63798a3982ab86b7d5ea760a90bbfbe741806e60b7bc792cc43280"
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
