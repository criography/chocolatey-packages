$packageName    = "garmin-express"
$installerType  = "EXE"
$url            = "{{DownloadUrl}}"
$silentArgs     = '/s /a /s /v"/qb"'


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"