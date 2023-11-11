https://code.visualstudio.com/docs/remote/vscode-server
What is the VS Code Server?
In VS Code, we want users to seamlessly leverage the environments that make them the most productive. The VS Code Remote Development extensions allow you to work in the Windows Subsystem for Linux (WSL), remote machines via SSH, and dev containers directly from VS Code. These extensions install a server on the remote environment, allowing local VS Code to smoothly interact with remote source code and runtimes.

We now provide a standalone "VS Code Server," which is a service built off the same underlying server used by the remote extensions, plus some additional functionality, like an interactive CLI and facilitating secure connections to vscode.dev.

Architecture
We want to provide a unified VS Code experience no matter how you use the editor, whether it's local or remote, in the desktop or in the browser.

Access to the VS Code Server is built in to the existing code CLI.

The CLI establishes a tunnel between a VS Code client and your remote machine. Tunneling securely transmits data from one network to another.

The VS Code Server experience includes a few components:

The VS Code Server: Backend server that makes VS Code remote experiences possible.
Remote - Tunnels extension: Automatically loaded in your local VS Code client, it facilitates the connection to the remote machine.
Scenarios
The VS Code Server allows you to use VS Code in new ways, such as:

Developing on a remote machine where SSH support may be limited, or you need web-based access.
Developing on a machine that doesn't support the installation of VS Code desktop, such as an iPad / tablet or Chromebook.
Experiencing the client-side security benefit that all code can be executed in the browser sandbox.

Getting Started
You can choose from two paths to enable tunneling, which are described in greater details in their respective docs content:

Run the tunnel command in the code CLI
Enable tunneling through the VS Code UI

https://code.visualstudio.com/#alt-downloads

https://github.com/gitpod-io/openvscode-server