https://github.com/devcontainers/cli/tree/main/example-usage#dev-container-cli-examples
Dev Container CLI Examples
This folder contains a set of basic examples that use the devcontainer CLI for different use cases. It includes example scripts to:

Use three different tools from a development container
Use a dev container as your CI build environment (even if your app is not deployed as a container)
Build a container image from a devcontainer.json file that includes dev container features
Each should run on macOS or Linux. For Windows, you can use these scripts from WSL2.

# Install cli
## Pre-requisites
Install Node.js 16 (e.g., using nvm)
Install node-gyp pre-requisites:
Linux/WSL2: Use your distro's package manager. E.g. on Ubuntu/Debian: sudo apt-get update && sudo apt-get install python3-minimal gcc g++ make
macOS: Install the XCode Command Line Tools (more info)
Make sure you have an OpenSSH compliant ssh command available and in your path if you plan to use the Vim via SSH example (it should already be there on macOS, and in Linux/WSL, you can install openssh-client using your distro's package manager if its missing)
Install the latest dev container CLI: npm install -g @devcontainers/cli
npm install -g @devcontainers/cli

Using the examples
All examples use the contents of the workspace folder for their configuration, which is where you can make modifications if you'd like. The example scripts are then in different sub-folders.

# Tool examples
You can use these examples by opening a terminal and typing one of the following:

tool-vscode-server/start.sh - VS Code Server (official)
tool-openvscode-server/start.sh - openvscode-server
tool-vim-via-ssh/start.sh - Vim via an SSH connection. SSH is used primarily to demonstrate how this could be achieved from other SSH supporting client tools.

When switching between examples, pass true in as an argument to get the container recreated to avoid port conflicts. e.g., ./start.sh true
In the first two examples, you'll be instructed to go to http://localhost:8000 in a browser.
This also adds a desktop to the container that can be accessed from a web browser at http://localhost:6080 and you can connect using the password vscode.

npm install
To install the npm package, you will need Python, Node.js (version 14 or greater), and C/C++ installed to build one of the dependencies. The VS Code How to Contribute wiki has details about the recommended toolsets.

npm install -g @devcontainers/cli
Verify you can run the CLI and see its help text:

devcontainer <command>

Commands:
  devcontainer up                   Create and run dev container
  devcontainer build [path]         Build a dev container image
  devcontainer run-user-commands    Run user commands
  devcontainer read-configuration   Read configuration
  devcontainer features             Features commands
  devcontainer templates            Templates commands
  devcontainer exec <cmd> [args..]  Execute a command on a running dev container

Options:
  --help     Show help                                                 [boolean]
  --version  Show version number                                       [boolean]

