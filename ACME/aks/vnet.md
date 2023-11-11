https://medium.com/microsoftazure/aks-different-load-balancing-options-for-a-single-cluster-when-to-use-what-abd2c22c2825

Create the infrastructure
If you haven’t authenticated already, use the az login command to authenticate and login to your Azure account.

Then make sure to point it to the subscription you want to use to deploy your resources:

az account set --subscription <subscription name or id>
Start by creating a new resource group to host our resources:

export RESOURCEGROUP=reports-aks
az group create --name $RESOURCEGROUP --location centralus

az group show --name $RESOURCEGROUP


AKS clusters are deployed inside your vnet. In the command below we will create a vnet and a subnet to host our AKS worker nodes:

# i did not create this vnet
az network vnet create \
    --resource-group $RESOURCEGROUP \
    --name reportsVnet \
    --address-prefixes 192.168.0.0/16 \
    --subnet-name reportsSubnet \
    --subnet-prefix 192.168.1.0/24


# Get the subnet resource ID to use it in the next command:
SUBNET_ID=$(az network vnet subnet show --resource-group $RESOURCEGROUP --vnet-name reportsVnet --name reportsSubnet --query id -o tsv)

# I think the vnet was created for me when I created the aks cluster in the MS "MC_reports-aks_reports-aks_centralus" resource group

az network vnet list
export MSRESOURCEGROUP="MC_reports-aks_reports-aks_centralus"
export VNET="aks-vnet-35600829"
export SUBNET="aks-subnet"
"addressPrefixes": [
  "10.224.0.0/12"
]
"addressPrefix": "10.224.0.0/16"

SUBNET_ID=$(az network vnet subnet show --resource-group $MSRESOURCEGROUP --vnet-name $VNET --name $SUBNET --query id -o tsv)

echo $SUBNET_ID                                              
/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/MC_reports-aks_reports-aks_centralus/providers/Microsoft.Network/virtualNetworks/aks-vnet-35600829/subnets/aks-subnet

Create an AKS cluster:
# I did not do it this way
az aks create \
    --resource-group myAKSResourceGroup \
    --name myAKSCluster \
    --enable-managed-identity \
    --network-plugin azure \
    --vnet-subnet-id $SUBNET_ID \
    --docker-bridge-address 172.17.0.1/16 \
    --service-cidr 10.2.0.0/24 \
    --dns-service-ip 10.2.0.10 \
    --enable-managed-identity \
    --generate-ssh-keys
Notice when we created the cluster, we didn’t enable any add on and we will gradually enable them in the relevant scenarios later in the blog.

When you create an AKS cluster, a second resource group is automatically created to store the AKS resources needed to support your cluster, things like load balancers, public IPs, VMSS backing the node pools will be created here. While we go though the different scenarios later, make sure to check the resource group to see what resources are added on the Azure side.

To get the name of the resource group, use the command below:

az aks show --name $RESOURCEGROUP \
    --resource-group $RESOURCEGROUP \
    --query "nodeResourceGroup"