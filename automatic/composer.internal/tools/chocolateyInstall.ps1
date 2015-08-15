$packageName    = '{{PackageName}}'
$installerType  = 'EXE'

$url            = '{{DownloadUrl}}'
$silentArgs     = ''

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"