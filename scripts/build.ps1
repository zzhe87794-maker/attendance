. "$PSScriptRoot\env.ps1"
Push-Location (Split-Path $PSScriptRoot -Parent)
try {
    & "$env:ANT_HOME\bin\ant.bat" dist
    if ($LASTEXITCODE -ne 0) { throw 'Ant build failed.' }
} finally { Pop-Location }
