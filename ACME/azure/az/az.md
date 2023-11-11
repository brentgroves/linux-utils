


https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest
https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest

Using the parameter -v allows you to bind a local directory. -v or --volume allows you to mount local directories and files to your container. For example, you can start a MySQL database and mount the data directory to store the actual data in your mounted directory.
-w is for the working directory
docker run -it --rm -v ${PWD}:/work -w /work --entrypoint /bin/sh mcr.microsoft.com/azure-cli:2.6.0


https://learn.microsoft.com/en-us/cli/azure/service-page/azure%20resource%20manager?view=azure-cli-latest

https://learn.microsoft.com/en-us/cli/azure/role/assignment?view=azure-cli-latest
az role assignment create --assignee $SERVICE_PRINCIPAL \
--scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RESOURCEGROUP" \
--role Contributor

https://k21academy.com/microsoft-azure/azure-cli-commands/
az group create	Create a new resource group.
az group delete	Delete a resource group.
az group deployment	Manage Azure Resource Manager deployments.


