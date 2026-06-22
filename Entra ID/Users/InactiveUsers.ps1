Connect-MgGraph -scopes AuditLog.Read.All , Directory.Read.All

$inactiveDate = (Get-Date).AddDays(-90)

$users = Get-MgUser -All:$true -Property Id, DisplayName, SignInActivity, AccountEnabled, JobTitle, CompanyName, Department 

$inactiveUsers = $users | Where-Object { $_.AccountEnabled -eq $true -and $_.SignInActivity.LastSignInDateTime -lt $inactiveDate } | Select-Object DisplayName, JobTitle, CompanyName, Department, @{Name="LastSuccessfulSignInDateTime";Expression={$_.SignInActivity.LastSuccessfulSignInDateTime}}

$inactiveUsers | Export-Csv -Path "C:\InactiveUsers.csv" -NoTypeInformation


#It includes the user's last sign in date as well and exports the same to the CSV file
