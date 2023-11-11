https://kifarunix.com/install-nomachine-on-ubuntu-2/

NoMachine is a remote desktop tool just like VNC, TeamViewer. It is designed to work across several platforms such as Windows, Mac and Linux to give users access to the physical desktop of the remote computer. NoMachine provides the best, fastest and highest quality remote desktop experience.
https://downloads.nomachine.com/download/?id=2
VER=8.5.3_1
wget "https://download.nomachine.com/download/${VER%.*}/Linux/nomachine_${VER}_amd64.deb"

sudo dpkg -i nomachine_${VER}_amd64.deb
or 
sudo apt install ./nomachine_${VER}_amd64.deb

Remove
sudo dpkg -P nomachine_${VER}_amd64.deb
Running NoMachine on Ubuntu 22.04
Once the installation completes, the NoMachine package is now available in your system.

You can launch it from the applications menu. Also, you should be able to see the !M icon on the system tray.

Configuring NoMachine on Ubuntu 22.04
NoMachine can be configured as a server or a client depending on how you are using it.

To access the NoMachine settings:

click on the !M icon in the system tray or NoMachine service from the system apps as shown in the screenshot above.
click Show the Service status 
Click on Server preferences settings to access !M server settings.
**![screen shot](https://kifarunix.com/wp-content/uploads/2021/09/nomachine-settings.png)**

Under the Ports tab, you can uncheck the Advertise this computer on the local network.
**![unadvertise](https://kifarunix.com/wp-content/uploads/2021/09/ports.png)**

Under the Security tab, you need to uncheck the Require permission to let users connect option if you are running unattended remote desktop system.
**![require permission](https://kifarunix.com/wp-content/uploads/2021/09/security.png)**

Go through other tabs for more configuration options.

When done setting up NoMachine on your Kali Linux 2021, restart NoMachine server.

Open NoMachine Server Port on Firewall
You may need to open these ports, 4000/tcp, 4011:4999/udp on firewall to access NoMachine. See how to control NoMachine ports on Firewall;

Control NoMachine Ports on Firewall

Connecting to Remote Desktop Computer using NoMachine
As stated above, for NoMachine remote connections to work, both desktop computers must have NoMachine software installed.

Assuming your client desktop machine has NoMachine already installed launch it and click NoMachine client icon or simply click the !M icon on the system tray and click Show Main Window.

NoMachine try to search for any local NoMachine connections.

If it dont find any, click on the +add button to create new connection.

https://www.eskimo.com/support/remote-desktop/remmina-nx/

http://10.1.0.120:4000