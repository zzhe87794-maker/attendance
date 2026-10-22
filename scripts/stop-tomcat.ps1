. "$PSScriptRoot\env.ps1"
& "$env:CATALINA_HOME\bin\catalina.bat" stop
if ($LASTEXITCODE -ne 0) { throw 'Tomcat shutdown failed.' }
