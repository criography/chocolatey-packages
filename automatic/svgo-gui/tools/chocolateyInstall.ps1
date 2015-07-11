. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageTitle   = "SVGO GUI"
$packageName    = '{{PackageName}}'
$url            = "{{DownloadUrl}}"
$installDir     = $(GetBinRoot)
$startMenu      = GetMenuStartPath
$appDir         = Join-Path $installDir $packageName

# install zip package
Install-ChocolateyZipPackage `
    -packageName    "$packageName" `
    -url            "$url" `
    -unzipLocation  "$installDir"


# add Start Menu shortcut
New-Item "$startMenu\Programs\$packageTitle" `
    -type directory `
    -force

Install-ChocolateyShortcut `
    -shortcutFilePath   "$startMenu\Programs\$packageTitle\$packageTitle.lnk" `
    -targetPath         "$appDir\svgo-gui.exe"