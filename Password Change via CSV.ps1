Clear-Host
"This script bulk changes Users passwords from a .CSV file in your Active Directory"
""
$Continue = Read-Host -Prompt "Do you want to continue running this script?"
if ($continue -eq "Y" -eq "y") {$null; Clear-Host}
if ($Continue -eq "N" -eq "n") {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sagaichi/Powershell/main/AutomationScripts.ps1'))}


#Imports the Active Directory to allow the script to run
#requires -module ActiveDirectory   

# Open file dialog
# Load Windows Forms
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

# Create and show open file dialog
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.InitialDirectory = $StartDir
$dialog.Filter = "CSV (*.csv)| *.csv" 
$dialog.ShowDialog() | Out-Null

# Get file path
$CSVFile = $dialog.FileName

# Import file into variable
# Lets make sure the file path was valid
# If the file path is not valid, then exit the script
if ([System.IO.File]::Exists($CSVFile)) {
    Write-Host "Importing CSV..."
    $Resetpassword = Import-Csv -LiteralPath "$CSVFile"
} else {
    Write-Host "File path specified was not valid"
    Exit
}

$Confirm = read-host -Prompt "Do you want to check off each user? [Y] or [N]"
if ($Confirm -eq "y" -eq "Y") { 
    foreach ($Account in $Resetpassword) {
        $Account.sAMAccountName
        $Account.Password
            Set-ADAccountPassword -Identity $Account.sAMAccountName -NewPassword (ConvertTo-SecureString $Account.Password -AsPlainText -force) -Reset -Confirm:$True
    }
}
 
if ($Confirm -eq "n" -eq "N") {
    foreach ($Account in $Resetpassword) {
        $Account.sAMAccountName
        $Account.Password
            Set-ADAccountPassword -Identity $Account.sAMAccountName -NewPassword (ConvertTo-SecureString $Account.Password -AsPlainText -force) -Reset -Confirm:$False
    }
}