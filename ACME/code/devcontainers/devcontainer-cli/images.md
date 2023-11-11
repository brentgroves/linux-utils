https://github.com/devcontainers/images
https://hub.docker.com/_/microsoft-vscode-devcontainers
https://hub.docker.com/_/golang
https://github.com/docker-library/repo-info/blob/master/repos/golang/local/1-buster.md
https://docs.docker.com/language/golang/build-images/
https://github.com/tianon/docker-brew-ubuntu-core/blob/1a5cb40f41ac4829d8c301ccd2cf3b7a13687a8b/trusty/Dockerfile
10
https://github.com/docker-library/official-images
https://hub.docker.com/u/library
https://github.com/docker-library/ruby/blob/ed1be47a38a7a24a0aa03c450549afcb592f02a8/3.3-rc/bookworm/Dockerfile
https://github.com/docker-library/golang
You can also regenerate the dockerfile from an image or use the docker history <image name> command to see what is inside. check this: Link to answer

TL;DR So if you have a docker image that was built by a dockerfile, you can recover this information (All except from the original FROM command, which is important, I’ll grant that. But you can often guess it, especially by entering the container and asking “What os are you?”). However, the maker of the image could have manual steps that you’d never know about anyways, plus they COULD just export an image, and re-import it and there would be no intermediate images at that point.

# DockerHub
# Azure

Notes: did not git push to work so had to push the image from docker push.
https://github.com/devcontainers/cli/tree/main/example-usage#building-an-image-from-devcontainerjson
Building an image from devcontainer.json
You can use the example by opening a terminal and typing the following:

image-build/build-image.sh
The resulting image name defaults to devcontainer-cli-test-image, but you can change it with the first argument, and configure it to push to a registry by setting the second argument to true. The third argument allows you to build for multiple architectures.
image-build/build-image.sh brentgroves/test-rust:1 true "linux/amd64"
image-build/build-image.sh ghcr.io/my-org/my-image-name-here true "linux/amd64 linux/arm64"
Ultimately, this script just calls the devcontainer build command to do all the work. Once built, you can refer to the specified image name directly in a devcontainer.json file using the image property.

image-build/build-image.sh brentgroves/test-rust:1 true "linux/amd64"
image-build/build-image.sh brentgroves/test-rust:1 true "linux/amd64"
devcontainer build --image-name brentgroves/test-rust:1 --push true --workspace-folder . 
devcontainer build --image-name $image_name --platform "$platforms" --push $push_flag --workspace-folder ..
