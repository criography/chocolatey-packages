. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageName    = "hdsentinel"
$packageTitle   = "HDSentinel"
$installerType  = "EXE"
$packageVersion = "{{PackageVersion}}"
$url            = "{{DownloadUrl}}"
$silentArgs     = "/sp- /verysilent /norestart"
$validExitCodes = @(0)

#extract filename from source URL 
$filename       = $url.Substring($url.LastIndexOf("/") + 1)

#establish temp folder path
$tempPath       = $env:temp,"chocolatey",$packageName -join "\"

#establish full path to local copy of downloaded zip file
$pathToZip      = ($tempPath,$filename -join "\")




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
  KillAsap $packageTitle

  #profit
  write-host "$packageName installed successfully"

} catch {

  #cry
  throw $_.Exception.Message

}