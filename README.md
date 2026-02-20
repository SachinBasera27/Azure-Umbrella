# Azure-Umbrella

This repository serves as a centralized collection of PowerShell scripts and Python Scripts samples designed to interact with Microsoft Azure, primarily for tenant management, administrative automation, and DevOps workflows. It aims to provide practical, reliable, and adaptable examples that support engineers, administrators, and automation specialists working within Azure environments.

Both PowerShell and Python scripts included here are developed and tested with the intention of working seamlessly with Azure services such as Microsoft Entra ID, Azure Resource Manager (ARM), Microsoft Graph API, and Azure Automation. While each script is functional, users may need to update parameters—such as tenant IDs, subscriptions, credentials, or environment-specific settings—to align with their own Azure environments.


**Purpose of This Repository:**

  To provide a curated set of PowerShell and Python scripts for Azure administration and automation.
  To support DevOps, cloud operations, and identity management scenarios across Azure and Microsoft Entra ID.
  To serve as a technical reference for professionals learning or implementing automation using PowerShell modules and Python SDKs.
  To maintain an evolving library of reusable, production-ready scripts that adapt as Azure services and APIs are updated.


**Scope and Usage**

Scripts in this repository may include, but are not limited to:

  Identity & Access Management:
    Managing Microsoft Entra ID (Azure AD) users, groups, roles, and applications
    Interacting with Microsoft Graph API for directory operations and governance
    Automating tasks such as password resets, license assignments, or user lifecycle actions
  
  Azure Resource Management:
    Provisioning and configuring Azure services through ARM, Az PowerShell modules, or Azure SDK for Python
    Automating policies, resource deployments, tagging, and compliance checks

  Automation Support:
    Scripts suitable for Azure Automation Runbooks, GitHub Actions, DevOps pipelines, or scheduled tasks
    Reporting scripts for audit, governance, and environment monitoring
  
  Developer & DevOps Workflows:
    Integrating scripts into CI/CD pipelines
    Streamlining repetitive operational procedures
    Enabling infrastructure automation based on best practices
  
  Each script contains documentation or inline comments to help users understand logic, prerequisites, and customization steps.


**Important Notes for Users**

>> Environment-Specific Configuration: Replace placeholder values (tenant IDs, client IDs, secrets, object IDs, etc.) with those from your Azure tenant.
>> Authentication Requirements: Many scripts require specific RBAC roles or directory permissions. Ensure your account or service principal has the necessary access.
>> API and Module Versions: Azure SDKs, Az PowerShell modules, and Microsoft Graph APIs are updated regularly. While efforts will be made to keep scripts current, users should verify compatibility.
>> Security Best Practices: Avoid hardcoding secrets or credentials inside script files. Use secure alternatives like Azure Key Vault, managed identities, or environment variables.


**Contributions and Updates**

This repository will continue to expand as additional scripts and use cases are developed. Contributions, pull requests, and suggestions are welcome. The long-term goal is to maintain a practical, evolving toolkit for anyone working with Azure automation using PowerShell or Python.
