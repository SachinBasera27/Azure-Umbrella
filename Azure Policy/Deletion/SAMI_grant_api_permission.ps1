#MS Graph Module needs to be Installed for this Script, Prefered Module Version (v2.35.1 or above or 2.32 or lower)
#Refrain from using v2.34 if you have known issues with WAM based login. 
#If you have MS Entra Module, please refer to the doc at the end it contains script and direction to acheive the same using Entra Module.

#Connect to Microsoft Graph with required administrative permissions. The signed-in admin must grant consent for these scopes.
Connect-MgGraph -Scopes "Application.ReadWrite.All","AppRoleAssignment.ReadWrite.All"

#Application.ReadWrite.All -> Required to read the service principals (SPs)
#AppRoleAssignment.ReadWrite.All -> Required to assign application permissions (app roles)

#Run this command to check if the permission are visible in your profile after the admin has given consent for them. Need to be run only once to validate the scopes
Get-MgContext

#Retrieve the target SPs, To get the SAMI SPs, Check Identity blade within the Automation Account. 
$sp = Get-MgServicePrincipal -ServicePrincipalId "Service Principal of the SAMI"

#Retrieve the Microsoft Graph Service Principal from the tenant. Microsoft Graph acts as the resource API exposing permissions (App Roles) in this case Mail.Send.
$graphSp = Get-MgServicePrincipal -Filter "displayName eq 'Microsoft Graph'"

#Check the Mail.Send Application Permission (App Role).
#- Value eq "Mail.Send" -> Selects the Mail.Send permission
#- AllowedMemberTypes contains "Application". Ensures this is an Application permission (not Delegated).
$mailSendRole = $graphSp.AppRoles | Where-Object { $_.Value -eq "Mail.Send" -and $_.AllowedMemberTypes -contains "Application" }

#Now asigning the Mail.Send Application Permission to the target Service Principal.
#ServicePrincipalId -> The Service Principal receiving the permission
#PrincipalId -> Same as above (the identity being granted the role)
#ResourceId -> Microsoft Graph Service Principal (resource API)
#AppRoleId -> The Mail.Send Application permission identifier
New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $sp.Id -PrincipalId $sp.Id -ResourceId $graphSp.Id -AppRoleId $mailSendRole.Id

#Check the SPs permission under Enterprise Application within Entra ID, you should now see Mail.send as an application permission and admin consent granted. 
#If not then reach out to the Admin to grant it for the SPs


#The above script has been tested in my Azure Tenant.

#Regarding Permissions read the below Docs:
https://learn.microsoft.com/en-us/powershell/microsoftgraph/how-to-grant-revoke-api-permissions?view=graph-powershell-1.0&pivots=grant-application-permissions
https://learn.microsoft.com/en-us/powershell/entra-powershell/how-to-grant-revoke-api-permissions?view=entra-powershell&pivots=grant-application-permissions
