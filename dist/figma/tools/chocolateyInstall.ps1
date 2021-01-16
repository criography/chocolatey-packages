$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "figma"
$installerType  = "EXE"
$packageVersion = "93.4.0"
$url            = "https://www.figma.com/download/desktop/win"
$silentArgs     = "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT"
$validExitCodes = @(0)
$checksum       = "b221cebec98b75e8f8e63a8a5c18351f325caf99acb2cb76f4432dc7acd6afd2"
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
