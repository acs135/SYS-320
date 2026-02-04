cd $PSScriptRoot

echo "List only last 5 apache logs"
Get-Content C:\xampp\apache\logs\access.log -Tail 5

echo "Logs that contain 404 or 400"
Get-Content C:\xampp\apache\logs\access.log | Select-String " 404 ", " 400 "

echo "Logs that dont contain 200"
Get-Content C:\xampp\apache\logs\access.log | Select-String -NotMatch " 200 "

echo "From all logs, only get logs that contain 'error', ensure line numbers are listen"
Get-Content C:\xampp\apache\logs\*.log | Select-String "error" | Format-Table LineNumber, Line

echo "Display only IP addresses for 404 records"
$404logs = Get-Content C:\xampp\apache\logs\access.log | Select-String " 404 "
Write-Output $404logs.ForEach({( $_ -split "\s+" )[0]})

echo "Count IPs from last deliverable"
$404logs = Get-Content C:\xampp\apache\logs\access.log | Select-String " 404 "
Write-Output $404logs.ForEach({( $_ -split "\s+" )[0]}) | Group-Object -NoElement