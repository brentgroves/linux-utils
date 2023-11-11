# Install cli
## Pre-requisites
Install Node.js 16 (e.g., using nvm)
npm install -g node-gyp
Install the latest dev container CLI: npm install -g @devcontainers/cli
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
  --version  Show version number   
  
  Try out the CLI
Once you have the CLI, you can try it out with a sample project, like this Rust sample.

Clone the Rust sample to your machine, and start a dev container with the CLI's up command:

git clone https://github.com/microsoft/vscode-remote-try-rust
devcontainer up --workspace-folder <path-to-vscode-remote-try-rust>
This will download the container image from a container registry and start the container. Your Rust container should now be running:
More CLI examples
The example-usage folder contains some simple shell scripts to illustrate how the CLI can be used to:

Inject tools for use inside a development container
Use a dev container as your CI build environment to build an application (even if it is not deployed as a container)
Build a container image from a devcontainer.json file that includes dev container features

https://github.com/devcontainers/cli/tree/main/example-usage