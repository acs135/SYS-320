cd $PSScriptRoot

function GetLoginouts {
    param (
        [string]$days
    )
    $loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)
    $loginoutsTable = @()
    for ($i=0; $i -lt $loginouts.Count; $i++){
        $event = ""
        if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
        if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}
        $sid = New-Object -TypeName System.Security.Principal.SecurityIdentifier -ArgumentList ($loginouts[$i].ReplacementStrings[1])
        $user = $sid.Translate([System.Security.Principal.NTAccount]).Value
        $loginoutsTable += [PSCustomObject]@{"Time" = $loginouts[$i].TimeGenerated;
                                               "Id" = $loginouts[$i].InstanceId;
                                            "Event" = $event;
                                             "User" = $user;
                                            }
    }
    $loginoutsTable
}

function GetStartups {
    param (
        [string]$days
    )
    $startups = Get-EventLog System -After (Get-Date).AddDays(-$days) | Where-Object {$_.EventID -eq 6005}
    $startupsTable = @()
    for ($i=0; $i -lt $startups.Count; $i++){
        $event = ""
        if($startups[$i].EventID -eq 6005) {$event="Startup"}
        $user = "System"
        $startupsTable += [PSCustomObject]@{"Time" = $startups[$i].TimeGenerated;
                                                "Id" = $startups[$i].InstanceId;
                                             "Event" = $event;
                                              "User" = $user;
                                              }
    }
    $startupsTable
}

function GetShutdowns {
    param (
        [string]$days
    )
    $shutdowns = Get-EventLog System -After (Get-Date).AddDays(-$days) | Where-Object {$_.EventID -eq 6006}
    $shutdownsTable = @()
    for ($i=0; $i -lt $shutdowns.Count; $i++){
        $event = ""
        if($shutdowns[$i].EventID -eq 6006) {$event="Shutdown"}
        $user = "System"
        $shutdownsTable += [PSCustomObject]@{"Time" = $shutdowns[$i].TimeGenerated;
                                                "Id" = $shutdowns[$i].InstanceId;
                                             "Event" = $event;
                                              "User" = $user;
                                              }
    }
    $shutdownsTable
}