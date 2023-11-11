https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli

Push your first image to your Azure container registry using the Docker CLI

An Azure container registry stores and manages private container images and other artifacts, similar to the way Docker Hub stores public Docker container images. You can use the Docker command-line interface (Docker CLI) for login, push, pull, and other container image operations on your container registry.

In the following steps, you download a public Nginx image, tag it for your private Azure container registry, push it to your registry, and then pull it from the registry.

# Log in to a registry
There are several ways to authenticate to your private container registry.

az login

export ACRNAME=mobexcr
export AKSCLUSTER=reports-aks
export RESOURCEGROUP=reports
az acr login --name $ACRNAME

You can also log in with docker login. For example, you might have assigned a service principal to your registry for an automation scenario. When you run the following command, interactively provide the service principal appID (username) and password when prompted. For best practices to manage login credentials, see the docker login command reference:

docker login mobexcr.azurecr.io
Both commands return Login Succeeded once completed.

# First, pull a public Nginx image to your local computer. This example pulls an image from Microsoft Container Registry.

docker pull mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine
docker image ls 
REPOSITORY                          TAG             IMAGE ID       CREATED         SIZE
brentgroves/bi-connector            1               7751e0e33e3f   6 days ago      277MB
brentgroves/mongobi                 1               b9d2660d7872   10 days ago     277MB
brentgroves/mongobi                 latest          b9d2660d7872   10 days ago     277MB
mongo                               6.0.3           0850fead9327   3 months ago    700MB
hello-world                         latest          feb5d9fea6a5   17 months ago   13.3kB
mcr.microsoft.com/azure-cli         2.6.0           4a87928e8b40   2 years ago     699MB
mongo                               4.0.17          6182b91a1dbe   2 years ago     418MB
mcr.microsoft.com/oss/nginx/nginx   1.15.5-alpine   aae476eee77d   4 years ago     17.7MB

# Run the container locally
Execute the following docker run command to start a local instance of the Nginx container interactively (-it) on port 8080. The --rm argument specifies that the container should be removed when you stop it.

docker run -it --rm -p 8080:80 mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine

Because you started the container interactively with -it, you can see the Nginx server's output on the command line after navigating to it in your browser.

To stop and remove the container, press Control+C.

# Create an alias of the image
Use docker tag to create an alias of the image with the fully qualified path to your registry. This example specifies the samples namespace to avoid clutter in the root of the registry.

docker tag mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine mobexcr.azurecr.io/samples/nginx

# Push the image to your registry
Now that you've tagged the image with the fully qualified path to your private registry, you can push it to the registry with docker push:

docker push mobexcr.azurecr.io/samples/nginx

# Pull the image from your registry
Use the docker pull command to pull the image from your registry:

docker pull mobexcr.azurecr.io/samples/nginx

# Start the Nginx container
Use the docker run command to run the image you've pulled from your registry:

docker run -it --rm -p 8080:80 mobexcr.azurecr.io/samples/nginx

# Remove the image (optional)
If you no longer need the Nginx image, you can delete it locally with the docker rmi command.

docker rmi myregistry.azurecr.io/samples/nginx

To remove images from your Azure container registry, you can use the Azure CLI command az acr repository delete. For example, the following command deletes the manifest referenced by the samples/nginx:latest tag, any unique layer data, and all other tags referencing the manifest.

az acr repository delete --name myregistry --image samples/nginx:latest


