https://github.com/devcontainers/cli/tree/main/example-usage
https://github.com/devcontainers/cli/tree/main/example-usage#tool-examples
Using the examples
All examples use the contents of the workspace folder for their configuration, which is where you can make modifications if you'd like. The example scripts are then in different sub-folders.

Tool examples
You can use these examples by opening a terminal and typing one of the following:

tool-vscode-server/start.sh - VS Code Server (official)
tool-openvscode-server/start.sh - openvscode-server
tool-vim-via-ssh/start.sh - Vim via an SSH connection. SSH is used primarily to demonstrate how this could be achieved from other SSH supporting client tools.
When switching between examples, pass true in as an argument to get the container recreated to avoid port conflicts. e.g., ./start.sh true

In the first two examples, you'll be instructed to go to http://localhost:8000 in a browser.

This also adds a desktop to the container that can be accessed from a web browser at http://localhost:6080 and you can connect using the password vscode.

How the tool examples work
These examples demonstrate the use of the dev container CLI to:

Simplify setup using the "dev container features" concept. For example, SSH support is added just using a feature reference. See workspace/.devcontainer/devcontainer.json for more information.

How the dev container CLI can be used to inject tools without building them into the base image:

Use devcontainer up to spin up the container and mount a server and workspace folder into the container.
Use devcontainer exec to run a script from this mounted folder to set up the appropriate server (and apply tool specific settings/customizations).
In the vim example, a temporary SSH key is set up and configured, and then SSH is used from the command line to connect to the container once it is up and running. See tool-vim-via-ssh/start.sh for details.
Currently the appPort property is used in devcontainer.json instead of forwardPorts due to a gap in the current dev container CLI (see here).

