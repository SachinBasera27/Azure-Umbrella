#This PowerShell Script is for Delegated Flow (User login)
#Graph Module needs to be installed for this script to work in the system
#If you don't want to install the entire Graph Module install Microsoft.Graph.Users and Microsoft.Graph.Authentication submodule of the Graph Module.

Connect-MgGraph -Scopes UserAuthenticationMethod.ReadWrite.All, User.ReadWrite

$params = @{
	passwordProfile = @{
		forceChangePasswordNextSignIn = $true
		password = "New Password"
	}
}

#As a best practice, always set the forceChangePasswordNextSignIn to True

$userId = "Enter User UPN"

Update-MgUser -UserId $userId -BodyParameter $params
