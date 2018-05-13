. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\GetMenuStartPath.ps1')


# stop on all errors
$ErrorActionPreference = 'Stop';


$packageTitle   = "Color Quantizer"
$packageName    = "color-quantizer"
$url            = "http://x128.ho.ua/clicks/clicks.php?uri=cq0744.zip"
$checksum       = "9676fa4c0187779921249ddff6f09eea0bbe66733aa784e628e854ac8d4ad4a2"
$checksumType   = "sha256"
$installDir     = Join-Path $(Get-ToolsLocation) "$packageName"
$startMenu      = GetMenuStartPath


# install zip package
Install-ChocolateyZipPackage `
  -PackageName $packageName `
  -Url $url `
  -UnzipLocation $installDir `
  -Checksum $checksum `
  -ChecksumType $checksumType `


# add Start Menu shortcut
New-Item "$startMenu\Programs\$packageTitle" `
    -type directory `
    -force

Install-ChocolateyShortcut `
    -shortcutFilePath   "$startMenu\Programs\$packageTitle\$packageTitle.lnk" `
    -targetPath         "$installDir\cq.exe"
