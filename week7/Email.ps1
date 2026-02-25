function SendAlertEmail($body){
    $from = "aidan.stewart@mymail.champlain.edu"
    $to = "aidan.stewart@mymail.champlain.edu"
    $subject = "Suspicious Activity"

    $password = Get-Content "file.txt" | ConvertTo-SecureString
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $from, $password

    Send-MailMessage -From $from -To $to -Subject $subject -Body $body -SmtpServer "smtp.gmail.com" -Port 587 -UseSsl -Credential $credential

}