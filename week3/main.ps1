cd $PSScriptRoot

. (Join-Path $PSScriptRoot '.\Functions and Event Logs.ps1')

clear

$loginoutsTable = GetLoginouts(15)
$loginoutsTable

$startupsTable = GetStartups(25)
$startupsTable

$shutdownsTable = GetShutdowns(25)
$shutdownsTable