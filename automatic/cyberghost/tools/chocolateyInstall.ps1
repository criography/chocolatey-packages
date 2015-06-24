$packageName    = "cyberghost"
$installerType  = "EXE"
$url            = "{{DownloadUrl}}"
$silentArgs     = '/VERYSILENT /NORESTART'


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"