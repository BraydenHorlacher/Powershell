[CmdletBinding()]
Param ( )
[string] $OU = read-host -prompt "Please enter the OU (e.g. OU=Left,OU=Users,OU=_DISABLED,DC=internal,DC=rosehill-college,DC=co,DC=nz)"; 
$Confirm = $True #Change this to $False if you don't need to check off each user

$ExceptGroup = "Domain Users"

Import-Module ActiveDirectory

Write-Host Organizational Unit: $OU
Write-Host Confirm: $Confirm

$users = Get-ADUser -SearchBase $OU -Filter {Enabled -eq $false}

foreach ($user in $users) {
    $UserDN = $user.DistinguishedName
    Get-ADGroup -LDAPFilter "(member=$UserDN)" | foreach-object {
        if ($_.name -ne $ExceptGroup) {
            Write-Host Removing $user.SamAccountName from group $_.name
            Remove-ADGroupMember -identity $_.name -Member $UserDN -Confirm:$Confirm
        }
    }
}