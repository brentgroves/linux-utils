https://craigforrester.com/posts/azure-cli-basics-listing-resources/

Listing Resources
There are many times when you start working on an existing subscription, or revisit it later, and you simply want to get information — what resources exist already, how they’re configured, where they reside, what’s changed since the last time you’ve worked on the subscription, etc. Azure CLI is a good way to run quick interactive queries to get a sense for what already exists or what’s changed on a subscription.

List Resource Groups
The first thing you’ll want to do is start with the base for all the deployed resources: resource groups. To list the resource groups for the selected subscription, use az group list:

export RESOURCEGROUP=reports-aks
export NODERESOURCEGROUP="MC_reports-aks_reports-aks_centralus"
export VNET="aks-vnet-35600829"
export SUBNET="aks-subnet"
export NSG="aks-agentpool-35600829-nsg"
$ az group list  --output table
Name                                  Location        Status
------------------------------------  --------------  ---------
WebApplication120210513153906         northcentralus  Succeeded
myResourceGroup                       centralus       Succeeded
NetworkWatcherRG                      centralus       Succeeded
reports-aks                           centralus       Succeeded
MC_reports-aks_reports-aks_centralus  centralus       Succeeded
SelfHostedIRTest                      eastus          Succeeded

# Listing Public IPs
Public ips are listed at the same subcommand level as NICs are:

az network public-ip list -g $NODERESOURCEGROUP

    "ipAddress": "20.109.234.112",
    "ipConfiguration": {
      "id": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/MC_reports-aks_reports-aks_centralus/providers/Microsoft.Network/loadBalancers/kubernetes/frontendIPConfigurations/2f1fd64a-63ae-4198-9155-b1674c776e3f",
      "resourceGroup": "MC_reports-aks_reports-aks_centralus"

# Listing Virtual Machines
Listing virtual machines only gives us the name, resource group, and location:

az vm list -g $NODERESOURCEGROUP
none

# However, if we add the --show-details switch, we only get marginally more information:
az vm list --resource-group $NODERESOURCEGROUP --show-details




Listing Virtual Networks (VNets)
az network vnet list 

Here is an example show how to list subnets within specific VNets:

$ az network vnet subnet list -g $NODERESOURCEGROUP --vnet-name $VNET

# Get the subnet resource ID to use it in the next command:
SUBNET_ID=$(az network vnet subnet show --resource-group $NODERESOURCEGROUP --vnet-name $VNET --name $SUBNET --query id -o tsv)

# Network Security Groups:

az network nsg list -g $NODERESOURCEGROUP

# NSG Rules, which require you specify the related NSG:

az network nsg rule list -g $NODERESOURCEGROUP --nsg-name $NSG

Listing NICs (Network Interfaces)
az network nic list
