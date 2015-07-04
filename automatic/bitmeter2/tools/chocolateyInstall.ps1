. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageName    = "bitmeter2"
$packageTitle   = "BitMeter2"
$installerType  = "EXE"
$packageVersion = "{{PackageVersion}}"
$url            = "{{DownloadUrl}}"
$silentArgs     = "/S /NCRC"
$validExitCodes = @(0)
$zipFilename    = 'BitMeter2.zip'



#establish temp folder path
$tempPath       = $env:temp,"chocolatey",$packageName -join "\"

#establish full path to local copy of downloaded zip file
$pathToZip      = ($tempPath,$zipFilename -join "\")



try { 

  # download zip package
  Get-ChocolateyWebFile "$packageName" $pathToZip "$url"

  # extract it
  Get-ChocolateyUnzip $pathToZip $tempPath

  # establish path to extracted installer (exe)
  $pathToExe =  Join-Path $tempPath (get-childitem $tempPath | where {$_.extension -eq ".exe"}).Name

  # install package
  Install-ChocolateyInstallPackage "$packageName" "$installerType" "$silentArgs" "$pathToExe" -validExitCodes $validExitCodes

  # the app ssins up a window straight after installation ends. Kill it.
  #KillAsap $packageTitle

  #profit
  write-host "$packageName installed successfully"

} catch {

  #cry
  throw $_.Exception.Message

}