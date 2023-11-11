## Azure CLI
https://www.youtube.com/watch?v=zj6r_EEhv6s
https://www.youtube.com/watch?v=zj6r_EEhv6s
https://www.youtube.com/watch?v=zj6r_EEhv6s
https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest
https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest

```
# Run Azure CLI
pushd /home/brent/src/linux-utils/aks/reports-aks/ssh


```
brent.groves@outlook.com

## Login to Azure

```
#login and follow prompts
az login 
brent.groves@outlook.com
JesusLives1!
```
# create an Azure resource group
export RESOURCEGROUP=reports-aks
echo $RESOURCEGROUP
$ az group create --name $RESOURCEGROUP --location centralus
# locations: eastus, westeurope, centralus, canadacentral, canadaeast

az group list

az group show --name $RESOURCEGROUP

## Create Service Principal

Kubernetes needs a service account to manage our Kubernetes cluster </br>
Lets create one! </br>

```
https://learn.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest#az-ad-sp-create-for-rbac
SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment -n "api://reports" -o json)
https://discuss.hashicorp.com/t/values-of-identifieruris-property-must-use-a-verified-domain-documentation-needs-an-update/37828

echo $SERVICE_PRINCIPAL_JSON

#Keep the `appId` and `password` for later use!
https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/invalid-service-principal-profile-credentials-or-client-secret

SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
export SERVICE_PRINCIPAL=f1b415e1-cc37-44ae-b6a9-a22f1a31a48b
echo $SERVICE_PRINCIPAL

SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')
export SERVICE_PRINCIPAL_SECRET=~Q&4:0Js*e@bpP)=XNhm,:}Sz9Z2Fi1b
echo $SERVICE_PRINCIPAL_SECRET
~Q&4:0Js*e@bpP)=XNhm,:}Sz9Z2Fi1b

az ad sp list --filter "displayname eq 'api://reports'" 

had to regen this secret because the original secret contained invalid characters
https://learn.microsoft.com/en-us/azure/aks/azure-ad-integration-cli
# Get the service principal secret
https://learn.microsoft.com/en-us/cli/azure/ad/sp/credential?view=azure-cli-latest#az-ad-sp-credential-reset
SERVICE_PRINCIPAL_SECRET=$(az ad sp credential reset \
    --name $SERVICE_PRINCIPAL \
    --credential-description "AKSPassword" \
    --query password -o tsv)
echo $SERVICE_PRINCIPAL_SECRET
bouqz~%~1gPW$0L5xEZv~[n];HC0oqvj
SERVICE_PRINCIPAL_SECRET="bouqz~%~1gPW$0L5xEZv~[n];HC0oqvj"
echo $SERVICE_PRINCIPAL_SECRET
```

# grant contributor role over the resource group to our service principal
https://learn.microsoft.com/en-us/cli/azure/role/assignment?view=azure-cli-latest#az-role-assignment-create

export SUBSCRIPTION="f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a"
export RESOURCEGROUP=reports

export SERVICE_PRINCIPAL_JSON=$(pass reports/SERVICE_PRINCIPAL_JSON)
export APP_ID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
export SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')

export PASSWORD=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')

pushd ~/src/linux-utils/aks/reports-aks

az role assignment create --assignee $APP_ID \
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
## Create our cluster

```
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
pushd /home/brent/src/linux-utils/azure/kubernetes/reports-aks/ssh
ssh-keygen -t rsa -b 4096 -N "VeryStrongSecret123!" -C "brent.groves@gmail.com" -q -f  ~/.ssh/id_rsa
cp ~/.ssh/id_rsa* .

https://learn.microsoft.com/en-us/azure/virtual-machines/ev4-esv4-series#esv4-series

https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-create

export SUBSCRIPTION="f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a"
export RESOURCEGROUP=reports

export SERVICE_PRINCIPAL_JSON=$(pass reports/SERVICE_PRINCIPAL_JSON)
export APP_ID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
export SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')

export PASSWORD=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')
export SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')


az aks create -n reports-aks \
--resource-group $RESOURCEGROUP \
--location centralus \
--kubernetes-version 1.25.5 \
--load-balancer-sku standard \
--nodepool-name default \
--node-count 3 \
--node-vm-size Standard_E4s_v3  \
--node-osdisk-size 250 \
--ssh-key-value ./id_rsa.pub \
--network-plugin kubenet \
--service-principal $SERVICE_PRINCIPAL \
--client-secret "$SERVICE_PRINCIPAL_SECRET" \
--output none

az aks list -o table
Name         Location    ResourceGroup    KubernetesVersion    CurrentKubernetesVersion    ProvisioningState    Fqdn
-----------  ----------  ---------------  -------------------  --------------------------  -------------------  ----------------------------------------------------------
reports-aks  centralus   reports          1.25.5               1.25.5                      Succeeded            reports-ak-reports-f7d0cf-eyr1g0ul.hcp.centralus.azmk8s.io

## Get a kubeconfig for our cluster

```
# use --admin for admin credentials to give permissions
# use without `--admin` to get no priviledged user.
pushd ~/src/linux-utils/kubectl/contexts
rm ~/.kube/config
az aks get-credentials -n reports-aks \
--resource-group $RESOURCEGROUP --admin
chmod 777 ~/.kube/config
cp ~/.kube/config ./reports-aks-mobex.yaml
cp ~/.kube/config ~/.kube/reports-aks-mobex.yaml
scc.sh reports-aks-mobex.yaml reports-aks-admin
kubectl get nodes

```



