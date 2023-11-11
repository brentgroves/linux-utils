https://github.com/cert-manager/cert-manager
https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli

# Attach using acr-name 
export ACRNAME=mobexcr
export AKSCLUSTER=reports-aks
export RESOURCEGROUP=reports-aks

az aks update -n $AKSCLUSTER -g $RESOURCEGROUP --attach-acr $ACRNAME
