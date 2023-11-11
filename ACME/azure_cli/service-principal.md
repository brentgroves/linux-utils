
https://learn.microsoft.com/en-us/cli/azure/
https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest

```
# Run Azure CLI
## Login to Azure

```
#login and follow prompts
```
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

```

```

# create an Azure resource group
export RESOURCEGROUP=reports
echo $RESOURCEGROUP
az group create --name $RESOURCEGROUP --location centralus
# locations: eastus, westeurope, centralus, canadacentral, canadaeast
{
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/reports",
  "location": "centralus",
  "managedBy": null,
  "name": "reports",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}

az group list

az group show --name $RESOURCEGROUP
{
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/reports",
  "location": "centralus",
  "managedBy": null,
  "name": "reports",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}

## Create Service Principal
```
https://learn.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest#az-ad-sp-create-for-rbac
SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment -n "api://reports" -o json)
https://discuss.hashicorp.com/t/values-of-identifieruris-property-must-use-a-verified-domain-documentation-needs-an-update/37828

echo $SERVICE_PRINCIPAL_JSON
{
  "appId": "15cdd566-98bb-4130-8ec5-5c58cffb34bf",
  "displayName": "api://reports",
  "password": "wfE8Q~Zvyg8J15GMrEFuLkbegI9THBP74tkoEbMq",
  "tenant": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b"
}
pass insert --multiline reports/SERVICE_PRINCIPAL_JSON
{
  "appId": "15cdd566-98bb-4130-8ec5-5c58cffb34bf",
  "displayName": "api://reports",
  "password": "La.8Q~ImZ_85ORJQaYU~KmEFX7Un2tnfGvXF1chJ",
  "tenant": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b"
}

#Keep the `appId` and `password` for later use!
https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/invalid-service-principal-profile-credentials-or-client-secret

export SERVICE_PRINCIPAL_JSON=$(pass reports/SERVICE_PRINCIPAL_JSON)
export APP_ID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
export PASSWORD=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')

Outlook:"tenantId":"07476fd3-6a57-4e3f-80ab-a1be2af5d10a",
Mobex:"tenantId":"b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
az ad sp list --filter "displayname eq 'api://reports'" 
...
    "appDisplayName": "api://reports",
    "appId": "15cdd566-98bb-4130-8ec5-5c58cffb34bf",
    "appOwnerOrganizationId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "displayName": "api://reports",
    "id": "cc991d02-41dc-422b-84c2-7abc97f304fe",

az account show 
  "tenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
  "user": {
    "name": "bgroves@buschegroup.com",
    "type": "user"
  }

regen this secret because the original secret may contain an invalid characters
https://learn.microsoft.com/en-us/azure/aks/azure-ad-integration-cli
# Get the service principal secret

# Reset the service principal
https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/invalid-service-principal-profile-credentials-or-client-secret
https://learn.microsoft.com/en-us/cli/azure/ad/sp/credential?view=azure-cli-latest#az-ad-sp-credential-reset
az ad sp credential reset --id "cc991d02-41dc-422b-84c2-7abc97f304fe"

# have not tested
export SERVICE_PRINCIPAL_SECRET=$(az ad sp credential reset --id "cc991d02-41dc-422b-84c2-7abc97f304fe --query password -o tsv")
az ad sp credential reset --id "cc991d02-41dc-422b-84c2-7abc97f304fe" --credential-description "reports password" 

export $SERVICE_PRINCIPAL=$(az ad sp credential reset --name $SERVICE_PRINCIPAL --query password --output tsv)
This command resets the secret, and displays it as output. Then, you can specify the new secret when you try again to create the new cluster.
az ad sp credential reset --name 'api://reports'

export SERVICE_PRINCIPAL_SECRET=$(az ad sp credential reset \
    --name $SERVICE_PRINCIPAL \
    --credential-description "reports password" \
    --query password -o tsv)
echo $SERVICE_PRINCIPAL_SECRET
bouqz~%~1gPW$0L5xEZv~[n];HC0oqvj
SERVICE_PRINCIPAL_SECRET="bouqz~%~1gPW$0L5xEZv~[n];HC0oqvj"
echo $SERVICE_PRINCIPAL_SECRET
```

# grant contributor role over the resource group to our service principal
https://learn.microsoft.com/en-us/cli/azure/role/assignment?view=azure-cli-latest#az-role-assignment-create
subscription "id": "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
"name": "sub_mgmain_itservices",
  "user": {
    "name": "bgroves@buschegroup.com",
    "type": "user"
  }

export $SUBSCRIPTION="f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a"

az role assignment create --assignee $SERVICE_PRINCIPAL \
--scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RESOURCEGROUP" \
--role Contributor

{
  "canDelegate": null,
  "id": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/reports-aks/providers/Microsoft.Authorization/roleAssignments/4640090d-719b-455f-b63e-11bab865ac11",
  "name": "4640090d-719b-455f-b63e-11bab865ac11",
  "principalId": "da29e589-8bc3-45ff-8b8e-f8ab2206a603",
  "principalType": "ServicePrincipal",
  "resourceGroup": "reports-aks",
  "roleDefinitionId": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c",
  "scope": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/reports-aks",
  "type": "Microsoft.Authorization/roleAssignments"
}
```
```
