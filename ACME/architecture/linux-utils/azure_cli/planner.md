az login 
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "id": "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
    "isDefault": true,
    "managedByTenants": [],
    "name": "sub_mgmain_itservices",
    "state": "Enabled",
    "tenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "user": {
      "name": "bgroves@buschegroup.com",
      "type": "user"
    }
  }
]

export SUBSCRIPTION="f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a"
export RESOURCEGROUP=planner
az group create --name $RESOURCEGROUP --location centralus
# locations: eastus, westeurope, centralus, canadacentral, canadaeast
az group list
az group show --name $RESOURCEGROUP
{
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/planner",
  "location": "centralus",
  "managedBy": null,
  "name": "planner",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}

## Create Service Principal
```
https://learn.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest#az-ad-sp-create-for-rbac
export SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment -n "api://planner" -o json)
https://discuss.hashicorp.com/t/values-of-identifieruris-property-must-use-a-verified-domain-documentation-needs-an-update/37828

echo $SERVICE_PRINCIPAL_JSON
after password reset 
{
  "appId": "dd8b1a59-1e3b-4ad1-9b8a-e276b1c8b77d",
  "displayName": "api://planner",
  "password": "-sG8Q~5CXLDOPNeAt88aCi7r_HUuqlnAAeRjAcEf",
  "tenant": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b"
}
```
# Reset the service principal
https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/invalid-service-principal-profile-credentials-or-client-secret
https://learn.microsoft.com/en-us/cli/azure/ad/sp/credential?view=azure-cli-latest#az-ad-sp-credential-reset
# get service principal id
az ad sp list --filter "displayname eq 'api://planner'" 
"id": "872b193d-ddd7-4fb3-91b5-68366b99dc51"

# export password
export SERVICE_PRINCIPAL_SECRET=$(az ad sp credential reset --id "872b193d-ddd7-4fb3-91b5-68366b99dc51" --query password -o tsv)
-sG8Q~5CXLDOPNeAt88aCi7r_HUuqlnAAeRjAcEf
# have not tested
export SERVICE_PRINCIPAL_SECRET=$(az ad sp credential reset --id "872b193d-ddd7-4fb3-91b5-68366b99dc51" --credential-description "planner password" --query password -o tsv)
-sG8Q~5CXLDOPNeAt88aCi7r_HUuqlnAAeRjAcEf


pass insert --multiline planner/SERVICE_PRINCIPAL_JSON
{
  "appId": "dd8b1a59-1e3b-4ad1-9b8a-e276b1c8b77d",
  "displayName": "api://planner",
  "password": "-sG8Q~5CXLDOPNeAt88aCi7r_HUuqlnAAeRjAcEf",
  "tenant": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b"
}


export SERVICE_PRINCIPAL_JSON=$(pass planner/SERVICE_PRINCIPAL_JSON)
export APP_ID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
