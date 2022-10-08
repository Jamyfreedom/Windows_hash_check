$servers1 = @("server-name","servername","servername","add-more-if-you-want")
$servers2 = @("server-name","servername","servername","add-more-if-you-want")

$sender = "SOC hash checker <Sender-email>"
$recipients = "Receiver-email-1" , "Receiver-email-2" 


clear

$hostname = hostname

# This is run by Windows cronjob (Task Scheduler), receive feedback by email script status.
Send-MailMessage -From $sender -To $recipients -Subject " [Window Server] Task scheduler works!. " -SmtpServer <Email-server>
hashtypes = @("MD5","SHA1","SHA256")


foreach ($server in $servers1){
  Invoke-Command -ScriptBlock {
  $hashtypes = @("MD5","SHA1","SHA256")
  $hostname = hostname
  Write-Host $hostname
  foreach ($hashtype in $hashtypes) {
  
  Write-Host $hashtype
  
  # Find all the file include hidden within path of C drive and then generate 3 hashtype
  Get-ChildItem -Recurse -Path 'C:\' | Get-FileHash -Algorithm $hashtype 2>$null #| Format-Table  Algorithm, Hash, Path, PSComputerName -AutoSize
  }
  #3 hash type generated and then save in file renamed by server-name
  } -ComputerName $server | Out-String -Stream -Width 230 | Out-File -FilePath C:\ioc_date_log\Run_process\"$server"_hash.txt 

 Send-MailMessage -From $sender -To $recipients -Subject "-End $tStampend [Window Server]SOC Hashcheck End on Process 1. " -SmtpServer <Email-server>
}


clear


# Same process if you have another set of Server. Not to run at once , seperate managed would be great when you have three digit of servers.
foreach ($server in $servers2){
  Invoke-Command -ScriptBlock {
  $hashtypes = @("MD5","SHA1","SHA256")
  $hostname = hostname
  Write-Host $hostname
  foreach ($hashtype in $hashtypes) {
  
  Write-Host $hashtype
  
  
  Get-ChildItem -Recurse -Path 'C:\' | Get-FileHash -Algorithm $hashtype 2>$null | Format-Table Algorithm, Hash, Path, PSComputerName -AutoSize
  }

  } -ComputerName $server  |  Out-String -Stream -Width 230 | Out-File -FilePath C:\ioc_date_log\Run_process\"$server"_hash.txt

 Send-MailMessage -From $sender -To $recipients -Subject "-End $tStampend [Window Server]SOC Hashcheck End on Process 2. " -SmtpServer <Email-server>
}
