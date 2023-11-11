https://learn.microsoft.com/en-us/cli/azure/
https://learn.microsoft.com/en-us/cli/azure/acr?view=azure-cli-latest

https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-acr?tabs=azure-cli

export ACRNAME=mobexcr
export AKSCLUSTER=reports-aks
export RESOURCEGROUP=reports

# create
az acr create -n $ACRNAME -g $RESOURCEGROUP --sku basic
az acr list
Log in to the container registry
Log in to your ACR using the az acr login command and provide the unique name given to the container registry in the previous step.
az acr login --name $ACRNAME

# Attach using acr-name
az aks update -n $ACRNAME -g $RESOURCEGROUP --attach-acr $AKSCLUSTER

# Import an image into your ACR
Run the following command to import an image from Docker Hub into your ACR.

az acr import  -n mobexcr --source docker.io/library/nginx:latest --image nginx:v1

Deploy the sample image from ACR to AKS

# Ensure you have the proper AKS credentials.
export ACRNAME=mobexcr
export AKSCLUSTER=reports-aks
export RESOURCEGROUP=reports

az aks get-credentials -g $RESOURCEGROUP -n $AKSCLUSTER


pushd ~/src/linux-utils/aks/acr/example
kubectl apply -f acr-nginx.yaml

https://learn.microsoft.com/en-us/azure/aks/cluster-container-registry-integration?tabs=azure-cli#create-a-new-aks-cluster-with-acr-integration
Troubleshooting
Run the az aks check-acr command to validate that the registry is accessible from the AKS cluster.
Learn more about ACR monitoring.
Learn more about ACR health.
