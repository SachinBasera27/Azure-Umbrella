import msal
import requests
import json

from azure.identity import AzureCliCredential
from azure.keyvault.secrets import SecretClient

# ─────────────────────────────────────────────
# STEP 1: User authenticates via Azure CLI
# User must have run: az login --tenant {Tenant ID}
# ─────────────────────────────────────────────
print("Retrieving secret from Key Vault using your Azure CLI session...")

kv_credential = AzureCliCredential(
    tenant_id="Tenant ID"
)

kv_client = SecretClient(
    vault_url="https://python-code-cap.vault.azure.net",
    credential=kv_credential
)

client_secret = kv_client.get_secret("cap-token-secret").value
print("Secret retrieved successfully!")



tenant_id = "Tenant ID"
client_id = "Client ID"
authority_url = f"https://login.microsoftonline.com/{tenant_id}"
scope = ["https://graph.microsoft.com/.default"]


login = msal.ConfidentialClientApplication(
    client_id,
    client_credential = client_secret,
    authority = authority_url,
)


token_response = login.acquire_token_for_client(scopes=scope)
access_token = token_response.get("access_token")
headers = {
    "Authorization": f"Bearer {access_token}"
}


print("What would you like to do?") 
print("1. List")
print("2. Create")
print("3. Get")
print("4. Update")
print("5. Delete")
print("6. Exit Program")


def CAP():
    option = input("Enter your response: ")
    if option == "1":
        list_cap()
        CAP()
    elif option == "2":
        create_cap()
        CAP()
    elif option == "3":
        get_cap()
        CAP()
    elif option == "4":
        update_cap()
        CAP()
    elif option == "5":
        del_cap()
        CAP()
    elif option == "6":
        print("Exiting Code!!!!")
    else: 
        print("Invalid Selection!!!!")


def list_cap():
    url="https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies"
    print("Listing all the CAPs")
    
    data = requests.get(url, headers=headers)
    response = data.json()
    print("@odata.context: ", response.get("@odata.context"))
    print("List of Policies")

    for search in response.get("value", []):
        print("ID: ", search.get("id"))
        print("Name: ", search.get("displayName"))
        print("----------------")


def create_cap():
    policy_data = input("Enter the CAP data in JSON format: ")
    policy_data = json.loads(policy_data)
    url=("https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies")
    data = requests.post(url, headers=headers, json=policy_data)
    status_code=data.status_code
    print(f"CAP created successfully! {status_code}")


def get_cap():
    id = input("Enter the CAP id: ")
    url=(f"https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies/{id}")
    print(f"Getting the policy with id: {id}")
    response = requests.get(url, headers=headers)
    data =  response.json()
    print(json.dumps(data, indent=4))

def update_cap():
    id = input("Enter the CAP id: ")
    url=(f"https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies/{id}")
    print(f"Updating the policy with id: {id}")
    policy_data = input("Enter the updated CAP data in JSON format: ")
    policy_data = json.loads(policy_data)
    response = requests.patch(url, headers=headers, json=policy_data)
    data =  response.json()
    status_code=response.status_code
    print(f"CAP updated successfully! {status_code}")
    print(json.dumps(data, indent=4))

def del_cap():
    id = input("Enter the CAP id: ")
    url= f"https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies/{id}"
    print(f"Deleting the policy with id: {id}")
    response = requests.delete(url, headers=headers)
    status_code=response.status_code
    print(f"CAP deleted successfully! {status_code}")


CAP()
