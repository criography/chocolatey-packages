$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "{{slug}}"
$installerType  = "msi"
$packageVersion = "{{version}}"
$url            = "{{downloadUrl}}"
$silentArgs     = "/quiet"
$checksum       = "{{checksum}}"
$checksumType   = "{{checksumType}}"
$validExitCodes = @(0)



#extract filename from source URL
$filename       = $url.Substring($url.LastIndexOf("/") + 1)

$tmpDir         = Join-Path $env:TEMP "$packageName"
$extractedDir   = Join-Path $tmpDir "extracted-msi"

# full path to local copy of downloaded zip file
$pathToZip      = ($tmpDir,$filename -join "\")



# download zip package
Get-ChocolateyWebFile  `
    -PackageName $packageName `
    -FileFullPath $pathToZip `
    -Url $url `
    -Checksum $checksum `
    -ChecksumType $checksumType



# extract it
Get-ChocolateyUnzip `
  -FileFullPath $pathToZip `
  -Destination $extractedDir



# install package
Install-ChocolateyInstallPackage `
  -PackageName $packageName `
  -FileType $installerType `
  -SilentArgs $silentArgs `
  -ValidExitCodes $validExitCodes `
  -File (Join-Path $extractedDir "BCMain.msi")
