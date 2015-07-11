$packageName    = "{{PackageName}}"
$installerType  = "EXE"
$url            = "{{DownloadUrl}}"
$silentArgs     = '/S /NCRC'


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"