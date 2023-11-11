https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack
https://code.visualstudio.com/docs/remote/ssh-tutorial
Remote development over SSH
This tutorial walks you through creating and connecting to a virtual machine (VM) on Azure using the Visual Studio Code Remote - SSH extension. You'll create a Node.js Express web app to show how you can edit and debug on a remote machine with VS Code just like you could if the source code was local.

Note: Your Linux VM can be hosted anywhere - on your local host, on premise, in Azure, or in any other cloud, as long as the chosen Linux distribution meets these prerequisites.

Install the extension
This extension is installed when you install the remote extension pack.
Remote - SSH
With the Remote - SSH extension installed, you will see a new Status bar item at the far left.
The Remote Status bar item can quickly show you in which context VS Code is running (local or remote) and clicking on the item will bring up the Remote - SSH commands.

Connect using SSH
Now that you've created an SSH host, let's connect to it!

You'll have noticed an indicator on the bottom-left corner of the Status bar. This indicator tells you in which context VS Code is running (local or remote). Click on the indicator to bring up a list of Remote extension commands.

Choose the Connect to Host... command in the Remote-SSH section and connect to the host by entering connection information for your VM in the following format: user@hostname.

Before connecting in Remote - SSH, you can verify you're able to connect to your VM via a command prompt using ssh user@hostname.

Note: If you run into an error ssh: connect to host <host ip> port 22: Connection timed out, you may need to delete NRMS-Rule-106 from the Networking tab of your VM:

Set the user and hostname in the connection information text box.
VS Code will now open a new window (instance). You'll then see a notification that the "VS Code Server" is initializing on the SSH Host. Once the VS Code Server is installed on the remote host, it can run extensions and talk to your local instance of VS Code.

You'll know you're connected to your VM by looking at the indicator in the Status bar. It shows the hostname of your VM.
The Remote - SSH extension also contributes a new icon on your Activity bar, and clicking on it will open the Remote explorer. From the dropdown, select SSH Targets, where you can configure your SSH connections. For instance, you can save the hosts you connect to the most and access them from here instead of entering the user and hostname.

Once you're connected to your SSH host, you can interact with files and open folders on the remote machine. If you open the integrated terminal (Ctrl+`), you'll see you're working inside a bash shell while you're on Windows.

You can use the bash shell to browse the file system on the VM. You can also browse and open folders on the remote home directory with File > Open Folder.

Create your Node.js application
In this step, you will create a simple Node.js application. You will use an application generator to quickly scaffold out the application from a terminal.

# run express-generator without installing it using npx
npx express-generator --view=pug expressExample

cd expressExample
npm install

Run the application
DEBUG=expressexample:* npm start

npm start
The Express app by default runs on http://localhost:3000. You won't see anything in your local browser on localhost:3000 because the web app is running on your virtual machine.

Port forwarding
To be able to browse to the web app on your local machine, you can leverage another feature called Port forwarding.

To be able to access a port on the remote machine that may not be publicly exposed, you need to establish a connection or a tunnel between a port on your local machine and the server. With the app still running, open the SSH Explorer and find the Forwarded Ports view. Click on the Forward a port link and indicate that you want to forward port 3000:



https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack
Visual Studio Code Remote Development Extension Pack