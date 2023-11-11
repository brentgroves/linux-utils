To get started with a dev container project click on the lower left icon "open a remote window".
You are given a menu and can select create a new dev container config.
Then you can select from one of the predefined templates like docker from docker or kubernetes and helm which includes docker.
This creates the devcontainer files to use docker and kubernetes/helm in your container.

https://github.com/microsoft/vscode-remote-try-php

Once I got the base php devcontainer installed from the website I added the docker from docker and kubernetes and help features and the container was rebuilt fine and xdebug still worked.

Next try to build an image with the cli
https://github.com/devcontainers/cli so maybe you can take those features out of the devcontainer.json file when using the new image.