#Imports the Active Directory to allow the script to run
Import-Module ActiveDirectory

Clear-Host
"This script removes usergroups from enabled or disabled users in your Active Directory"
""
$Continue = Read-Host -Prompt "Do you want to continue running this script? [Y/N]"
if ($continue -eq "Y" -eq "y") {$null; Clear-Host}
if ($Continue -eq "N" -eq "n") {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/BraydenHorlacher/Powershell/main/AutomationScripts.ps1'))}

#Makes sure that the group is null
$ExceptGroup = $null

[string] $OU = read-host -prompt "Please enter the OU (e.g. OU=Left,OU=Users,OU=_DISABLED,DC=internal,DC=rosehill-college,DC=co,DC=nz)"; 
$ExceptGroup = read-host -Prompt "What group do you want to exclude? (Default is 'Domain Users')";

#Check for null password and use default
if($ExceptGroup = "") {
}else {
  $ExceptGroup = "Domain Users"
}

$users = Get-ADUser -SearchBase $OU -Filter {Enabled -eq $False}

$Confirm = Read-Host -Prompt "Do you want to manually check off each group removal for the users in this OU? [Y/N]"
if ($Confirm -eq "y" -eq "Y"){
    foreach ($user in $users) {
        $UserDN = $user.DistinguishedName
        Get-ADGroup -LDAPFilter "(member=$UserDN)" | foreach-object {
            if ($_.name -ne $ExceptGroup) {
                Write-Host Removing $user.SamAccountName from group $_.name > Log.txt
                Remove-ADGroupMember -identity $_.name -Member $UserDN -Confirm:$True
            }
        }
    }
}    
if ($Confirm -eq "n" -eq "N"){
    foreach ($user in $users) {
        $UserDN = $user.DistinguishedName
        Get-ADGroup -LDAPFilter "(member=$UserDN)" | foreach-object {
            if ($_.name -ne $ExceptGroup) {
                Write-Host Removing $user.SamAccountName from group $_.name > Log.txt
                Remove-ADGroupMember -identity $_.name -Member $UserDN -Confirm:$False
            }
        }
    }
}

Write-Host Organizational Unit: $OU
Write-Host Confirm: $Confirm

pause