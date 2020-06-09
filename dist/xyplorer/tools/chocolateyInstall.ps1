$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "xyplorer"
$installerType  = "EXE"
$packageVersion = "20.90.0500"
$url            = "https://www.xyplorer.com/download/xyplorer_full.zip"
$silentArgs     = "/S"
$validExitCodes = @(0)
$checksum       = "3ef52e86fcbb7154a4ade82055bf157526b1c73bfdbc42cd4ce98c1233e46e48"
$checksumType   = "sha256"


#extract filename from source URL
$filename       = $url.Substring($url.LastIndexOf("/") + 1)


#establish temp folder path
$tempPath       = $env:temp,$packageName,$packageVersion -join "\"


#establish full path to local copy of downloaded zip file
$pathToZip      = ($tempPath,$filename -join "\")


# download zip package
Get-ChocolateyWebFile  `
    -PackageName $packageName `
    -FileFullPath $pathToZip `
    -Url $url `
    -Checksum $checksum `
    -ChecksumType $checksumType


# extract it
Get-ChocolateyUnzip $pathToZip $tempPath


# establish path to extracted installer (exe)
$pathToExe = Join-Path $tempPath (get-childitem $tempPath | where {$_.extension -eq ".exe"}).Name


# install package
Install-ChocolateyInstallPackage "$packageName" "$installerType" "$silentArgs" "$pathToExe" -validExitCodes $validExitCodes
