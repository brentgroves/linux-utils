

Authentication and authorization
When authenticating with an Azure container registry, there are two primary scenarios: individual authentication, and service (or "headless") authentication. The following table provides a brief overview of these scenarios, and the recommended method of authentication for each.

az login

export ACRNAME=mobexcr
export AKSCLUSTER=reports-aks
export RESOURCEGROUP=reports
az acr login --name $ACRNAME

You can also log in with docker login. For example, you might have assigned a service principal to your registry for an automation scenario. When you run the following command, interactively provide the service principal appID (username) and password when prompted. For best practices to manage login credentials, see the docker login command reference:

docker login mobexcr.azurecr.io

https://learn.microsoft.com/en-us/azure/container-registry/container-registry-roles?tabs=azure-cli