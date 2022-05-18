Clear-Host

# What the script does
Write-Output "This script displays all enabled Computers with their descriptions"

$Continue = Read-Host -Prompt "Do you want to continue running this script? [Y/N]"
if ($continue -eq "Y" -eq "y") {$null; Clear-Host}
if ($Continue -eq "N" -eq "n") {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/BraydenHorlacher/Powershell/main/AutomationScripts.ps1'))}

Clear-Host

# Imports AD
#requires -module ActiveDirectory

# Var's
$Confirm = Read-Host -Prompt "Do you want to search for Enabled or Disabled devices? or both? {[E] Enabled | [D] Disabled | [B] Both}"
$Log = Read-Host -Prompt "Would you like to create a log for all the devices? [Y/N]"

# Code
if($Log -eq "Y"){
    if($Confirm -eq "E" -eq "Enabled"){
        Get-ADComputer -Filter {Enabled -eq $True} -Properties Description >> EnabledDevicesLog.txt
        ForEach-Object{
            Write-Output Get-ADComputer -Filter {Enabled -eq $True} -Properties Description >> EnabledDevicesLog.txt
        }
    }
    if($Confirm -eq "D" -eq "Disabled"){
        Get-ADComputer -Filter {Enabled -eq $False} -Properties Description >> DisabledDevicesLog.txt
        ForEach-Object{
            Get-ADComputer -Filter {Enabled -eq $False} -Properties Description >> DisabledDevicesLog.txt
        }
    }
    if($Confirm -eq "B" -eq "Both"){
        Get-ADComputer -Filter * -Properties Description >> DevicesLog.txt
        ForEach-Object{
            Get-ADComputer -Filter * -Properties Description >> DevicesLog.txt
        }
    }
} else{
    if($Confirm -eq "E" -eq "Enabled"){
        Get-ADComputer -Filter {Enabled -eq $True} -Properties Description
    }
    if($Confirm -eq "D" -eq "Disabled"){
        Get-ADComputer -Filter {Enabled -eq $False} -Properties Description
    }
    if($Confirm -eq "B" -eq "Both"){
        Get-ADComputer -Filter * -Properties Description
    }
}

Pause