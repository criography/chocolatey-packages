. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\helpers.ps1')


try {

    AutoUninstall `
        -programName  'Garmin Express' `
        -skipMsi      1 `
        -trySilent    1

} catch {
    throw $_.Exception
}
