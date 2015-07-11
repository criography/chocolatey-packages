. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageTitle   = "Color Quantizer"
$packageName    = "{{PackageName}}"
$url            = "{{DownloadUrl}}"
$installDir     = Join-Path $(GetBinRoot) "$packageName"
$startMenu      = GetMenuStartPath


# install zip package
Install-ChocolateyZipPackage "$packageName" "$url" $installDir



# add Start Menu shortcut
New-Item "$startMenu\Programs\$packageTitle" `
    -type directory `
    -force

Install-ChocolateyShortcut `
    -shortcutFilePath   "$startMenu\Programs\$packageTitle\$packageTitle.lnk" `
    -targetPath         "$installDir\cq.exe"