**[Installed packages via Cubic are not registered in final installed OS - Ubuntu 22.04 #225](https://github.com/PJ-Singh-001/Cubic/issues/225)**
In the final installed OS the packages that are added via Cubic in terminal are not registered to dpkg. This means that the binary files and libraries are in fact present on the filesystem, however if I run dpkg -l | grep <package> it yields no results. Using mlocate for example throws error message: unknown group: plocate - which suggests binary is present however group under which command runs is not.

# What does the Canonical ISO structure look like
**![Ubuntu Standard and Minimal layer](https://user-images.githubusercontent.com/19394936/240445460-9e184625-d0e4-4e48-bb46-ac92ab33fc35.png)**

The Ubuntu Standard Layer overrides your changes in Cubic, because Cubic allows you to customize the Minimal Layer, not the Standard Layer.

You will not be able to see your customizations in the Live Environment (accessed by selecting "Enter Shell" from the "Help" menu item at the top right) because the Live Environment shows the Standard Layer.

However, you can ensure your customizations are reflected in the installed OS by selecting "Ubuntu Server (minimized)" during installation.

# Here is the workaround...

In your case, install (or remove) all the packages you want in Cubic.

Remember, you will be customizing a "Minimal" install.

If you want all of the packages from a "Standard" install, you can execute the unminimize script inside Cubic.

You have entered the virtual environment.
root@cubic:~# unminimize
This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

This script restores content and packages that are found on a default
Ubuntu server system in order to make this system more suitable for
interactive use.
...
This operation may take some time.

Would you like to continue? [y/N]
When you are done with your customizations/changes, do not expect them to be present in the Live Environment. (For example, dpkg -l will give incorrect results in the Live Environment).

However, when you install your customized OS, select "Ubuntu Server (minimized)" during installation. This will ensure all of your customizations/changes are copied to your installed OS. After you've installed the OS using "Ubuntu Server (minimized)", dpkg -l will return the expected results.

https://www.makeuseof.com/create-custom-ubuntu-iso-cubic/
https://github.com/PJ-Singh-001/Cubic
What Is Cubic?
Like all good open-source projects, Cubic is a backronym—in this case standing for Custom UBuntu ISO Creator, and as its expanded name suggests, it is a tool to help you create a customized live ISO image for Ubuntu-based distributions.

Ubuntu is a tremendously popular distro, and in addition to the main Ubuntu download, and its already highly customized flavors, including Kubuntu, Lubuntu, Xubuntu, Ubuntu Studio, Budgie, and MATE, it also underpins distros such as elementary OS, Linux Mint, and KDE Neon. Any of these could be exactly what you're looking for—if only they were slightly different.

Cubic runs as a GUI wizard which helps with "effortless navigation through the ISO customization steps and features an integrated virtual command line environment". Simply choose your favorite Ubuntu-based distro and follow the step-by-step guide to get exactly what you need.

Cubic runs on distributions based on Ubuntu 18.04.5 Bionic and above, and while it is possible to run Cubic in a virtual environment, it isn't recommended. To begin, first enable the Universe repository and the Cubic PPA:

sudo apt-add-repository universe
sudo apt-add-repository ppa:cubic-wizard/release
Repository: 'deb https://ppa.launchpadcontent.net/cubic-wizard/release/ubuntu/ jammy main'
Description:
PPA for Cubic release branch

      ///////
     ///\   \
    ///  \___\  Custom Ubuntu ISO Creator
    \ \  /////
     \ \/////
      \_____\

Cubic (Custom Ubuntu ISO Creator) is a GUI wizard to create a customized Ubuntu or Debian Live ISO image.

Website:   https://github.com/PJ-Singh-001/Cubic/wiki
More info: https://launchpad.net/~cubic-wizard/+archive/ubuntu/release

Now update your system, and install Cubic:

sudo apt update
sudo apt install --no-install-recommends cubic
You can now access Cubic through your menu system, or by typing:

cubic
https://github.com/PJ-Singh-001/Cubic

**![cubic](https://static1.makeuseofimages.com/wordpress/wp-content/uploads/2022/11/source-and-custom.jpg?q=50&fit=crop&w=1500&dpr=1.5)**


https://github.com/PJ-Singh-001/Cubic/wiki/Start-Page
On the Cubic Start Page, select a directory for your customization project.

Each Cubic project must have its own project directory.

Create a new folder for your project using the file chooser dialog, if needed.

https://github.com/PJ-Singh-001/Cubic/wiki/Project-Page
**![project page](https://github.com/PJ-Singh-001/Cubic/raw/release/screenshots/Cubic%20Project%20Page.png)**
On the Cubic Project Page, click on the folder icon in the Original section to select an ISO image to customize. Information about your project will be automatically filled out for you. You can change information about your customized ISO, or you can accept the recommended defaults.

If you chose to change some of the values, the related parameters will automatically be updated as you type. The Undo and Redo buttons only affect the fields in the Custom section. The Refresh button allows you to update the version of your new ISO to today's date, and clicking this button will replace all occurrences of the old version in the Custom fields with the new version.

For an existing project with a previously generated ISO, click the Test button to test the previously generated ISO. The QEMU † emulator will launch and boot into the new ISO. If there is no previously generated ISO for your project, or if you do not have enough memory to permit testing, you will not see the Test button.

**![test](https://github.com/PJ-Singh-001/Cubic/raw/release/screenshots/Cubic%20Project%20Page%20Existing%20Project.png)**

# Customize page
The Cubic Terminal Page is a virtual environment where you can customize your Linux file system. You will need to use the command line, but because you are logged in as a root user, you do not need to use sudo when typing commands.
**![Customize](https://github.com/PJ-Singh-001/Cubic/raw/release/screenshots/Cubic%20Terminal%20Page.png)**

Note that there are no active services in this virtual environment, as you would find in an actual running OS. This is because the terminal in Cubic is not a "running" OS. It is just a secure, isolated file system that you have root access to, in order to edit, add, or delete files. Thus, services such as systemd, X11, snapd, etc. can not run in the virtual environment in Cubic.

Any changes you make to the file system are applied immediately. When you are done making your changes, click the Next button. Remember, you can always come back to the terminal environment for this project to make additional customizations in the future.

If you accidentally exit the virtual environment, it will automatically restart.

DNS lookups may not work in this environment, and you may not be able to use apt due to a "Name or service not known" error. This is because the link /etc/resolv.conf points to /run/systemd/resolve/stub-rsystemctl status ssh
To resolve this, execute the following command...

mkdir /run/systemd/resolve/
echo "nameserver 127.0.1.1
search network" | tee /run/systemd/resolve/resolv.conf
ln -sr /run/systemd/resolve/resolv.conf /run/systemd/resolve/stub-resolv.conf

Here are a few examples of customizing Ubuntu using the command line...

You may use the nsystemctl status sshrepositories list, type

nano /etc/apt/sources.list
To exit nano, type Ctrl+X and you will be prompted to save the file. Type Y to save the file, and press Enter to accept the default file name. Otherwise, type N to cancel saving the file.

**![use apt](https://github.com/PJ-Singh-001/Cubic/raw/release/screenshots/Cubic%20Terminal%20Page%20Nano.png)**

You can copy files or directories into the current directory by dragging them onto the terminal window, by using the copy button in the header bar, or by using the right-click context menu. Although Cubic currently does not support copying files over the network, you can use the rcp or scp commands within the terminal environment to copy network files.

The right-click context menu also allows you to select all text, copy text, and paste text in the terminal. Additionally, the keyboard shortcut Ctrl+Shift+A can be used to select all text, Ctrl+Shift+C can be used to copy text, and Ctrl+Shift+V can be used to paste text.

Here is an example to copy additional wallpapers into your customized environment.

cd /usr/share/backgrounds
Then simply drag the new wallpapers onto the Cubic window.

Tip: Be sure to list the new wallpapers in an XML file under /usr/share/gnome-background-properties, so they will be listed in the Change Background dialog when the user right-clicks on his/her desktop.


rcp /mydirectory/kt.txt kartik:one/kt.txt
rcp brent@reports-avi:/home/brent/45-allow-colord.pkla /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla

apt update
apt upgrade
apt install openssh-server -y
apt-add-repository universe
apt install xrdp 
adduser xrdp ssl-cert
systemctl status ssh
https://c-nergy.be/blog/?p=18205