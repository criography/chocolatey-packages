. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\GetMenuStartPath.ps1')


# stop on all errors
$ErrorActionPreference = 'Stop';


$packageTitle   = "{{title}}"
$packageName    = "{{slug}}"
$url            = "{{downloadUrl}}"
$checksum       = "{{checksum}}"
$checksumType   = "{{checksumType}}"
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
