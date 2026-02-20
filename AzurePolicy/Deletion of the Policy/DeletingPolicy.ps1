#Connecting to AZ Module with a System Assigned Managed Identity(SAMI) within a Azure Runbook for a Automation Account.
Connect-AzAccount -Identity

#Scope in this instance is set to Tenant Root Group Level(Management Level), change the scope to subscription level depending the scope of the Policy that you want to delete.
#$Scope = "/subscriptions/<subscription-id>" Reference for subscription level scope.
$Scope = "/providers/Microsoft.Management/managementGroups/9afed3ec-3a05-4b0c-92a9-07ac07939ec5"

# The System Assigned Managed Identity(SAMI) needs to be given a "Resource Policy Contributor" level RBAC role in the Management Group(Tenant Root Group in my instance). Read the Document at the last for reference.

#Variable to hold the Policy Names
$PolicyAssignments = @(
    "GovDenyPolicies",
    "GovDeployPolicies",
    "GovAuditPolicies"
)

# Variable to collect output to be sent to the Mail in the later script
$ExecutionLog = @()

foreach ($assignmentName in $PolicyAssignments) {

    $ExecutionLog += "Attempting to delete assignment: $assignmentName"

    $assignment = Get-AzPolicyAssignment -Name $assignmentName -Scope $Scope -ErrorAction SilentlyContinue

    if ($assignment) {
        Remove-AzPolicyAssignment -Name $assignmentName -Scope $Scope
        $ExecutionLog += "Deleted: $assignmentName"
    }
    else {
        $ExecutionLog += "Assignment not found: $assignmentName"
    }
}

# Add execution timestamp for clarity as to when the runbook completed
$ExecutionLog += "`nRunbook completed at: $(Get-Date)"

# Convert log to string
$MailBodyContent = $ExecutionLog -join "`n"

# Get access token using Managed Identity for MS Graph as a Resource
$Token = (Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com").Token

# Define email payload
$MailBody = @{
    message = @{
        subject = "Azure Policy Deletion Runbook Report"
        body = @{
            contentType = "Text"
            content = $MailBodyContent
        }
        toRecipients = @(
            @{
                emailAddress = @{
                    address = "sachin.basera@ltimindtree.com"
                }
            }
        )
    }
    saveToSentItems = "true" #Can be removed if not needed as by default it is set as True
} | ConvertTo-Json -Depth 10 #Depth 5 would also work but as a Standard Industry Practise the depth level should always exceed the nested layers


#SAMI needs to have "Mailbox.send" Permission given to its service principal as a application permission to send the mail on behalf of user. (Refer AssignPermissiontoSAMI.ps1 within the AzurePolicy folder)
# Send email using Microsoft Graph
Invoke-RestMethod `
    -Method POST `
    -Uri "https://graph.microsoft.com/v1.0/users/Automation-notify@domainname/sendMail" `
    -Headers @{Authorization = "Bearer $Token"} `
    -Body $MailBody `
    -ContentType "application/json"

#The above script has been tested in my Azure Tenant.

#Regarding Permissions read the below Docs:
https://learn.microsoft.com/en-us/answers/questions/5556140/granting-an-azure-application-to-send-mail-as-any
https://learn.microsoft.com/en-us/azure/governance/policy/overview
