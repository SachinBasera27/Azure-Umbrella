MSAL needs to be installed locally in the system prior to running the code.
{
  use command (Terminal): python -m pip install msal
}

MSAL is used to acquire token for Microsoft Graph and then use the tokens in client credential flow for calling the Microsoft Graph APIs.

MSAL Document:
https://learn.microsoft.com/en-us/entra/identity-platform/msal-overview

MSAL Authentication flows:
https://docs.azure.cn/en-us/entra/identity-platform/msal-authentication-flows

MSAL Client Credential flow:
https://learn.microsoft.com/en-us/entra/msal/python/advanced/client-credentials
https://msal-python.readthedocs.io/en/latest/

Conditional Access Policy Graph APIs:
https://learn.microsoft.com/en-us/graph/api/resources/conditionalaccesspolicy?view=graph-rest-1.0


Further Documents will be added as I update the code and add functionality
