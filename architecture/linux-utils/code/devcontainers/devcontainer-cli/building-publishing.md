https://middleware.io/blog/docker-cleanup/
REM docker  system prune
docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq) 
docker rmi $(docker images -q) -f
docker volume ls  
docker volume prune --all
docker volume rm vol_name vol_name2  
docker network ls
# remove networks created more that 5 minutes ago
docker network prune --force --filter until=5m
Note that system networks such as bridge, host, and none will never be pruned:
docker network prune 
docker network rm [networkID] 
https://docs.docker.com/engine/reference/commandline/builder_prune/
docker builder prune --all

# simple build
devcontainer build --workspace-folder .

https://github.com/devcontainers/cli/tree/main/example-usage#building-an-image-from-devcontainerjson
Building an image from devcontainer.json
You can use the example by opening a terminal and typing the following:

image-build/build-image.sh
The resulting image name defaults to devcontainer-cli-test-image, but you can change it with the first argument, and configure it to push to a registry by setting the second argument to true. The third argument allows you to build for multiple architectures.

image-build/build-image.sh ghcr.io/my-org/my-image-name-here true "linux/amd64 linux/arm64"
Ultimately, this script just calls the devcontainer build command to do all the work. Once built, you can refer to the specified image name directly in a devcontainer.json file using the image property.


https://github.com/devcontainers/cli
Pre-building
The devcontainer build command allows you to quickly build a dev container image following the same steps as used by the Dev Containers extension or GitHub Codespaces. This is particularly useful when you want to pre-build a dev container image using a CI or DevOps product like GitHub Actions.

build accepts a path to the folder containing a .devcontainer folder or .devcontainer.json file. For example, devcontainer build --workspace-folder <my_repo> will build the container image for my_repo.

Example of building and publishing an image
For example, you may want to pre-build a number of images that you then reuse across multiple projects or repositories. To do so, follow these steps:

Create a source code repository.

Create dev container configuration for each image you want to pre-build, customizing as you wish (including dev container Features). For example, consider this devcontainer.json file:

{
  "build": {
    "dockerfile": "Dockerfile"
  },
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:1": {
      "version": "latest"
    }
  }
}
Use the devcontainer build command to build the image and push it to your image registry. See documentation for your image registry (such as Azure Container Registry, GitHub Container Registry, or Docker Hub) for information on image naming and additional steps like authentication.

devcontainer build --workspace-folder <my_repo> --push true --image-name <my_image_name>:<optional_image_version>
devcontainer build --workspace-folder . --push true --image-name brentgroves/test-rust

devcontainer build --image-name $image_name --platform "$platforms" --push $push_flag --workspace-folder ../workspace
devcontainer build --image-name brentgroves/test-rust --push true --workspace-folder .

