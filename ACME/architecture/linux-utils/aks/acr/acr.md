https://learn.microsoft.com/en-us/cli/azure/acr?view=azure-cli-latest#az_acr_create

Manage private registries with Azure Container Registries.

Create an ACR
If you don't already have an ACR, create one using the following command.

Copy
# Set this variable to the name of your ACR. The name must be globally unique.

export MYACR=mobexcr

az acr create -n $MYACR -g reports --sku basic

{
  "adminUserEnabled": false,
  "anonymousPullEnabled": false,
  "creationDate": "2023-03-11T00:30:48.843839+00:00",
  "dataEndpointEnabled": false,
  "dataEndpointHostNames": [],
  "encryption": {
    "keyVaultProperties": null,
    "status": "disabled"
  },
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/reports/providers/Microsoft.ContainerRegistry/registries/mobexcr",
  "identity": null,
  "location": "centralus",
  "loginServer": "mobexcr.azurecr.io",
  "name": "mobexcr",
  "networkRuleBypassOptions": "AzureServices",
  "networkRuleSet": null,
  "policies": {
    "azureAdAuthenticationAsArmPolicy": {
      "status": "enabled"
    },
    "exportPolicy": {
      "status": "enabled"
    },
    "quarantinePolicy": {
      "status": "disabled"
    },
    "retentionPolicy": {
      "days": 7,
      "lastUpdatedTime": "2023-03-11T00:30:55.410991+00:00",
      "status": "disabled"
    },
    "softDeletePolicy": {
      "lastUpdatedTime": "2023-03-11T00:30:55.410991+00:00",
      "retentionDays": 7,
      "status": "disabled"
    },
    "trustPolicy": {
      "status": "disabled",
      "type": "Notary"
    }
  },
  "privateEndpointConnections": [],
  "provisioningState": "Succeeded",
  "publicNetworkAccess": "Enabled",
  "resourceGroup": "reports",
  "sku": {
    "name": "Basic",
    "tier": "Basic"
  },
  "status": null,
  "systemData": {
    "createdAt": "2023-03-11T00:30:48.843839+00:00",
    "createdBy": "bgroves@buschegroup.com",
    "createdByType": "User",
    "lastModifiedAt": "2023-03-11T00:30:48.843839+00:00",
    "lastModifiedBy": "bgroves@buschegroup.com",
    "lastModifiedByType": "User"
  },
  "tags": {},
  "type": "Microsoft.ContainerRegistry/registries",
  "zoneRedundancy": "Disabled"
}

  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/reports/providers/Microsoft.ContainerRegistry/registries/mobexcr",
  "name": "mobexcr",
acr-name or acr-resource-id.

Configure ACR integration for existing AKS clusters
Attach an ACR to an AKS cluster
Integrate an existing ACR with an existing AKS cluster using the --attach-acr parameter and valid values for acr-name or acr-resource-id.

az acr show --name $ACRNAME --resource-group $RESOURCEGROUP

export ACRNAME=mobexcr
export AKSCLUSTER=reports-aks
export RESOURCEGROUP=reports-aks
# Attach using acr-name 
az aks update -n $AKSCLUSTER -g $RESOURCEGROUP --attach-acr $ACRNAME

az aks update -n $AKSCLUSTER -g $RESOURCEGROUP --attach-acr $ACRNAME

Waiting for AAD role to propagate[################################    ]  90.0000%Could not create a role assignment for ACR. Are you an Owner on this subscription?

# Attach using acr-resource-id
az aks update -n $AKSCLUSTER -g $RESOURCEGROUP --attach-acr "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/reports/providers/Microsoft.ContainerRegistry/registries/mobexcr"
 Note

The az aks update --attach-acr command uses the permissions of the user running the command to create the ACR role assignment. This role is assigned to the kubelet managed identity. For more information on AKS managed identities, see Summary of managed identities.


# show
pushd ~/src/linux-utils/aks/acr
az acr show --name $ACRNAME --resource-group $RESOURCEGROUP

 Attach using acr-name 

export ACRNAME=mobexcr

export AKSCLUSTER=reports-aks

export RESOURCEGROUP=reports-aks



az aks update -n $AKSCLUSTER -g $RESOURCEGROUP --attach-acr $ACRNAME



Waiting for AAD role to propagate[################################    ]  90.0000%Could not create a role assignment for ACR. Are you an Owner on this subscription?


