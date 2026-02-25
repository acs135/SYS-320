. (Join-Path $PSScriptRoot "Configuration.ps1")
. (Join-Path $PSScriptRoot "Email.ps1")
. (Join-Path $PSScriptRoot "Scheduler.ps1")
. (Join-Path $PSScriptRoot "../week6/Event-Logs.ps1")

$configuration = readConfiguration

$failed = getFailedLogins $configuration.Days | Group-Object -Property User | Where-Object {$_.Count -gt 10} | Select-Object Name, Count

SendAlertEmail ($failed | Format-Table | Out-String)

ChooseTimeToRun ($configuration.ExecutionTime)