# Query user for name of security group, enter switch case for known list
$group = Read-host "Enter security group name, or enter 'help' for known list"
if ($group -eq 'help') {
    write-host "
For GG-LIC-Visio Online Plan 2 (Visio Users), press 1.
For GG-LIC-AudioConf (Teams Audio Conferencing users), press 2.
For GG-Proficiency Testing (STL Proficiency testing), press 3
For CTS St. Louis Management Resources, press 4
For GG-CTS STL Plexxium Reports, press 5
For CTS St. Louis Group, press 6
To exit, press 7
"
    $group = Read-Host "Please input your selection"
    switch ($group) {
        1 {$group = "GG-LIC-Visio Online Plan 2"}
        2 {$group = "GG-LIC-AudioConf"}
        3 {$group = "GG-ProficiencyTesting"}
        4 {$group = "CTS St. Louis Management Resources"}
        5 {$group = "GG-CTS STL Plexxium Reports"}
        6 {$group = "CTS St. Louis Group"}
        7 {Write-Host "Operation terminated by user. Exiting..." -ForegroundColor DarkRed; Start-Sleep -Seconds 2 ; exit}
        }
    }
$list = $null
Write-host ""
Write-host "Working..." -ForegroundColor Yellow
Write-host ""
Write-host ""


#Filter results to name and EIN, place results in variable, and output to shell
$list = (Get-ADGroupMember -Identity "$group" | 
select-object -Property name,samaccountname |
Sort-Object -Property name)
Write-host "$group members:" -foregroundcolor green
out-host -InputObject $list
Write-host ""
Write-host ""


#Prompt for outputting to CSV. Exits if not
$answer = $null
While ($answer -ne "y") {
    Write-Host "Would you like this list output to Excel? (Y/N)" -ForegroundColor Yellow
    $answer = Read-host
    if ($answer -eq "n") {
        write-host "Exiting..."
        Start-Sleep -Seconds 2
        Exit
    }
}
$list | Export-csv -Path "C:\Temp\$group members.csv"
Write-host ""
Write-host "Your document has been placed in C:\temp" -ForegroundColor Yellow
Write-host ""
pause