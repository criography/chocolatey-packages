. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')

$packageName    = "cyberghost"
$installerType  = "EXE"
$url            = "{{DownloadUrl}}"
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$certPath       = (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'openvpn-technologies-inc.cer')


Import-Certificate -CertFile "$certPath" -StoreNames trustedpublisher -LocalMachine
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"