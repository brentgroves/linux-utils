# new way
https://pureinfotech.com/install-microsoft-teams-linux/
UPDATED 6/6/2023: If you’re required to use a Linux distribution (such as Ubuntu, Debian, or Red Hat), you no longer need to use Windows 11 (or Windows 10) to connect with colleagues at work since Microsoft Teams is also available on Linux.

However, Microsoft has dropped the Teams apps for Linux in favor of the Progressive Web App (WPA) version of the service, which can also install on your computer for a more traditional experience. 

Once you download and install the Microsoft Teams app, you can access all the same features available with the app on Windows, including chat, video meetings, calling, and collaboration on Office documents from your Microsoft 365 and business subscriptions within a single interface.

In the past, Microsoft provided a public download for Teams apps from the Microsoft Teams official page, but that’s no longer the case. However, you can still download a standalone application from the operating system’s app store, such as Ubuntu Software, or commands through the Snap store, or you can use the Progressive Web App (WPA) version of the service, which can also install on your computer for a more traditional experience. 

This guide will teach you the steps to install Microsoft Teams on Linux.


# old way
On Ubuntu 22.04 you must disable Wayland support to be able to share you screen.
sudo nvim /etc/gdm3/custom.conf
Uncomment the following line.

WaylandEnable=false

Step 3: Reboot the system
Now reboot or restart your system to apply the changes. After rebooting you can share your screen on zoom, ms team, etc.

You can confirm the changes by running the following command again.

echo $XDG_SESSION_TYPE
If you correctly change the conf file, it will show you display x11.

sudo dpkg --remove teams
I don't know which way to install is best
https://technoracle.com/how-to-install-microsoft-teams-on-ubuntu-22-04/
I am going to try the snap method on ubuntu 22.04
Step 1: Update Ubuntu System
First, update your Ubuntu package manager using the following command.
sudo apt update
Step 2: Install MS Teams
Now, run the following command to install Microsoft Teams.
sudo snap install teams
Step 3: Verify Installation
Run the application by typing the application name.
$ teams

Note: When you install MS Teams on Ubuntu 22.04, screen sharing will not work after installation. To fix the MS Teams screen sharing issue on Ubuntu 22.04, you have to change the display configuration to Xorg from Wayland. Follow this tutorial to fix MS Teams, Zoom screen sharing issues on Ubuntu 22.04.

https://technoracle.com/how-to-fix-zoom-screen-sharing-on-ubuntu-22-04-quickly/
Why Zoom Screen Sharing is not Working on Ubuntu 22.04
As Ubuntu 22.04 comes with a display feature called Wayland. Wayland till now not supporting to screen share by default. In the previous Ubuntu version, we had Xorg for the display feature.

