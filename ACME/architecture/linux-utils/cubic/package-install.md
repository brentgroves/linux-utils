https://github.com/PJ-Singh-001/Cubic/issues/225

Installed packages via Cubic are not registered in final installed OS - Ubuntu 22.04 #225

Describe the bug

In the final installed OS the packages that are added via Cubic in terminal are not registered to dpkg. This means that the binary files and libraries are in fact present on the filesystem, however if I run dpkg -l | grep <package> it yields no results. Using mlocate for example throws error message: unknown group: plocate - which suggests binary is present however group under which command runs is not.

To Reproduce

In a step where Cubic opens a terminal for user to install and adjust the OS that is going to be installed I've installed lxqt desktop environment
I've used ISO ubuntu 22.04.2 for Ubuntu server
I've selected LZ compression and made no other adjustments
I've finished the ISO build via Cubic
I've installed the OS in proxmox virtualisation environment (it does not matter where you install it on)
I've run the command:

root@u22-tst:~# dpkg -l|grep lxqt|wc -l
0
I've run the commands:

root@u22-tst:~# which lxqt-about
/usr/bin/lxqt-about
root@u22-tst:~# locate lxqt|wc -l
2304
To verify that lxqt is installed - it is - however dpkg does not register that.

Expected behavior

It is expected that once squashfs is unsquashed and you are chrooted into it - the contents and the package database will be transferred into a working OS during installation. This is not the case.

OS Information (please complete the following information):

OS/Distro Name: Ubuntu
OS Version: 22.04
Cubic Information (please complete the following information):

Cubic Version: 2023.05-83-release202305230205ubuntu22.04.1 all
ISO Customizing: ubuntu-22.04.2-live-server-amd64.iso
Download Link: https://releases.ubuntu.com/22.04.2/ubuntu-22.04.2-live-server-amd64.iso

This is an unfortunate side effect of the new structure Canonical uses for ISOs with the Subiquity installer.

Here is the explanation I had provided for another question...

The Ubuntu Server ISO has two layers (conceptually):

Ubuntu Standard Layer
Ubuntu Minimal Layer
**![Ubuntu Standard and Minimal layer](https://user-images.githubusercontent.com/19394936/240445460-9e184625-d0e4-4e48-bb46-ac92ab33fc35.png)**

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