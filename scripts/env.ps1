$ErrorActionPreference = 'Stop'
$labRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$env:JAVA_HOME = (Get-ChildItem "$labRoot\tools\java11" -Directory | Select-Object -First 1).FullName
$env:ANT_HOME = "$labRoot\tools\ant\apache-ant-1.10.18"
$env:CATALINA_HOME = "$labRoot\tools\tomcat9\apache-tomcat-9.0.123"
$env:Path = "$env:JAVA_HOME\bin;$env:ANT_HOME\bin;$env:Path"
