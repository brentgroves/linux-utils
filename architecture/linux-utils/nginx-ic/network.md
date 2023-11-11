https://www.azurecitadel.com/cli/jmespath/
# create the public ip for the ingress controller to use
export STATIC_IP =$(az network public-ip create --resource-group $NODERESOURCEGROUP --name ingressAKSPublicIP --sku Standard --allocation-method static --query publicIp.ipAddress -o tsv)
verify it worked.
az network public-ip show --resource-group $NODERESOURCEGROUP --name "ingressAKSPublicIP" --query ipAddress -o tsv
  "ipAddress": "23.101.116.170",

az network public-ip show --resource-group $NODERESOURCEGROUP --name "ingressAKSPublicIP" --output json --query "to_array(ipAddress)"

az network public-ip show --resource-group $NODERESOURCEGROUP --name "ingressAKSPublicIP" --output json --query "[ipAddress,id]"

az network public-ip show --resource-group $NODERESOURCEGROUP --name "ingressAKSPublicIP" --output json --query "{IP:ipAddress,ID:id}"
az vm show --resource-group QueryDemo --name TestVM --query "{VMName:name, admin:osProfile.adminUsername, sshKey:osProfile.linuxConfiguration.ssh.publicKeys[0].keyData}"

az vm show --resource-group QueryDemo --name TestVM --query "[name, osProfile.adminUsername, osProfile.linuxConfiguration.ssh.publicKeys[0].keyData]"