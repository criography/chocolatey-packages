$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "xyplorer"
$installerType  = "EXE"
$packageVersion = "19.80.0100"
$url            = "https://www.xyplorer.com/download/xyplorer_full.zip"
$silentArgs     = "/S"
$validExitCodes = @(0)
$checksum       = "e16d6304f2e3e03062260862c1bbbaed91de7b6a2b938bb27a31ecf55d3f56a4"
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
