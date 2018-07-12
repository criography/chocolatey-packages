. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\ImportCertificate.ps1')

$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "cyberghost"
$windowTitle    = "CyberGhost"
$installerType  = "EXE"
$packageVersion = "{{version}}"
$url            = "{{downloadUrl}}"
$validExitCodes = @(0)
$checksum       = "{{checksum}}"
$checksumType   = "{{checksumType}}"
$certPath       = (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'openvpn-technologies-inc.cer')


# Preinstal openvpn certificate
Import-Certificate `
    -CertFile       "$certPath" `
    -StoreNames     trustedpublisher `
    -LocalMachine



# Set up AHK script
$ahkExe        = 'AutoHotKey'
$ahkFile       = Join-Path `
    -Path $env:TEMP `
    -ChildPath "$(Get-Random).ahk"
$ahkSourceFile = Join-Path `
    -Path "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" `
    -ChildPath "install.ahk"
Copy-Item -Path $ahkSourceFile -Destination $ahkFile


# Init AHK
Write-Verbose "Running AutoHotkey install script $ahkFile"
$ahkProc = Start-Process -FilePath $ahkExe -ArgumentList $ahkFile -PassThru
$ahkId   = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"


# Install the package
Install-ChocolateyPackage `
  -PackageName $packageName `
  -FileType $installerType `
  -Url $url `
  -ValidExitCodes $validExitCodes `
  -Checksum $checksum `
  -ChecksumType $checksumType `


# Clean up AHK after instalation compete
Remove-Item -Path $ahkFile -Force -ErrorAction SilentlyContinue
