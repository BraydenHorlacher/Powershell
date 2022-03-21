Clear-Host

"This script bulk Creates Users from a .CSV file in your Active Directory"
""
$Continue = Read-Host -Prompt "Do you want to continue running this script? (Y or N)"
if ($continue -eq "Y" -eq "y") {$null; Clear-Host}
if ($Continue -eq "N" -eq "n") {Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/BraydenHorlacher/Powershell/main/AutomationScripts.ps1'))}

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
    $CSV = Import-Csv -LiteralPath "$CSVFile"
} else {
    Write-Host "File path specified was not valid"
    Exit
}

$Domain = Read-Host -Prompt "Enter the domain name without the @ symbol (This is for the email address)"

# Lets iterate over each line in the CSV file
foreach ($user in $CSV) {

    # Password
    $SecurePassword = ConvertTo-SecureString "Pass2022" -AsPlainText -Force

    # Format their username
    $Username = "$($user.'First Name').$($user.'Last Name')"
    $Username = $Username.Replace(" ", "")

    # Create new user
    New-ADUser -Name "$($user.'First Name') $($user.'Last Name')" `
                -GivenName $user.'First Name' `
                -Surname $user.'Last Name' `
                -UserPrincipalName $Username `
                -SamAccountName $Username `
                -EmailAddress $user'@'$Domain `
                -Description $user.Description `
                -OfficePhone $user.'Office Phone' `
                -Path $user.'Organizational Unit' `
                -ChangePasswordAtLogon $false `
                -AccountPassword $SecurePassword `
                -Enabled $([System.Convert]::ToBoolean($user.Enabled))

    # Write to host that we created a new user
    Write-Host "Created $Username / $($user.'Email Address')"

    # If groups is not null... then iterate over groups (if any were specified) and add user to groups
    if ($User.'Add Groups (csv)' -ne "") {
        $User.'Add Groups (csv)'.Split(",") | ForEach-Object {
            Add-ADGroupMember -Identity $_ -Members "$($user.'First Name').$($user.'Last Name')"
            WriteHost "Added $Username to $_ group" # Log to console
        }
    }

    # Write to host that we created the user
    Write-Host "Created user $Username with groups $($User.'Add Groups (csv)')"
}

Read-Host -Prompt "Script complete... Press enter to exit."