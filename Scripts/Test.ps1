param(
    [string]$TestFilter = "MyGame"
)


if (-not (Test-Path $EditorCmd)) 

$LogFile = Join-Path $PSScriptRoot "../Saved/Logs/Automation.log"

& $EditorCmd     "$Project"
"-unattended"     "-nop4"
"-NullRHI"     "-log=$LogFile"
"-ExecCmds=Automation RunTests $TestFilter; Quit" `
"-TestExit=Automation Test Queue Empty"

$TestExitCode = $LASTEXITCODE

if ($TestExitCode -ne 0) {
throw "Automation tests failed: $TestExitCode"
}

Write-Host "Automation command completed."