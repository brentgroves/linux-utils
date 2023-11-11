
https://www.youtube.com/watch?v=eyvLwK5C2dw
docker-development-youtube-series
# create command for linux-utils/aks/reports-aks/reports-outlook-aks.md
az login 

{
  "environmentName": "AzureCloud",
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
az group list --query "[?location=='centralus']"

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
  },

  {
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/MC_reports_reports-aks_centralus",
    "location": "centralus",
    "managedBy": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourcegroups/reports/providers/Microsoft.ContainerService/managedClusters/reports-aks",
    "name": "MC_reports_reports-aks_centralus",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": {
      "aks-managed-cluster-name": "reports-aks",
      "aks-managed-cluster-rg": "reports"
    },
    "type": "Microsoft.Resources/resourceGroups"
  }
]




export RESOURCEGROUP=reports

az aks create -n reports-aks \
--resource-group $RESOURCEGROUP \
--location centralus \
--kubernetes-version 1.25.5 \
--load-balancer-sku standard \
--nodepool-name default \
--node-count 3 \
--node-vm-size Standard_[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "07476fd3-6a57-4e3f-80ab-a1be2af5d10a",
    "id": "c9170272-6419-45d7-a3d5-9526a65e8e91",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure subscription 1",
    "state": "Enabled",
    "tenantId": "07476fd3-6a57-4e3f-80ab-a1be2af5d10a",
    "user": {
      "name": "brent.groves@outlook.com",
      "type": "user"
    }
  }
]
E4s_v3  \
--node-osdisk-size 250 \
--ssh-key-value ./id_rsa.pub \
--network-plugin kubenet \
--service-principal $SERVICE_PRINCIPAL \
--client-secret "$SERVICE_PRINCIPAL_SECRET" \
--output none

# Create example apps

```
cd ../..

kubectl create ns example-app

# lets create some resources.
kubectl apply -n example-app -f secrets/secret.yaml
kubectl apply -n example-app -f configmaps/configmap.yaml
kubectl apply -n example-app -f deployments/deployment.yaml

# remember to change the `type: LoadBalancer`
kubectl apply -n example-app -f services/service.yaml

```

## Clean up 
will delete everything in the resource group and and microsoft management resource group also
```
export RESOURCEGROUP=reports

az resource list --resource-group $RESOURCEGROUP --output table
Name         ResourceGroup    Location    Type                                        Status
-----------  ---------------  ----------  ------------------------------------------  --------
mobexcr      reports          centralus   Microsoft.ContainerRegistry/registries
reports-aks  reports          centralus   Microsoft.ContainerService/managedClusters

az group delete -n $RESOURCEGROUP


how to delete the service_principal?
az ad sp list --filter "displayname eq 'api://reports'"
az ad sp list --filter "displayname eq 'api://aks-getting-started-sp'"

SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment -n "api://aks-getting-started-sp" -o json)
https://discuss.hashicorp.com/t/values-of-identifieruris-property-must-use-a-verified-domain-documentation-needs-an-update/37828
echo $SERVICE_PRINCIPAL_JSON
{ "appId": "d91be8b2-5d43-4f50-8dc1-4049a108e1a6", "displayName": "aks-getting-started-sp", "name": "api://aks-getting-started-sp", "password": "PhcC\"V\"'Mc/J{86'>jwkZ{sIo6+d~v{I", "tenant": "07476fd3-6a57-4e3f-80ab-a1be2af5d10a" }


#Keep the `appId` and `password` for later use!

SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
echo $SERVICE_PRINCIPAL
d91be8b2-5d43-4f50-8dc1-4049a108e1a6

SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')
echo $SUBSCRIPTION
#grant contributor role over the resource group to our service principal


az ad sp delete --id $SERVICE_PRINCIPAL
``` 