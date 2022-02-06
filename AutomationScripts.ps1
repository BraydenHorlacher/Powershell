#Writes what the script is and does
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

    5.) Hello World! (Test file doesn't do alot).

    Exit.) Exits the script (Enter Q).

    Choice: "
    )

    #Quits the script
    if ($Userchoice -eq 'q' -eq 'Q') {Exit}
    #User Creation via CSV script
    if ($Userchoice -eq 1) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Sagaichi/main/CSV%20User%20Creation%20Script.ps1'))}
    #User Creation Script
    if ($Userchoice -eq 2) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Sagaichi/main/User%20Creation%20Script.ps1'))}
    #Password Change via CSV script
    if ($Userchoice -eq 3) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Sagaichi/main/Password%20Change%20via%20CSV.ps1'))}
    #Remove User Groups Script
    if ($Userchoice -eq 4) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Sagaichi/main/Remove%20Disabled%20Users%20Groups.ps1'))}
    #Hello world script
    if ($Userchoice -eq 5) {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Sagaichi/main/Test'))}


#Takes the script back to the start
$Loop = Read-Host -Prompt ("Would you like to run another script? Y or N")
if ($Loop -eq "Y" -eq "y") {./AutomationScripts.ps1}
if ($Loop -eq "N" -eq "n") {Exit}

pause