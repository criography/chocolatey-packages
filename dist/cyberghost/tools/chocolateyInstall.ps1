$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "cyberghost"
$windowTitle    = "CyberGhost"
$installerType  = "EXE"
$packageVersion = "6.5.2.31"
$url            = "https://www.cyberghostvpn.com/download/cgsetup_en.exe"
$validExitCodes = @(0)
$checksum       = "ee1bba75f9ec155d41bb096ce5a6cd3bbbb00718186bfa7b56c4ff656349d5db"
$checksumType   = "sha256"


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
