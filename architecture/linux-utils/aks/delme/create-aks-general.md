https://medium.com/microsoftazure/aks-different-load-balancing-options-for-a-single-cluster-when-to-use-what-abd2c22c2825

AKS clusters are deployed inside your vnet. In the command below we will create a vnet and a subnet to host our AKS worker nodes:
az login

az network vnet create \
    --resource-group myAKSResourceGroup \
    --name myAKSVnet \
    --address-prefixes 192.168.0.0/16 \
    --subnet-name myAKSSubnet \
    --subnet-prefix 192.168.1.0/24

Get the subnet resource ID to use it in the next command:

SUBNET_ID=$(az network vnet subnet show --resource-group myAKSResourceGroup --vnet-name myAKSVnet --name myAKSSubnet --query id -o tsv)

Create an AKS cluster:

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

When you create an AKS cluster, a second resource group is automatically created to store the AKS resources needed to support your cluster, things like load balancers, public IPs, VMSS backing the node pools will be created here. While we go though the different scenarios later, make sure to check the resource group to see what resources are added on the Azure side.

To get the name of the resource group, use the command below:

export RESOURCEGROUP=reports-aks

az aks show --name reports-aks \
    --resource-group $RESOURCEGROUP \
    --query "nodeResourceGroup"

export NODERESOURCEGROUP="MC_reports-aks_reports-aks_centralus"


Now, let’s get cluster credentials and configure kubectl to use them:

az aks get-credentials --resource-group $RESOURCEGROUP  --name reports-aks

# Verify you can communicate with the cluster:
kubectl get nodes


