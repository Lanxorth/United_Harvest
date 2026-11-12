
param(
    [string]$Configuration = "Development",
    [string]$Platform = "Win64",
    [string]$Target = "MyGame"
)

$ErrorActionPreference = "Stop"

if (-not $env:UE_ROOT) {
    throw "UE_ROOT environment variable is missing."
}

$Project = (Resolve-Path "$PSScriptRoot/../MyGame.uproject").Path

$BuildScript = Join-Path $env:UE_ROOT `
    "Engine/Build/BatchFiles/Build.bat"

if (-not (Test-Path $BuildScript)) {
    throw "Build.bat not found: $BuildScript"
}

& $BuildScript `
    "$Target" `
    "$Platform" `
    "$Configuration" `
    "-Project=$Project" `
    "-WaitMutex" `
    "-NoHotReloadFromIDE"

$BuildExitCode = $LASTEXITCODE

if ($BuildExitCode -ne 0) {
    throw "UE5 build failed with exit code $BuildExitCode"
}

Write-Host "UE5 build succeeded."
