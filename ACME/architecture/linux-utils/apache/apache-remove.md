https://www.programbr.com/ubuntu/permanently-remove-uninstall-apache2-from-ubuntu/
sudo apt-get remove apache2

https://phpcod.com/how-to-remove-apache2-from-ubuntu-server/
How To Remove Apache2 From Ubuntu Server
  August 29, 2022  Santosh  Ubuntu Server  No Comments
A very simple and straightforward way that worked for me is as follows:
Stop apache2.
sudo service apache2 stop
Uninstall Apache2 and its dependent packages.
sudo apt-get purge apache2 apache2-utils apache2.2-bin apache2-common
//or 
sudo apt-get purge apache2 apache2-utils apache2-bin apache2.2-common
Use autoremove option to get rid of other dependencies.
sudo apt-get autoremove
Check whether there are any configuration files that have not been removed.
whereis apache2
If you get a response as follows apache2: /etc/apache2 remove the directory and existing configuration files.
sudo rm -rf /etc/apache2