$packageName    = "{{PackageName}}"
$packageChecksum= "{{Checksum}}"
$installerType  = "EXE"
$url            = "{{DownloadUrl}}"
$silentArgs     = '/S /NR'


Install-ChocolateyPackage `
    -packageName "$packageName" `
    -installerType "$installerType" `
    -silentArgs "$silentArgs" `
    -url "$url"