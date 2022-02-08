Clear-Host
"This script removes usergroups from enabled or disabled users in your Active Directory"
""
$Continue = Read-Host -Prompt "Do you want to continue running this script?"
if ($continue -eq "Y" -eq "y") {$null; Clear-Host}
if ($Continue -eq "N" -eq "n") {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/AutomationScripts.ps1'))}

[string] $OU = read-host -prompt "Please enter the OU (e.g. OU=Left,OU=Users,OU=_DISABLED,DC=internal,DC=rosehill-college,DC=co,DC=nz)"; 
$Confirm = Read-Host -Prompt "Do you want to manually check off each group removal for the users in this OU?"
if ($Confirm -eq "y" -eq "Y"){$true}
if ($Confirm -eq "n" -eq "N"){$False}

$ExceptGroup = read-host -Prompt "What group do you want to exclude? (e.g. Domain Users)"

Import-Module ActiveDirectory

Write-Host Organizational Unit: $OU
Write-Host Confirm: $Confirm


$users = Get-ADUser -SearchBase $OU -Filter {Enabled -eq $False}

foreach ($user in $users) {
    $UserDN = $user.DistinguishedName
    Get-ADGroup -LDAPFilter "(member=$UserDN)" | foreach-object {
        if ($_.name -ne $ExceptGroup) {
            Write-Host Removing $user.SamAccountName from group $_.name
            Remove-ADGroupMember -identity $_.name -Member $UserDN -Confirm:$Confirm
        }
    }
}