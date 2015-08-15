$packageName = '{{PackageName}}'
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$silentArgs = '/s'

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"