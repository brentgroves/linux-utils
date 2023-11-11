https://github.com/devcontainers
https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack
# From VSCode install extensions
ctrl-p to bring up the search window and then type the following command.
ext install ms-vscode-remote.vscode-remote-extensionpack
https://code.visualstudio.com/docs/devcontainers/tutorial
Dev Containers tutorial
This tutorial walks you through running Visual Studio Code in a Docker container using the Dev Containers extension. You need no prior knowledge of Docker to complete this tutorial.

Running VS Code inside a Docker container can be useful for many reasons, but in this walkthrough we'll focus on using a Docker container to set up a development environment that is separate from your local environment.

The Remote Status bar item can quickly show you in which context VS Code is running (local or remote) and clicking on the item will bring up the Dev Containers commands.
Get the sample
To create a Docker container, we are going to open a GitHub repository with a Node.js project.

Open the Command Palette (F1) to run the command Dev Containers: Try a Dev Container Sample... and select the Node sample from the list.

Command Palette (F1) run Dev Containers: from a github repository.
git@github.com:brentgroves/php-test.git
https://github.com/brentgroves/php-test.git

How it works
This next section describes in more detail how the Dev Containers extension sets up and configures your containers.

The Dev Containers extension uses the files in the .devcontainer folder, namely devcontainer.json, and an optional Dockerfile or docker-compose.yml, to create your dev containers.

In the example we just explored, the project has a .devcontainer folder with a devcontainer.json inside. The devcontainer.json uses the image mcr.microsoft.com/devcontainers/javascript-node:0-18. You can explore this image in greater detail in the devcontainers/images repo.

First, your image is built from the supplied Dockerfile or image name, which would be mcr.microsoft.com/devcontainers/javascript-node:0-18 in this example. Then a container is created and started using some of the settings in the devcontainer.json. Finally your Visual Studio Code environment is installed and configured again according to settings in the devcontainer.json. For example, the dev container in this example installs the streetsidesoftware.code-spell-checker extension.

Note: Additional configuration will already be added to the container based on what's in the base image. For example, we see the streetsidesoftware.code-spell-checker extension above, and the container will also include "dbaeumer.vscode-eslint" as that's part of mcr.microsoft.com/devcontainers/typescript-node. This happens automatically when pre-building using devcontainer.json, which you may read more about in the pre-build section.

Once all of this is done, your local copy of Visual Studio Code connects to the Visual Studio Code Server running inside of your new dev container.

devcontainer.json
The devcontainer.json is basically a config file that determines how your dev container gets built and started.

//devcontainer.json
{
  "name": "Node.js",

  // Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
  "image": "mcr.microsoft.com/devcontainers/javascript-node:0-18",

  // Features to add to the dev container. More info: https://containers.dev/features.
  // "features": {},

  "customizations": {
    "vscode": {
      "settings": {},
      "extensions": ["streetsidesoftware.code-spell-checker"]
    }
  },

  // "forwardPorts": [3000],

  "portsAttributes": {
    "9000": {
      "label": "Hello Remote World",
      "onAutoForward": "notify"
    }
  },

  "postCreateCommand": "yarn install"

  // "remoteUser": "root"
}
The above example is extracted from the vscode-remote-try-node repo we used in the tutorial.

