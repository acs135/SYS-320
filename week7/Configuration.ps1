cd $PSScriptRoot

function readConfiguration() {
    $config = Get-Content configuration.txt
    $numdays = $config[0]
    $scheduletime = $config[1]

    $configtable = [PSCustomObject]@{
        Days = $numdays
        ExecutionTime = $scheduletime
    }
    $configtable
}

function changeConfiguration() {
    $numdays = Read-Host -Prompt "Enter the number of days for which the logs will be obtained: "
    $scheduletime = Read-Host -Prompt "Enter the daily execution time of the script: "

    if ($numdays -as [int] -eq $null) {
        Write-Host "Invalid Input!"
        continue
    }

    if ($scheduletime -as [DateTime] -eq $null) {
        Write-Host "Invalid Input!"
        continue
    }

    Set-Content -Path Configuration.txt -Value $numdays
    Add-Content -Path Configuration.txt -Value $scheduletime
}



function configurationMenu() {
    clear

    $prompt = "`n"
    $prompt += "1 - Show Configuration`n"
    $prompt += "2 - Change Configuration`n"
    $prompt += "3 - Exit`n"

    $operation = $true

    while ($operation) {

        Write-Host $prompt | Out-String
        $choice = Read-Host

        if ($choice -eq "3") {
            $operation = $false
            continue
        } elseif ($choice -eq "1") {
            readConfiguration | Format-Table
        } elseif ($choice -eq "2") {
            changeConfiguration
        } else {
            Write-Host "Invalid Input!"
            continue
        }
    }
}