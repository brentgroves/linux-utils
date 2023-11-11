https://www.azurecitadel.com/cli/jmespath/
az vm list --resource-group <resourceGroup> --show-details --output table --query "[*].[name, hardwareProfile.vmSize, storageProfile.osDisk.osType, privateIps, publicIps, fqdns, powerState]"

az vm list --show-details --output table --query "[*].[name, hardwareProfile.vmSize, storageProfile.osDisk.osType, privateIps, publicIps, fqdns, powerState]"

az vm list --show-details --output json --query "[*].{VM:name, Size:hardwareProfile.vmSize, OS:storageProfile.osDisk.osType, IP:privateIps, PIP:publicIps, FQDN:fqdns, State:powerState}"

query='[*].{VM:name, Size:hardwareProfile.vmSize, OS:storageProfile.osDisk.osType, IP:privateIps, PIP:publicIps, FQDN:fqdns, State:powerState}'
az vm list --show-details --output table --query "$query"


az network public-ip show --resource-group $NODERESOURCEGROUP --name "ingressAKSPublicIP" --query ipAddress -o tsv

az network public-ip show --resource-group $NODERESOURCEGROUP --name "ingressAKSPublicIP" --query "[*].{ipAddress}" -o json