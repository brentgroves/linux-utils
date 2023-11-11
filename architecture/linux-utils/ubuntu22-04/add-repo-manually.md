https://linuxize.com/post/how-to-add-apt-repository-in-ubuntu/
Manually Adding Repositories
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

If you want to have more control over how your sources are organized you can manually edit the /etc/apt/sources.list file and add the apt repository line to the file.

For demonstration, we will enable the CouchDB repository and install the software. CouchDB is a free and open-source fault-tolerant NoSQL database maintained by the Apache Software Foundation.

To add the repository open the sources.list file with your text editor :

sudo nano /etc/apt/sources.list
Copy
Add the repository line to the end of the file:

/etc/apt/sources.list
deb https://apache.bintray.com/couchdb-deb bionic main
Copy
Instead of editing the file with a text editor you can use the following command to append the repository line to the sources.list file:

echo "deb https://apache.bintray.com/couchdb-deb $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list
Copy
$(lsb_release -cs) will print the Ubuntu codename. For example, if you have Ubuntu version 18.04 the command will print bionic.

Another option is to create a new the repository file under the /etc/apt/sources.list.d/ directory.
When manually configuring a repository you also need to manually import the public repository key to your system. To do that use either wget or curl :

curl -L https://couchdb.apache.org/repo/bintray-pubkey.asc | sudo apt-key add -
Copy
The command above should output OK which means that the GPG key has been successfully imported and packages from this repository will be considered trusted.

Before installing the packages from the newly added repository you must update the package index:

sudo apt update
Copy
