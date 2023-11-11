Uninstalling PHP
If any PHP version is no more required, it can be removed from the system. That will free the disk space as well as system security.

To uninstall any PHP version just type:

sudo apt remove php5.6 
Also, uninstall all the modules for that version with the following command:

sudo apt remove php5.6-* 
Conclusion
This tutorial provides you with the instructions to install PHP on Ubuntu 22.04. The Ondrej PPA allows us to install PHP on Ubuntu systems quickly. It also allows us to install multiple PHP versions on a single system. You can switch to any PHP version as default anytime with the update-alternative utility.