# Windows_hash_check
Windows hash check one server to many remote Windows servers . (It can be improve as it will run out of RAM usage when exceed the limit eventually)


Overall Process and Work-Flow Explain :

1. Asking Powershell generate hash values (3 type SHA1, SHA256, MD5) on each server and store the outputfile (server-name_hash.txt) in central management server. (Run the powershell by automation Task Scheduler)

2. Another Powershell script (comparehash.ps1), to compare the IOCs malicious hash (hasshfile.txt) with existing local file's hash (server-name_hash.txt) see if match.
It will fire email of the script result Malicious FOUND or Not FOUND.




Generatehash.ps1 ---> server-1_hash.txt 


compare_hash.ps1 ---> IOC-2022-14-Jun_compare_result.txt
(using server-1hash.txt and hashfile.txt)
