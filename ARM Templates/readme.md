This folder has files related to deployment of resources with ARM Templates.

ARM templates can only be used to deploy resources in Azure as they interact with Azure's resource realm, and as of right now doesn't have the capability to interact with Azure's Entra ID realm.
If the requirement is to manage, deploy, delete both Entra ID resources and Azure Resources then the suggeted way would be to use Terraform template.

