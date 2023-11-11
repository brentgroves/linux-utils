# MySQL Shell

## References

<https://dev.mysql.com/doc/mysql-shell/8.0/en/>

<https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-shell-install-linux-quick.html>

<https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#apt-repo-setup>

## Notes

First, add the MySQL APT repository to your system's software repository list. Follow these steps:

Go to the download page for the MySQL APT repository at <https://dev.mysql.com/downloads/repo/apt/>.

Select and download the release package for your Linux distribution.

Although this is not required for each update, it does update MySQL repository information to include the current information. For example, mysql-apt-config_0.8.26-1_all.deb is the first APT repository configuration file that adds the innovation release track that begins with MySQL 8.1.

Install the downloaded release package with the following command, replacing version-specific-package-name with the name of the downloaded package (preceded by its path, if you are not running the command inside the folder where the package is):

```bash
cd ~/Downloads
 curl -LO https://dev.mysql.com/get/mysql-apt-config_0.8.28-1_all.deb
sudo dpkg -i ~/Downloads/mysql-apt-config_0.8.28-1_all.deb
Note that the same package works on all supported Debian and Ubuntu platforms. Only select the tools not the server.


Update the MySQL APT repository configuration package with the following command:
sudo apt-get install mysql-apt-config

When asked in the dialogue box to configure the repository, make sure you choose MySQL 8.0 as the release series you want.

Install MySQL Shell with this command:
sudo apt-get install mysql-shell

```
