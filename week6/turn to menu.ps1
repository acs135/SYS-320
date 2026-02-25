. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot "../week4/Parsing Apache Logs.ps1")

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display Last 10 Apache Logs`n"
$Prompt += "2 - Display Last 10 Failed Logins`n"
$Prompt += "3 - Display At Risk Users`n"
$Prompt += "4 - Start Champlain.edu`n"
$Prompt += "5 - Exit`n"

$operation = $true

while ($operation) {
    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if ($choice -eq "5"){
        exit
        $operation = $false
    }

    if ($choice -eq "1") {
        GetApacheLogs | Select-Object -Last 10 | Format-Table
    }

    if ($choice -eq "2") {
        getFailedLogins 365 | Select-Object -Last 10 | Format-Table
    }

    if ($choice -eq "3") {
        getFailedLogins 365 | Group-Object -Property User | Where-Object {$_.Count -gt 10} | Select-Object Name, Count | Format-Table
    }

    if ($choice -eq "4") {
        $chromeexists = [bool](Get-Process -Name chrome -ErrorAction SilentlyContinue)
        if ($chromeexists) {
        Stop-Process -Name "chrome"
        } else {
        Start-Process -FilePath chrome.exe -ArgumentList "https://champlain.edu"
        }
    } else {
        Write-Host "Invalid Input!"
        continue
    }
}