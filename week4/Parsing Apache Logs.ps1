cd $PSScriptRoot

function GetApacheLogs {
    $accesslogtable = @()

    Get-Content C:\xampp\apache\logs\access.log | ForEach-Object {
        $log = ($_ -split " ")
        $ip = $log[0]
        $time = $log[3]+$log[4]
        $method = $log[5].Trim('"')
        $page = $log[6]
        $protocol = $log[7].Trim('"')
        $response = $log[8]
        $responsesize = $log[9]
        $referer = $log[10]
        $useragent = ($log[11..($log.Length-1)] -join ' ').Trim('"')

        $accesslogtable += [PSCustomObject]@{
            "IP" = $ip
            "Time" = $time
            "Method" = $method
            "Page" = $page
            "Protocol" = $protocol
            "Response" = $response
            "Response Size" = $responsesize
            "Referer" = $referer
            "User Agent" = $useragent
        }
    }
    $accesslogtable
}