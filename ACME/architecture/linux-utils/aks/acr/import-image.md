https://learn.microsoft.com/en-us/azure/aks/cluster-container-registry-integration?tabs=azure-cli#create-a-new-aks-cluster-with-acr-integration

Working with ACR & AKS
Import an image into your ACR
Run the following command to import an image from Docker Hub into your ACR.

az acr import  -n mobexcr --source docker.io/library/nginx:latest --image nginx:v1

Deploy the sample image from ACR to AKS
Ensure you have the proper AKS credentials.
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
