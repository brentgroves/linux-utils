RESOURCEGROUP=aks-getting-started
az group create -n $RESOURCEGROUP -l centralus

https://learn.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az-group-list
az group list

az group show --name $RESOURCEGROUP