$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "figma"
$installerType  = "EXE"
$packageVersion = "101.6.0"
$url            = "https://www.figma.com/download/desktop/win"
$silentArgs     = "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT"
$validExitCodes = @(0)
$checksum       = "8709495418c0b872873b0316a25f86ee4247c0746201251e104d5e6c3a589f21"
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
