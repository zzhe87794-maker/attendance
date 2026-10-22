. "$PSScriptRoot\env.ps1"
$labRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$arguments = @(
    "-Dcatalina.home=$env:CATALINA_HOME",
    "-Dcatalina.base=$env:CATALINA_HOME",
    '-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager',
    "-Djava.util.logging.config.file=$env:CATALINA_HOME\conf\logging.properties",
    '-cp', "$env:CATALINA_HOME\bin\bootstrap.jar;$env:CATALINA_HOME\bin\tomcat-juli.jar",
    'org.apache.catalina.startup.Bootstrap', 'start'
)
$process = Start-Process "$env:JAVA_HOME\bin\java.exe" -ArgumentList $arguments -WindowStyle Hidden -PassThru `
    -RedirectStandardOutput "$labRoot\notes\tomcat-stdout.log" `
    -RedirectStandardError "$labRoot\notes\tomcat-stderr.log"
$process.Id | Set-Content "$labRoot\notes\tomcat.pid"
Write-Output "Tomcat started (PID $($process.Id)). Open http://localhost/attendance/"
