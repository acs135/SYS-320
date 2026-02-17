cd $PSScriptRoot

. (Join-Path $PSScriptRoot '.\Scraping Champlain Classes')

$table = gatherClasses
$table = daysTranslator $table

echo "i. list classes where furkan paligu is the instructor"
$table | Where-Object {$_.Instructor -ilike "Furkan Paligu"} | Format-Table

echo "ii. all classes held in free 105 on wednesdays, only displaying class code and times"
$table | Where-Object {$_.Location -ilike "FREE 105" -and $_.Days -ilike "*Wednesday*"} | Select-Object -Property "Time Start", "Time End", "Class Code"

echo "iii. all teachers that teach at least 1 couse in sys, net, sec, for, csi, or dat, sort by name and make it unique"
$table | Where-object {$_.'Class Code' -ilike "SYS*" -or
                       $_.'Class Code' -ilike "NET*" -or
                       $_.'Class Code' -ilike "SEC*" -or
                       $_.'Class Code' -ilike "FOR*" -or
                       $_.'Class Code' -ilike "CSI*" -or
                       $_.'Class Code' -ilike "DAT*"
                       } | Group-Object -Property "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending | Format-Table
