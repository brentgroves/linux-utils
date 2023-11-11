[Remote host / container / WSL Linux prerequisites](https://code.visualstudio.com/docs/remote/linux#_remote-host-container-wsl-linux-prerequisites)
Platform prerequisites are primarily driven by the version of the Node.js runtime (and by extension the V8 JavaScript engine) shipped in the server component automatically installed on each remote endpoint. This server also has a set of related native node modules that need to be compiled and tested for each target. 64-bit x86 glibc-based Linux distributions currently provide the best support given these requirements.

You may encounter issues with certain extensions with native dependencies with ARMv7l (AArch32) / ARMv8l (AArch64) glibc-based hosts, containers, or WSL and 64-bit x86 musl-based Alpine Linux. For ARMv7l/ARMv8l, extensions may only include x86_64 versions of native modules or runtimes in the extension. For Alpine Linux, included native code or runtimes may not work due to fundamental differences between how libc is implemented in Alpine Linux (musl) and other distributions (glibc). In both these cases, extensions will need to opt-in to supporting these platforms by compiling / including binaries for these additional targets. Please raise an issue with the appropriate extension author requesting support if you encounter an extension that does not work as expected.
Set up SSH
There are several authentication methods into a VM, including an SSH public/private key pair or a username and password. We recommend using key-based authentication (if you use a username/password, you'll be prompted to enter your credentials more than once by the extension). If you're on Windows and have already created keys using PuttyGen, you can reuse them.

Create an SSH key
If you don't have an SSH key pair, open a bash shell or the command line and type in:

ssh-keygen -t ed25519
This will generate the SSH key. Press Enter at the following prompt to save the key in the default location (under your user directory as a folder named .ssh).

ssh-keygen output

You will then be prompted to enter a secure passphrase, but you can leave that blank. You should now have a id_ed25519.pub file which contains your new public SSH key.

Note: If you are using a legacy system that doesn't support the Ed25519 algorithm, you can use rsa instead: ssh-keygen -t rsa -b 4096.

Add SSH key to your VM
In the previous step, you generated an SSH key pair. Select Use existing public key in the dropdown for SSH public key source so that you can use the public key you just generated. Take the public key and paste it into your VM setup, by copying the entire contents of the id_ed25519.pub in the SSH public key. You also want to allow your VM to accept inbound SSH traffic by selecting Allow selected ports and choosing SSH (22) from the Select inbound ports dropdown list.
![ssh](https://code.visualstudio.com/assets/docs/remote/ssh-tutorial/add-ssh-public-key.png)
Connect using SSH
Now that you've created an SSH host, let's connect to it!

You'll have noticed an indicator on the bottom-left corner of the Status bar. This indicator tells you in which context VS Code is running (local or remote). Click on the indicator to bring up a list of Remote extension commands.



