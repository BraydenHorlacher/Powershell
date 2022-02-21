Clear-Host
"This script Creates Users in your Active Directory"
""
$Continue = Read-Host -Prompt "Do you want to continue running this script?"
if ($continue -eq "Y" -eq "y") {$null; Clear-Host}
if ($Continue -eq "N" -eq "n") {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/AutomationScripts.ps1'))}

#Imports the Active Directory to allow the script to run
#requires -module ActiveDirectory   

#Ensures blank password
$password = $null

#Creates Users FirstName
$User = Read-Host -Prompt "Please enter the Users First Name (ONLY THEIR FIRST NAME)" ;

#Creates Users LastName
$Lastname = Read-Host -Prompt "Please enter the Users Lastname";

#Creates Users Password
$password = Read-Host -Prompt "Please enter the users password (DEFAULT is Pass2022)";

#The first initial of the users first name (Naming standard)
$Initial = Read-Host -Prompt "Please enter the FIRST Initial of the users first name (e.g. Brayden = B)";

#Specifies the domain the user will login through (e.g. Nessie.local)
$Domain = Read-Host -Prompt "Please enter the domain name you would like to user (e.g. Nessie.local)";

#Specify what OU to place the new user into
$OU = Read-Host -Prompt "Please copy and paste the OU here (e.g. OU=Users,OU=Nessie,DC=Nessie,DC=co,DC=nz)";

#Check for null password and use default
if($password = "") {
 }else {
   $password = "Pass2022"
 }

#Creates the new user using the information supplied above ^^^^^
New-ADUser -Name "$User $Lastname" -GivenName $User -Surname $Lastname -SamAccountName "$User $Lastname" -UserPrincipalName "$Initial$Lastname@$Domain" -AccountPassword (ConvertTo-SecureString -AsPlainText "$Password" -Force) -Enabled $true -ChangePasswordAtLogon $true -path $OU

#Sets user email address in AD
Set-ADUser -Identity "$User $lastname" -EmailAddress "$Initial$Lastname@$Domain"

#Finds the AD User to verify creation
Get-ADUser -identity "$User $Lastname"

Pause