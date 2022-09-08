$IMDA = Read-Host -Prompt "What is the IMDA Code? (IOC-2022-34)"
Start-Transcript -Path C:\ioc_date_log\"$IMDA"_compare_result.txt

$User = Read-Host -Prompt "Your Name?"

# hashtype backend not yet build
$hashtype = Read-Host -Prompt "What type of hash to run? (MD5/SHA1/SHA256/ALL)"

$tStampstart = Get-Date -format dd-MM-yyyy-HH:mm
$tStampend = Get-Date -format dd-MM-yyyy-HH:mm

$sender = "SOC hash checker <Sender-email>"
$recipients = "<Receiver-email>"


# Read the malicious IOCs hash file
$files = Get-Content "C:\temp\hashfile.txt"
$i= 0
Write-Host "Author: $User" 
foreach ($file in $files) {
$compare = Select-String -Path "C:\ioc_date_log\Run_process\*" -Pattern "$file"  
Select-String -Path "C:\ioc_date_log\Run_process\*" -Pattern "$file"  # Compare IOCs with all generated localhost's hashes 
  
  if($compare -ne $null){  # If found then increase found + 1 
    $i++
    


  }  

}

if($i -gt 0){ #If entire comparison not found then
  Send-MailMessage -From $sender -To $recipients -Subject "-End $tStampend [Window Server]SOC Hashcheck End $hashtype" -Body "Windows Malicious HASH FOUND. Total $i found. " -SmtpServer mailhost.mgt.tpgtelecom.com.sg
} else {
  Send-MailMessage -From $sender -To $recipients -Subject "-End $tStampend [Window Server]SOC Hashcheck End $hashtype" -Body "Windows NO Malicious HASH FOUND. Total $i found. " -SmtpServer mailhost.mgt.tpgtelecom.com.sg
}
Write-Host "Total malicious found:"$i

Stop-Transcript

