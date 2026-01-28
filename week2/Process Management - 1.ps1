cd C:\Users\champuser\SYS-320\week2

echo "Every process where ProcessName starts with C"
Get-Process -Name C*

echo "Every process in which the path does not include 'system32'"
Get-Process | Where-Object {$_.Path -and $_.Path -notmatch "system32"} | Select-Object Name, Path

echo "Every stopped service, sorted alphabetically, and stored to a csv file"
$stoppedService = (Get-Service | Where-Object {$_.Status -eq "Stopped"}) | Sort-Object Name
$stoppedService | Export-Csv -Path stoppedservices.csv

echo "If chrome is not running, start it at champlain.edu, if it is, stop it"
$chromeexists = [bool](Get-Process -Name chrome -ErrorAction SilentlyContinue)
if ($chromeexists) {
    Stop-Process -Name "chrome"
} else {
    Start-Process -FilePath chrome.exe -ArgumentList "https://champlain.edu"
}