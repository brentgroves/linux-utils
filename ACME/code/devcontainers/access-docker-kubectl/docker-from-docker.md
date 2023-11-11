https://github.com/microsoft/vscode-dev-containers/tree/main/containers/docker-from-docker

Docker from Docker
Summary
Access your host's Docker install from inside a dev container. Installs Docker extension in the container along with needed CLIs.

Metadata	Value
Contributors	The VS Code team
Categories	Other
Definition type	Dockerfile
Works in Codespaces	Yes
Container host OS support	Linux, macOS, Windows
Container OS	Debian (though Ubuntu could be used instead)
Languages, platforms	Any
Note: There is also a Docker Compose variation of this same definition. If you need to mount folders within the dev container into your own containers, you may find Docker in Docker meets your needs better, though with a potential performance penalty.

Dev containers can be useful for all types of applications including those that also deploy into a container based-environment. While you can directly build and run the application inside the dev container you create, you may also want to test it by deploying a built container image into your local Docker Desktop instance without affecting your dev container.

This example illustrates how you can do this by running CLI commands and using the Docker VS Code extension right from inside your dev container. It installs the Docker extension inside the container so you can use its full feature set with your project.

Note: If preferred, you can use the related docker/moby install script in your own existing Dockerfiles instead.

The included .devcontainer/Dockerfile can be altered to work with other Debian/Ubuntu-based container images such as node or python. You'll also need to update remoteUser in .devcontainer/devcontainer.json in cases where a vscode user does not exist in the image you select. For example, to use mcr.microsoft.com/vscode/devcontainers/javascript-node, update the Dockerfile as follows:

FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:14
...and since the user in this container is node, update devcontainer.json as follows:

"remoteUser": "node"

https://github.com/microsoft/vscode-dev-containers/tree/main/containers/docker-from-docker#how-it-works

While recommend just using docker/moby script from the script library as an easy way to get this running in your own existing container, this section will outline the how you can selectively add this functionality to your own Dockerfile in two parts: enabling access to Docker for the root user, and enabling it for a non-root user.

Enabling root user access to Docker in the container
You can adapt your own existing development container Dockerfile to support this scenario when running as root by following these steps:

First, install the Docker CLI in your container. From .devcontainer/Dockerfile:

# Install Docker CE CLI
RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates curl gnupg2 lsb-release \
    && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && echo "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce-cli

# Install Docker Compose
RUN LATEST_COMPOSE_VERSION=$(curl -sSL "https://api.github.com/repos/docker/compose/releases/latest" | grep -o -P '(?<="tag_name": ").+(?=")') \
    && curl -sSL "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose