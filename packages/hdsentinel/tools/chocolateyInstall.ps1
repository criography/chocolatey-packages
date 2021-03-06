﻿. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\KillAsap.ps1')

$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "{{slug}}"
$packageTitle   = "HDSentinel"
$installerType  = "EXE"
$packageVersion = "{{version}}"
$url            = "{{downloadUrl}}"
$silentArgs     = "/sp- /verysilent /norestart"
$checksum       = "{{checksum}}"
$checksumType   = "{{checksumType}}"
$validExitCodes = @(0)



#extract filename from source URL
$filename       = $url.Substring($url.LastIndexOf("/") + 1)

#establish temp folder path
$tmpDir         = $env:temp,$packageName -join "\"

#establish full path to local copy of downloaded zip file
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
  -Destination $tmpDir



# establish path to extracted installer (exe)
$pathToExe =  Join-Path $tmpDir (get-childitem $tmpDir | where {$_.extension -eq ".exe"}).Name



# install package
Install-ChocolateyInstallPackage `
  -PackageName $packageName `
  -FileType $installerType `
  -SilentArgs $silentArgs `
  -ValidExitCodes $validExitCodes `
  -File $pathToExe



# the app spins up a window straight after installation ends. Kill it.
KillAsap $packageTitle
