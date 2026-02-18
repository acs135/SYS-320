. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List at Risk Users`n"
$Prompt += "10 - Exit`n"

$validChoices = @('1','2','3','4','5','6','7','8','9','10')

$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        if (checkUser $name) {
            Write-Host "User already exists!"
            continue
        }

        if (!(checkPassword $password)) {
            Write-Host "Password does not meet complexity requirements!"
            continue
        }

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        if (!(checkUser $name)) {
            Write-Host "User does not exist!"
            continue
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if (!(checkUser $name)) {
            Write-Host "User does not exist!"
            continue
        }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        if (!(checkUser $name)) {
            Write-Host "User does not exist!"
            continue
        }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        if (!(checkUser $name)) {
            Write-Host "User does not exist!"
            continue
        }

        $timeBack = Read-Host -Prompt "How many days worth of logs do you want?"

        $userLogins = getLogInAndOffs $timeBack

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        if (!(checkUser $name)) {
            Write-Host "User does not exist!"
            continue
        }

        $timeBack = Read-Host -Prompt "How many days worth of logs do you want?"

        $userLogins = getFailedLogins $timeBack

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

    elseif($choice -eq 9) {
        
        $timeBack = Read-Host -Prompt "How many days worth of logs do you want?"

        $userLogins = getFailedLogins $timeBack
           
        $userLogins |  Group-Object -Property User | Where-Object {$_.Count -gt 10} | Select-Object Name, Count | Format-Table

    }


    elseif(!($choice -in $validChoices)) {
        Write-Host "Invalid Input!"
        continue
    }
    
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    

}




