sudo curl --output /usr/share/keyrings/nginx-keyring.gpg  \
      https://unit.nginx.org/keys/nginx-keyring.gpg
This eliminates the packages cannot be authenticated warnings during installation.

<!-- https://askubuntu.com/questions/741410/skipping-acquire-of-configured-file-main-binary-i386-packages-as-repository-x -->
To configure Unit’s repository, create the following file named /etc/apt/sources.list.d/unit.list:
sudo install -m 666 /dev/null /etc/apt/sources.list.d/unit.list
sudo cat << EOF > /etc/apt/sources.list.d/unit.list
deb [arch=amd64 signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ jammy unit
deb-src [arch=amd64 signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ jammy unit
EOF


https://linuxize.com/post/how-to-add-apt-repository-in-ubuntu/

Apt Sources
On Ubuntu and all other Debian based distributions, the apt software repositories are defined in the /etc/apt/sources.list file or in separate files under the /etc/apt/sources.list.d/ directory.

The names of the repository files inside the /etc/apt/sources.list.d/ directory must end with .list.
The general syntax of the /etc/apt/sources.list file takes the following format:
deb http://repo.tld/ubuntu distro component...

deb [signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ jammy unit
deb-src [signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ jammy unit

The first entry in the line defines the type of the archive. The archive type can be either deb or deb-src. Deb implies that the repository contains .deb packages while deb-src implies source packages.
The second entry is the repository URL.
The third entry specifies the distribution code name, such as beaver, xenial and so on.
The last entries are the repository components or categories. The default Ubuntu repositories are split into four components - main, restricted, universe and multiverse. Generally, third-party repositories have only one category.
The format for the files under the /etc/apt/sources.list.d/ directory is the same as for the regular sources.list file.
Most repositories are providing a public key to authenticate downloaded packages which need to be downloaded and imported.

To be able to add or remove a repository you need to be logged in as either a user with sudo access or root.

Usually, the instructions about how to enable a certain repository are included in the software documentation.

Installing add-apt-repository (add-apt-repository command not found )
add-apt-repository is a Python script that allows you to add an APT repository to either /etc/apt/sources.list or to a separate file in the /etc/apt/sources.list.d directory. The command can also be used to remove an already existing repository.

If the add-apt-repository is not available on your system you will get an error message saying “add-apt-repository command not found”.
The add-apt-repository utility is included in the software-properties-common package. To install it run the following commands:
sudo apt update
sudo apt install software-properties-common
CopyCopy
Adding Repositories with add-apt-repository
The basic syntax of the add-apt-repository command is as follows:

add-apt-repository [options] repository
Copy
Where repository can be either a regular repository entry that can be added to the sources.list file like deb http://repo.tld/ubuntu distro component or a PPA repository in the ppa:<user>/<ppa-name> format.

To see all available options of the add-apt-repository command type man add-apt-repository in your terminal.
By default, on ubuntu 18.04 and newer the add-apt-repository will also update the package index if the repository public key is imported.

The package index is a database that holds records of available packages from the repositories enabled in your system.

Let’s say you want to install MongoDB from their official repositories.
First import the repository public key:

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
Copy
Add the MongoDB repository using the command below.
sudo add-apt-repository 'deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse'
Copy
The repository will be appended to sources.list file.
You can now install any of the packages from the newly enabled repository:

sudo apt install mongodb-org
Copy
If for any reasons you want to remove a previously enabled repository, use the --remove option:

sudo add-apt-repository --remove 'deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse'
Copy

