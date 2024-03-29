# Graylog server details
$GraylogServer = "192.168.1.3"
$GraylogPort = "9000"
$GLUsername = "admin"
$GLPassword = "password"
$GraylogSearchQuery = "*"
$GraylogTimeRange = "24h"

# Email details
$EmailFrom = "GraylogChecker@localhost"
$EmailTo = "SecurityOfficer@example.com"
$EmailSubject = "Graylog Log Count Alert"
$SMTPServer = "mail.example.com"
$SMTPPort = "587"
$SMTPUsername = "your_smtp_username"
$SMTPPassword = "your_smtp_password"

# Build the query
$uri = "http://${GraylogServer}:$GraylogPort/api/search/aggregate?query=*&timerange=24h&groups=wtf"

$cred = (New-Object System.Management.Automation.PSCredential($GLUsername, (ConvertTo-SecureString $GLPassword -AsPlainText -Force)))

$headers = @{
    "Content-Type" = "application/json"
    "X-Requested-By" = "cli"
}

# Execute the query
$response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Credential $cred

# Parse the response
$dr = $response.datarows
$logCount = $dr[0][1]
"Log Count = " + $logCount

# Send email alert if log count is 0
if ($logCount -eq 0) {
    $EmailBody = "No log entries found in Graylog for the last 24 hours."
    $EmailBody
    "Sending email alert..."
    Send-MailMessage -From $EmailFrom -To $EmailTo -Subject $EmailSubject -Body $EmailBody -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential (New-Object System.Management.Automation.PSCredential($SMTPUsername, (ConvertTo-SecureString $SMTPPassword -AsPlainText -Force)))
}
