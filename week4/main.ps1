cd $PSScriptRoot

. (Join-Path $PSScriptRoot '.\Parsing Apache Logs.ps1')

GetApacheLogs | Format-Table

GetApacheLogs | Where-Object { $_.Page -ilike "*/page2.html*" -and $_.Referer -ilike "*index.html*"} | Format-Table