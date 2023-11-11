https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli
# Remove the image (optional)
If you no longer need the Nginx image, you can delete it locally with the docker rmi command.

docker rmi mobexcr.azurecr.io/samples/nginx

To remove images from your Azure container registry, you can use the Azure CLI command az acr repository delete. For example, the following command deletes the manifest referenced by the samples/nginx:latest tag, any unique layer data, and all other tags referencing the manifest.

az acr repository delete --name mobexcr --image samples/nginx:latest
