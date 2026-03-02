cd $PSScriptRoot

function getIOCs() {
    $page = Invoke-WebRequest http://10.0.17.6/IOC.html
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    $table = @()

    $trs | ForEach-Object {
        $tds = $_.getElementsByTagName("td")

        $table += [PSCustomObject]@{
            "Pattern" = $tds.item(0).innerText
            "Explanation" = $tds.item(1).innerText
        }
    }

    $table
}

function getLogs() {
    $logs = Get-Content ./access.log

    $table = @()

    $logs | ForEach-Object {
        $splitlog = $_.split(" ")
        $table += [PSCustomObject]@{
            "IP" = $splitlog[0]
            "Time" = $splitlog[3].trim('[') + " " + $splitlog[4].trim(']')
            "Method" = $splitlog[5].trim('"')
            "Page" = $splitlog[6]
            "Protocol" = $splitlog[7].trim('"')
            "Response" = $splitlog[8]
            "Size" = $splitlog[9]
            "User Agent" = $splitlog[11..($splitlog.length -1)].trim('"')
        }
    }

    $table
}

function getIOCLogs () {
    $logs = getLogs
    $iocs = getIOCs

    $patterns = $iocs.Pattern | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | ForEach-Object { [regex]::Escape($_) }

    $regex = $patterns -join "|"
        
    $logs | Where-Object {$_.Page -match $regex}

}

getIOCLogs | Format-Table