echo "Get IPv4 Address from Ethernet Interface"
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet*" }).IPAddress

echo "Get IPv4 PrefixLength from Ethernet Interface"
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet*" }).PrefixLength

echo "Show what classes there is of Win32 library that start with Net"
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" }

echo "Show what classes there is of Win32 library that start with Net, sort alphabetically"
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object

echo "Get DHCP server IP"
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled = True" | select DHCPServer

echo "Get DHCP server IP and hide the table headers"
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled = True" | select DHCPServer | Format-Table -HideTableHeaders

echo "Get DNS server IPs and display only the first one"
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet*" }).ServerAddresses

echo "List files based on the file name"
cd C:\Users\champuser\SYS-320\week2
$files=(Get-ChildItem)
for ($j=0; $j -lt $files.Count; $j++){

    if ($files[$j].Extension -ilike ".ps1"){
        Write-Host $files[$j].Name
    }
}

echo "Cleaner Way"
Get-ChildItem -Filter *.ps1 | Select-Object -ExpandProperty Name

echo "Create folder if it does not exist"
$folderpath="outfolder"
if (Test-Path -Path $folderpath){
    Write-Host "Folder Already Exist"
}
else{
    New-Item -ItemType Directory -Path $folderpath
}

echo "List all files with .csv extension and save results to out.csv in outfolder directory"
$filePath = Join-Path $folderpath "out.csv"
$files | Where-Object { $_.Extension -eq ".ps1" } | Export-Csv -Path $filePath

echo "Recursively, find every .csv file and change their extensions to .log, then list all .log files recursively"
$files = Get-ChildItem -Filter *.csv -Recurse
$files | Rename-Item -NewName {$_.Name -replace "csv","log"}
Get-ChildItem -Filter *.log -Recurse