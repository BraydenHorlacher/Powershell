#Writes what the script is and does

Clear-Host

{
"
================================================================================
                       Run a powershell script from GitHub
================================================================================

This script is for running my pre made scripts for powershell, from GitHub

These should NOT be used for any malicious intent, these scripts have the potential 
to create issues in your AD environment

I AM NOT LIABLE FOR ANY ISSUES CREATED BY THESE SCRIPTS! USE AT YOUR OWN RISK!
"
}

    #prompts the user for a choice about what script to run
    $Userchoice = Read-Host -Prompt "Please select an option

    1.) Creates users with a CSV file.

    2.) Creates a user using inputs from the host.

    3.) Changes User Passwords with a CSV file.

    4.) Removes groups from disabled users within a specific OU.

    5.) Auto Windows update script (Recommended to download or copy this from my github)

    6.) Folder Creation from CSV file.

    7.) Adds users to a group from a CSV file (WORK IN PROGRESS!)

    8.) Hello World Script (Says Hello to the WORLD!)

    Exit.) Exits the script (Enter Q).
    
    Choice"

    
    #Quits the script
    if ($Userchoice -eq 'q' -eq 'Q') {Exit}
    #If nothing is selected return to the selection prompt
    if ($Userchoice = $Null){$Userchoice}
    #User Creation via CSV script
    if ($Userchoice -eq 1) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/CSV%20User%20Creation%20Script.ps1'))}
    #User Creation Script
    if ($Userchoice -eq 2) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/User%20Creation%20Script.ps1'))}
    #Password Change via CSV script
    if ($Userchoice -eq 3) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/Password%20Change%20via%20CSV.ps1'))}
    #Remove User Groups Script
    if ($Userchoice -eq 4) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/Remove%20Disabled%20Users%20Groups.ps1'))}
    #Auto windows update script
    if ($Userchoice -eq 5) {Start-Process 'https://github.com/Sagaichi/Powershell/blob/main/AutomaticWindowsUpdates'}
    #Creates Folders from a CSV File
    if ($Userchoice -eq 6) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/AutomaticFolderCreation%20-%20csv'))}
    #Adds users in a CSV file to a group
    if ($Userchoice -eq 7) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/'))}
    #Test Script
    if ($Userchoice -eq 8) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/Test?token=GHSAT0AAAAAABRJFR6ADJNJJDJECO33ZPP4YQAIZNA'))}

#Takes the script back to the start
$Loop = Read-Host -Prompt ("Would you like to run another script? (Y or N)")
if ($Loop -eq "Y" -eq "y") {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/AutomationScripts.ps1'))}
if ($Loop -eq "N" -eq "n") {Exit}

pause