Clear-Host
"This script Creates Users in your Active Directory"
""
$Continue = Read-Host -Prompt "Do you want to continue running this script? (Y or N)"
if ($continue -eq "Y" -eq "y") {$null; Clear-Host}
if ($Continue -eq "N" -eq "n") {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/BraydenHorlacher/Powershell/main/AutomationScripts.ps1'))}

#Imports the Active Directory to allow the script to run
#requires -module ActiveDirectory   

#Ensures blank password
$password = $null

#Creates Users FirstName
$User = Read-Host -Prompt "Please enter the Users First Name (ONLY THEIR FIRST NAME)" ;

#Creates Users LastName
$Lastname = Read-Host -Prompt "Please enter the Users Lastname (ONLY THEIR LAST NAME)";

#Creates Users Password
$password = Read-Host -Prompt "Please enter the users password (DEFAULT is Pass2022)";

#The first initial of the users first name (Naming standard)
$Initial = Read-Host -Prompt "Please enter the FIRST Initial of the users first name (e.g. Brayden = B)";

#Specifies the domain the user will login through (e.g. Nessie.local)
$Domain = Read-Host -Prompt "Please enter the domain name you would like to use for the user (e.g. Nessie.co.nz)";

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
Set-ADUser -Identity "$User $lastname" -EmailAddress "$Initial.$Lastname@$Domain"

#Finds the AD User to verify creation
Get-ADUser -identity "$User $Lastname"

#Used to find if the user is a teacher
$Teacher = Read-Host -Prompt "Is this user a Teacher / Staff Member? (Y or N)"

#Adds AD User to default groups (DOES NOT NEED DOMAIN USERS GROUP!!! This automatically gets added when the account has been created)
if ($Teacher -eq "y" -eq "Y") {
  Add-ADGroupMember -Identity All Teachers -Members "$User $Lastname"
  Add-ADGroupMember -Identity LIC_EnterpriseMobilitySecurityE3 -Members "$User $Lastname"
  Add-ADGroupMember -Identity LIC_GWfEPlusStaff -Members "$User $Lastname"
  Add-ADGroupMember -Identity LIC_MinecraftEducationEditionFaculty -Members "$User $Lastname"
  Add-ADGroupMember -Identity LIC_Office365A3forFaculty -Members "$User $Lastname"
  Add-ADGroupMember -Identity LIC_Windows10EnterpriseA3forFaculty -Members "$User $Lastname"
  Add-ADGroupMember -Identity N4L VPN Clients -Members "$User $Lastname"
  Add-ADGroupMember -Identity Teachers -Members "$User $Lastname"
  Add-ADGroupMember -Identity Staff -Members "$User $Lastname" 
}

#Doesn't add the user to anygroups
if ($Teacher -eq "n" -eq "N") {
  "If the user is not a Teacher they may need more specific groups and will need to be added manually"
}

Pause