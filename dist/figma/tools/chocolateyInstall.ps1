$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "figma"
$installerType  = "EXE"
$packageVersion = "86.0.5"
$url            = "https://www.figma.com/download/desktop/win"
$silentArgs     = "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT"
$validExitCodes = @(0)
$checksum       = "513f99a75ae42ac5dd676bb722fe3548fe2895d927c22e168fedf2b242c459b8"
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
