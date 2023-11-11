https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

https://learn.microsoft.com/en-us/cli/azure/
https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

https://craigforrester.com/posts/azure-cli-basics-listing-resources/

If you just want to see a list of commands covered in this post:
az login
az account list
az group list
az network vnet list
az network vnet subnet list -g $resource_group --vnet-name $vnet
az network nsg list -g $resource_group
az network nsg rule list -g $resource_group --nsg-name $nsg
az network nic list
az network nic ip-config list -g $resource_group --nic-name $nic
az network public-ip list -g $resource_group
az vm list -g $resource_group
az vm list -g $resource_group --show-details