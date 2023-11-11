https://linuxize.com/post/how-to-upgrade-to-ubuntu-22-04/
https://ubuntu.com/tutorials/install-ubuntu-desktop#3-create-a-bootable-usb-stick 

Remember to update dev1 mssql-release.list to 21.04 repo

Remember to use the vCenter web console to do these upgrades rdp does not work and ssh is not recommended
when performing a distro upgrade because disconnection can happen.

10.1.0.9
administrator@vsphere.local
Bu$ch3@dm!n

https://ostechnix.com/how-to-upgrade-to-ubuntu-20-04-lts-server/


A backup or VM snapshot or VM clone before beginning is very wise.
when prompted to restart services I lost rdp connection during upgrade.
https://www.techrepublic.com/article/how-to-upgrade-ubuntu-server-from-20-04-to-22-04/

https://linuxize.com/post/how-to-upgrade-to-ubuntu-22-04/
sudo apt-mark showhold
If there are on hold packages, you should unhold the packages with:
sudo apt-mark unhold package_name
sudo apt update
sudo apt upgrade
apt full-upgrade may remove some currently installed packages that prevents upgrading the system as a whole.
sudo apt full-upgrade
Remove old kernels and all automatically installed dependencies that are no longer needed by any package:
sudo apt --purge autoremove

sudo do-release-upgrade 

The do-release-upgrade command will disable all third-party repositories and change the apt list to point to the “jammy” repositories. You will be prompted several times to confirm that you want to continue with the upgrade. When asked whether you want the services to be automatically restarted during the upgrade type y.
During the upgrade process, the command will ask you various questions, like whether you want to keep an existing configuration file or to install the package maintainer’s version. If you didn’t make any custom changes to the file, it should be safe to type Y. Otherwise, is recommended to keep the current configuration. Read the questions carefully before making a selection.

The upgrade runs inside a GNU screen session and will automatically re-attach if connection drops.

The whole process may take some time depending on the number of updates and your Internet speed.

Once the new packages are installed, the update tool will ask you if you want to remove the obsolete software. If, you are not sure type d and check the list of obsolete packages. Generally, it is safe to enter y and remove all obsolete packages.
When the upgrade process is complete and assuming all went well, you’ll be asked to reboot your machine. Type y to continue:

System upgrade is complete.

Restart required

To finish the upgrade, a restart is required.
If you select 'y' the system will be restarted.

Continue [yN] y

ip-range 10.1.0.116-118,10.1.0.121
netmask:255.255.252.0
dns: 10.1.2.69, 10.1.2.70, 172.10.0.39, 10.30.1.27
gw:10.1.1.205
dev1: 10.1.0.125 - vm from develop-template -hostname is reports - dist upgrade to ubuntu 22.04 
Remember to update dev1 mssql-release.list to 21.04 repo
mcp1: 10.1.0.121 - 22.04 fresh install
reports3: 10.1.0.118 - made a mysql backup to 10.1.1.83 ~/backups/db/
cluster1
reports01: 10.1.0.116 - change to 10.1.0.116 Thank you Abba for this work.
reports02: 10.1.0.117
reports03: 10.1.0.118
cluster2
reports10: 10.1.0.120 - Ask Jared if it is ok to use this
reports11: 10.1.0.121 - Ask Jared if if is ok to use this.
I hope it is ok with you Father to use Holly's old computer.


https://linuxconfig.org/how-to-upgrade-ubuntu-to-22-04-lts-jammy-jellyfish

frt-ubu asks for administrator password if I upgrade from the GUI.
https://askubuntu.com/questions/1407533/microsoft-odbc-v18-is-not-find-by-apt/1409311#1409311s 

new
deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/ubuntu/21.04/prod hirsute main 
Old  
deb [arch=amd64,armhf,arm64] https://packages.microsoft.com/ubuntu/20.04/prod focal main 
 
I reenable the 'other software' repos that said disabled on upgrade to jammy.
And then i ran sudo apt-get update again to verify the repos are ok.

Some third party entries in your sources.list were disabled. You can re-enable them after the upgrade with the 'software-properties' tool or your package manager. 
The following services could not be restarted for the GNU libc library upgrade: 
mysql 
You will need to start these manually by running 'invoke-rc.d <service> start'. 
Please guide and direct us all today in the work you have prepared for us. 