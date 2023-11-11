https://code.visualstudio.com/#alt-downloads
You can also install and unpack the CLI through the terminal of your remote machine. This may be especially helpful if your remote doesn't have a UI:

curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz

tar -xf vscode_cli.tar.gz
Note: If you're using the standalone or terminal install, the commands in the following section will start with ./code rather than code.

Create a secure tunnel with the tunnel command:

code tunnel
This command downloads and starts the VS Code Server on this machine and then creates a tunnel to it.

Note: You will be prompted to accept the server license terms when you first start a tunnel on a machine. You can also pass --accept-server-license-terms on the command line to avoid the prompt.

This CLI will output a vscode.dev URL tied to this remote machine, such as https://vscode.dev/tunnel/<machine_name>/<folder_name>. You can open this URL on a client of your choosing.

When opening a vscode.dev URL for the first time on this client, you'll be prompted to log into your GitHub account at a https://github.com/login/oauth/authorize... URL. This authenticates you to the tunneling service to ensure you have access to the right set of remote machines.



