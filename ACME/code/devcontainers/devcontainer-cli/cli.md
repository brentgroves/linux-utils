
https://github.com/devcontainers/cli
This CLI is in active development. Current status:

 devcontainer build - Enables building/pre-building images
 devcontainer up - Spins up containers with devcontainer.json settings applied
 devcontainer run-user-commands - Runs lifecycle commands like postCreateCommand
 devcontainer read-configuration - Outputs current configuration for workspace
 devcontainer exec - Executes a command in a container with userEnvProbe, remoteUser, remoteEnv, and other properties applied
 devcontainer features <...> - Tools to assist in authoring and testing Dev Container Features
 devcontainer templates <...> - Tools to assist in authoring and testing Dev Container Templates
 devcontainer stop - Stops containers
 devcontainer down - Stops and deletes containers
Try it out
We'd love for you to try out the dev container CLI and let us know what you think. You can quickly try it out in just a few simple steps, either by installing its npm package or building the CLI repo from sources (see "Build from sources").

To install the npm package you will need Python and C/C++ installed to build one of the dependencies (see, e.g., here for instructions).
# Install cli
## Pre-requisites
Install Node.js 16 (e.g., using nvm)
Install node-gyp pre-requisites:
Linux/WSL2: Use your distro's package manager. E.g. on Ubuntu/Debian: sudo apt-get update && sudo apt-get install python3-minimal gcc g++ make
macOS: Install the XCode Command Line Tools (more info)
Make sure you have an OpenSSH compliant ssh command available and in your path if you plan to use the Vim via SSH example (it should already be there on macOS, and in Linux/WSL, you can install openssh-client using your distro's package manager if its missing)
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