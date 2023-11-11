https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack
# From VSCode install extensions
ctrl-p to bring up the search window and then type the following command.
ext install ms-vscode-remote.vscode-remote-extensionpack
https://code.visualstudio.com/docs/devcontainers/tutorial

The Remote Status bar item can quickly show you in which context VS Code is running (local or remote) and clicking on the item will bring up the Dev Containers commands.

To create a Docker container, we are going to open a GitHub repository with a PHP project.

Open the Command Palette (F1) to run the command Dev Containers: from a github repository.

git@github.com:brentgroves/php-test.git
https://github.com/brentgroves/php-test.git

When the app noticed this was a PHP project it created a devcontainer.json file with the PHP dev container image selected.
	"image": "mcr.microsoft.com/devcontainers/php:0-8.2",

Once all of this is done, your local copy of Visual Studio Code connects to the Visual Studio Code Server running inside of your new dev container.
The devcontainer.json also has an important port forwarding key.
Use 'forwardPorts' to make a list of ports inside the container available locally.
	"forwardPorts": [8080]
Since the XDebug server is going to connect to the debug client on port 9000 you can add 9000 to the forwardedPorts
The launch.json contains the debugger key pairs in "Listen for Xdebug" configuration.
    {
      "name": "Listen for Xdebug",
      "type": "php",
      "request": "launch",
      "port": 9000
    },

If you open a terminal from the devcontainer we can make sure the xdebug plugin is present and what port the DBGP debug client should be listening on.
php -v
PHP 8.2.5 (cli) (built: Apr 14 2023 17:26:01) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.2.5, Copyright (c) Zend Technologies
    with Xdebug v3.2.1, Copyright (c) 2002-2023, by Derick Rethans

php -i | grep xdebug
xdebug.client_host => localhost => localhost
xdebug.client_port => 9000 => 9000
xdebug.mode => debug => debug
did not see debug.start_with_request=yes 
...

Set a breakpoint in index.php
Launch the debugger "Listen for XDebug" configuration.

Start the PHP web server from a dev container terminal.
php -S 127.0.0.1:8080

From a user agent request http://localhost:8080
curl http://localhost:8080

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

