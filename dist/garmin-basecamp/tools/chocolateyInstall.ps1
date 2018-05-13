$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "garmin-basecamp"
$installerType  = "msi"
$packageVersion = "4.6.2"
$url            = "http://download.garmin.com/software/BaseCamp_462.exe"
$silentArgs     = "/quiet"
$checksum       = "005eb0c5788397147ca962163b23c163f4460d14711f73fd22ea08eef75e2e6f"
$checksumType   = "sha256"
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
