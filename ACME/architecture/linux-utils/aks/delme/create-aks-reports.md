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
export RESOURCEGROUP=reports
az group create --name $RESOURCEGROUP --location centralus
# locations: eastus, westeurope, centralus, canadacentral, canadaeast

export SERVICE_PRINCIPAL_JSON=$(pass reports/SERVICE_PRINCIPAL_JSON)
export APP_ID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')

az group create --name $RESOURCEGROUP --location centralus
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

export SERVICE_PRINCIPAL_JSON=$(pass reports/SERVICE_PRINCIPAL_JSON)
export APP_ID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
export PASSWORD=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')

az ad sp list --filter "displayname eq 'api://reports'" 
...
    "appDisplayName": "api://reports",
    "appId": "15cdd566-98bb-4130-8ec5-5c58cffb34bf",
    "appOwnerOrganizationId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "displayName": "api://reports",
    "id": "cc991d02-41dc-422b-84c2-7abc97f304fe",
```
# Reset the service principal
https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/invalid-service-principal-profile-credentials-or-client-secret
https://learn.microsoft.com/en-us/cli/azure/ad/sp/credential?view=azure-cli-latest#az-ad-sp-credential-reset
az ad sp credential reset --id "cc991d02-41dc-422b-84c2-7abc97f304fe"

export SERVICE_PRINCIPAL_SECRET=$(az ad sp credential reset --id "cc991d02-41dc-422b-84c2-7abc97f304fe --query password -o tsv")

# have not tested
export SERVICE_PRINCIPAL_SECRET=$(az ad sp credential reset --id "cc991d02-41dc-422b-84c2-7abc97f304fe --credential-description "reports password" --query password -o tsv")

# grant contributor role over the resource group to our service principal
https://learn.microsoft.com/en-us/cli/azure/role/assignment?view=azure-cli-latest#az-role-assignment-create


export SUBSCRIPTION="f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a"
export RESOURCEGROUP=reports

export SERVICE_PRINCIPAL_JSON=$(pass reports/SERVICE_PRINCIPAL_JSON)
export APP_ID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
export PASSWORD=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')


az role assignment create --assignee "$APP_ID" --role "Contributor" --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RESOURCEGROUP"

subscription "id": "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
"name": "sub_mgmain_itservices",
  "user": {
    "name": "bgroves@buschegroup.com",
    "type": "user"
  }

```
## Create our cluster

```
pushd ~/src/linux-utils/aks

#full list of options

az aks create --help
az aks get-versions --location centralus -o table
KubernetesVersion    Upgrades
-------------------  -----------------------
1.25.5               None available
1.25.4               1.25.5
1.24.9               1.25.4, 1.25.5
1.24.6               1.24.9, 1.25.4, 1.25.5
1.23.15              1.24.6, 1.24.9
1.23.12              1.23.15, 1.24.6, 1.24.9

#generate SSH key

ssh-keygen -t rsa -b 4096 -N "VeryStrongSecret123!" -C "your_email@example.com" -q -f  ~/.ssh/id_rsa
cp ~/.ssh/id_rsa* .

az aks create -n reports-aks \
--resource-group $RESOURCEGROUP \
--location centralus \
--kubernetes-version 1.25.5 \
--load-balancer-sku standard \
--nodepool-name default \
--node-count 1 \
--node-vm-size Standard_E4s_v3  \
--node-osdisk-size 250 \
--ssh-key-value ./id_rsa.pub \
--network-plugin kubenet \
--service-principal $SERVICE_PRINCIPAL \
--client-secret "$SERVICE_PRINCIPAL_SECRET" \
--output none

az aks list -o table

## Get a kubeconfig for our cluster

```
# use --admin for admin credentials to give permissions
# use without `--admin` to get no priviledged user.
pushd ~/src/linux-utils/kubectl/contexts
az aks get-credentials -n reports-aks \
--resource-group $RESOURCEGROUP --admin
rm ~/.kube/config
chmod 777 ~/.kube/config
cp ~/.kube/config ./reports-aks-admin.yaml
scc.sh reports-aks-admin.yaml reports-aks-admin
kubectl get nodes

```



