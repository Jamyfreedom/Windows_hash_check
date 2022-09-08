Start-Transcript -Path C:\hashcheck_event.log
Set-ExecutionPolicy unrestricted


$tStampstart = Get-Date -format dd-MM-yyyy-HHmm
$tStampend = Get-Date -format dd-MM-yyyy-HHmm
$sender = "hash checker <soc_hashchecker@gmail.com>"
$recipients = "SOC <soc@gmail.com>", "NOC <noc@gmail.com>"
$ioc = "<IOC Incident Event Title>"

Send-MailMessage -From $sender -To $recipients -Subject "-Start $tStampstart [Window Server]SOC Hashcheck Start $ioc" -Body "$servers1" -SmtpServer <mail-server-name>

$servers = @("server-name",
"server-name",
"server-name",
"server-name",
"server-name",
"server-name",
"server-name")
foreach($server in $servers) {
Write-Host $server
Invoke-Command -FilePath C:\temp\winhashcheckV3.ps1 -ComputerName $server
Write-Host "Hash scan completed for Server" $server
}

Send-MailMessage -From $sender -To $recipients -Subject "-End $tStampend [Window Server]SOC Hashcheck End $ioc" -Body "Window hashcheck End" -SmtpServer <mail-server-name>

Stop-Transcript
