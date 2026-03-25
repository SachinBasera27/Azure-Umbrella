import msal
import requests


tenant_id = "****************"
client_id = "****************"
client_secret = "*************"
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
    print("Create")

def get_cap():
    print("Get")

def update_cap():
    print("Update")


def del_cap():
    id = input("Enter the CAP id: ")
    url= f"https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies/{id}"
    print(f"Deleting the policy with id: {id}")
    response = requests.delete(url, headers=headers)
    print(response)


CAP()
