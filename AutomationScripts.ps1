#Writes what the script is and does

$admin = Read-Host -prompt "Do you want to run this as an elevated window?(Installations will require admin rights e.g. script 5) Y or N"
if ($admin -eq "Y" -eq "y") {if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {Start-Process PowerShell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";Exit;}}}
if ($admin -eq "N" -eq "n") {$null}

Clear-Host

{
""
"========================================"
"  Run a powershell script from GitHub"
"========================================"
""
"This script is for running my pre made"
"scripts for powershell, from GitHub"
""
"These should NOT be used for any malicious"
"intent, these scripts have the potential"
"to create issues in your AD environment"
"I AM NOT LIABLE FOR ANY ISSUES CREATED BY"
"THESE SCRIPTS! USE AT YOUR OWN RISK!"
}

    #prompts the user for a choice about what script to run
    $Userchoice = Read-Host -Prompt ("Please select an option
    
    1.) Create users with a CSV file.

    2.) Creates a user using inputs from the host.

    3.) Changes User Passwords with a CSV file.

    4.) Removes User groups from disabled users within a specific OU.

    5.) Auto Windows update script (Requires Admin powershell).

    Exit.) Exits the script (Enter Q).

    Choice"
    )

    #Quits the script
    if ($Userchoice -eq 'q' -eq 'Q') {Exit}
    #User Creation via CSV script
    if ($Userchoice -eq 1) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/CSV%20User%20Creation%20Script.ps1'))}
    #User Creation Script
    if ($Userchoice -eq 2) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/User%20Creation%20Script.ps1'))}
    #Password Change via CSV script
    if ($Userchoice -eq 3) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/Password%20Change%20via%20CSV.ps1'))}
    #Remove User Groups Script
    if ($Userchoice -eq 4) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/Remove%20Disabled%20Users%20Groups.ps1'))}
    #Hello world script
    if ($Userchoice -eq 5) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/AutomaticWindowsUpdates'))}

#Takes the script back to the start
$Loop = Read-Host -Prompt ("Would you like to run another script? Y or N")
if ($Loop -eq "Y" -eq "y") {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/AutomationScripts.ps1'))}
if ($Loop -eq "N" -eq "n") {Exit}

pause