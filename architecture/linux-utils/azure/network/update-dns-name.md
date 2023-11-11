https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli
# Public IP address of your ingress controller
kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller

export IP="20.9.106.76"

# Name to associate with public IP address
export DNSLABEL="mobex-ingress"

# Get the resource-id of the public IP
export PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)
echo $PUBLICIPID
/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports_reports-aks_centralus/providers/Microsoft.Network/publicIPAddresses/kubernetes-af89c14e108074281a3bcb9eaf1a8d6b

# Update public IP address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSLABEL

# Display the FQDN
az network public-ip show --ids $PUBLICIPID --query "[dnsSettings.fqdn]" --output tsv