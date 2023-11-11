https://tecadmin.net/how-to-install-php-on-ubuntu-22-04/
Prerequisites
First, log in to Ubuntu 22.04 via the console. Then update the Apt cache and upgrade the current packages of the system using the following command:

sudo apt update && sudo apt upgrade 
Install a few dependencies required by this tutorial with the below-mentioned command:
sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https 
Add the Ondrej PPA to your system, which contains all versions of PHP packages for Ubuntu systems.
LC_ALL=C.UTF-8 sudo add-apt-repository ppa:ondrej/php 
Now, update the Apt package manager cache.
sudo apt update 

sudo apt install php8.2 
The SURY repository contains PHP 8.2, 8.1, 7.4, 7.3, 7.2 & PHP 5.6. As the latest stable version of PHP is 8.2, but a large number of websites still required PHP 7.x. You can install any of the required PHP versions on your system.
Install PHP 8.2:
sudo apt install php8.2 
Install PHP 8.1:
sudo apt install php8.1 
Install PHP 7.4:
sudo apt install php7.4 
Install PHP 5.6 (EOL):
sudo apt install php5.6 

Most PHP applications depend on various extensions to extend their features. That can also be installed using the following syntax:
sudo apt install php8.2-[extension]
Replace [extension] with the extension you want to install, if you want to add multiple extensions then include them in braces, I am going to install “php-mbstring, php-mysql, php-xml, and php-curl” by running the below-mentioned command:

sudo apt install php8.2-mysql php8.2-mbstring php8.2-xml php8.2-curl 

Check Active PHP Version
Now after installation verify that the correct version of PHP is installed by checking the version number by the below-mentioned command:

php -v 

Switch Default PHP Version for CLI
You can use an `update-alternatives` command to set the default PHP version. Use this tutorial to read more details about switching the PHP version for CLI and Apache.

sudo update-alternatives --config php
There are 4 choices for the alternative php (providing /usr/bin/php).

  Selection    Path             Priority   Status
------------------------------------------------------------
* 0            /usr/bin/php8.1   81        auto mode
  1            /usr/bin/php5.6   56        manual mode
  2            /usr/bin/php7.4   74        manual mode
  3            /usr/bin/php8.0   80        manual mode
  4            /usr/bin/php8.1   81        manual mode
  5            /usr/bin/php8.2   82        manual mode

Press  to keep the current choice[*], or type selection number: 2
The above output shows all the installed PHP versions on your system. Selection number 2 set PHP 7.4 as the default PHP version for the command line.

Uninstalling PHP
If any PHP version is no more required, it can be removed from the system. That will free the disk space as well as system security.

To uninstall any PHP version just type:

sudo apt remove php5.6 
Also, uninstall all the modules for that version with the following command:

sudo apt remove php5.6-* 
Conclusion
This tutorial provides you with the instructions to install PHP on Ubuntu 22.04. The Ondrej PPA allows us to install PHP on Ubuntu systems quickly. It also allows us to install multiple PHP versions on a single system. You can switch to any PHP version as default anytime with the update-alternative utility.
https://techvblogs.com/blog/install-multiple-php-versions-on-ubuntu-22-04
How to Install Multiple PHP Versions on Ubuntu 22.04
In this tutorial, you will learn how to install multiple PHP versions on ubuntu 22.04.

We will use the Ondrej PPA for installing PHP on Ubuntu 22.04 LTS system. Which contains PHP 8.2, 8.1, 8.0, 7.4, 7.3, 7.2. 7.1, 7.0 & PHP 5.6 packages. You can install any of the versions as required for your application. The new application developers are suggested to use the latest PHP version ie PHP 8.1.

In this tutorial, you will learn how to install PHP on Ubuntu 22.04 LTS system. This tutorial is also compatible with Ubuntu 20.04, and 18.04 systems.

Step 1: System Update
First, log in to Ubuntu 22.04 via console. Then update the Apt cache and upgrade the current packages of the system using the following command:

sudo apt-get update
sudo apt-get upgrade 
When prompted, press y to confirm the installation.

Step 2: Installing Multiple PHP Versions on Ubuntu 22.04
The easiest way to install multiple versions of PHP is by using the PPA from Ondřej Surý, who is a Debian developer. To add this PPA, run the following commands in the terminal. The software-properties-common package is needed if you want to install software from PPA. It’s installed automatically on the Ubuntu desktop but might miss on your Ubuntu server.

sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
