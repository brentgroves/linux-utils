brent.groves@outlook.com
 # create an Azure resource group
 $ az group create --name ghost-blog-resource --location eastus
 # locations: eastus, westeurope, centralus, canadacentral, canadaeast
  # ------
  # create a cluster
 $ az aks create --resource-group ghost-blog-resource --name ghost-blog-cluster --node-count 1 --generate-ssh-keys