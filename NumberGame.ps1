Clear-Host
Write-Host "Welcome to the number game!"
Write-Host "Get ready to play!"
Start-Sleep -S 2
Write-Host "If you would like to quit, type [Exit] into the input prompt!"
Start-Sleep -S 3
Clear-Host

do {
    $Rand = Get-Random -Minimum 1 -Maximum 100
    $String = Read-Host -Prompt "Input a number between 1 and 100!"

    if ($String -eq "Exit") {
        Clear-Host
        Write-Host "Thanks for playing! See you again soon!"
        Start-Sleep 1
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/BraydenHorlacher/Powershell/main/AutomationScripts.ps1'))
    } else {
        $INT = [int]$String
    }

    if ($INT -eq $Rand) {
        Write-Output "CONGRATULATIONS! your answer $INT was correct!"
        Start-Sleep -S 3
        Clear-Host
    } else {
        Write-Output "Sorry your answer of $INT wasn't correct. The number was $Rand, try again!"
        Start-Sleep -S 3
        Clear-Host
    }

} until (
    $String -eq "Exit"
)

