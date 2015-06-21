$packageName    = "cheat-engine"
$installerType  = "EXE"
$url            = "{{DownloadUrl}}"
$silentArgs     = '/VERYSILENT /NORESTART /COMPONENTS="program,languages,languages\english"'


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"