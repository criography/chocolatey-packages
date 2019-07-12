$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "figma"
$installerType  = "EXE"
$packageVersion = "73.0.7"
$url            = "https://www.figma.com/download/desktop/win"
$silentArgs     = "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT"
$validExitCodes = @(0)
$checksum       = "02876da55d2a9b5d2f7d82170e6dae622f13a62d50fb682c39c400d31366779f"
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
