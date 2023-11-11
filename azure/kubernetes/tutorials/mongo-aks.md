## Azure CLI

```
# Run Azure CLI
cd ~/src/
git clone https://github.com/marcel-dempers/docker-development-youtube-series.git
git clone git@github.com:brentgroves/docker-development-youtube-series.git
pushd /home/brent/src/docker-development-youtube-series

docker run -it --rm -v ${PWD}:/work -w /work --entrypoint /bin/sh mcr.microsoft.com/azure-cli:2.6.0
az --help
az aks --help
cd ./kubernetes/cloud/azure

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
RESOURCEGROUP=mongo-aks
$ az group create --name $RESOURCEGROUP --location centralus
# locations: eastus, westeurope, centralus, canadacentral, canadaeast

az group list

## Create Service Principal

Kubernetes needs a service account to manage our Kubernetes cluster </br>
Lets create one! </br>

```
SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment -n "api://aks-getting-started-sp" -o json)
https://discuss.hashicorp.com/t/values-of-identifieruris-property-must-use-a-verified-domain-documentation-needs-an-update/37828

echo $SERVICE_PRINCIPAL_JSON
{ "appId": "d91be8b2-5d43-4f50-8dc1-4049a108e1a6", "displayName": "aks-getting-started-sp", "name": "api://aks-getting-started-sp", "password": "PhcC\"V\"'Mc/J{86'>jwkZ{sIo6+d~v{I", "tenant": "07476fd3-6a57-4e3f-80ab-a1be2af5d10a" }

#Keep the `appId` and `password` for later use!
https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/invalid-service-principal-profile-credentials-or-client-secret

SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
SERVICE_PRINCIPAL=d91be8b2-5d43-4f50-8dc1-4049a108e1a6
echo $SERVICE_PRINCIPAL

SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')
had to regen this secret because the original secret contained invalid characters
https://learn.microsoft.com/en-us/azure/aks/azure-ad-integration-cli
# Get the service principal secret
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

az role assignment create --assignee $SERVICE_PRINCIPAL \
--scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RESOURCEGROUP" \
--role Contributor

{
  "canDelegate": null,
  "id": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/aks-getting-started/providers/Microsoft.Authorization/roleAssignments/50229936-4eb2-4570-b2c8-407bd19734db",
  "name": "50229936-4eb2-4570-b2c8-407bd19734db",
  "principalId": "2b221519-16b7-478a-9cc5-af0694155b9c",
  "principalType": "ServicePrincipal",
  "resourceGroup": "aks-getting-started",
  "roleDefinitionId": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c",
  "scope": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/aks-getting-started",
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

ssh-keygen -t rsa -b 4096 -N "VeryStrongSecret123!" -C "brent.groves@gmail.com" -q -f  ~/.ssh/id_rsa
cp ~/.ssh/id_rsa* .

az aks create -n aks-getting-started \
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
--client-secret "$serverApplicationSecret" \
--output none


