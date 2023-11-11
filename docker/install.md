https://docs.docker.com/engine/install/ubuntu/
# remove old versions
https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine

# stop the service
sudo service docker stop

# Uninstall the Docker Engine, CLI, Containerd, and Docker Compose packages:
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-engine docker docker.io containerd runc docker-ce-rootless-extras docker-scan-plugin

# find out if all packages were removed
dpkg -l | grep -i docker

# Delete Remaining Files
Run the following commands to delete all images, containers, volumes, user created configuration files. Do this only if you are sure you don’t need to use Docker again. Otherwise, if you re-install Docker, you will not be able to access these files.

sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo rm -rf /var/run/docker.sock
sudo rm -rf /var/lib/containerd
sudo rm -rf /usr/local/bin/docker-compose
sudo rm -rf ~/.docker
sudo groupdel docker

# reboot system 
This is a must
sudo reboot

# Set up the repository
Update the apt package index and install packages to allow apt to use a repository over HTTPS:

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
https://docs.docker.com/engine/install/ubuntu/
# Add Docker’s official GPG key:
Add Docker's official GPG key:

content_copy
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Use the following command to set up the repository:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# make sure it is from docker.com and not ubuntu.com
sudo apt-get update
apt-cache policy docker-ce

# To install the latest version, run:
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify that the Docker Engine installation is successful by running the hello-world image.
sudo docker run hello-world
# verify docker is up and running
sudo service docker status
# Can we stop and start ok?
sudo service docker stop
# always get this warning
Warning: Stopping docker.service, but it can still be activated by:
  docker.socket
sudo service docker start

# run test image
sudo docker run hello-world

https://docs.docker.com/engine/install/linux-postinstall/
sudo groupadd docker # group already exists
sudo usermod -aG docker $USER
# activate new group
newgrp docker 
# verify without sudo
docker run hello-world

# if error
https://askubuntu.com/questions/747778/docker-warning-config-json-permission-denied
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "/home/$USER/.docker" -R

The newgrp utility creates a new shell execution environment with a new real and effective group identification. Of the attributes listed in Shell ...

Note: Make sure logout and login again after adding local user to docker group

# Verify the Docker version by executing following,

docker version

# Verify docker daemon service status, run below systemctl command
sudo service docker status
sudo systemctl status docker

# verify docker compose plugin is working
https://docs.docker.com/compose/install/linux/
docker compose version
response: Docker Compose version v2.10.2

# Test Docker Compose Installation
To test docker compose, let’s try to deploy WordPress using compose file. Create a project directory ‘wordpress’ using mkdir command.

cd ~
mkdir wordpress ; cd wordpress

Create a docker-compose.yaml file with following content.

nvim docker-compose.yaml
version: '3.3'

services:
   db:
     image: mysql:latest
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: sqlpass@123#
       MYSQL_DATABASE: wordpress_db
       MYSQL_USER: dbuser
       MYSQL_PASSWORD: dbpass@123#
   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     ports:
       - "8000:80"
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: dbuser
       WORDPRESS_DB_PASSWORD: dbpass@123#
       WORDPRESS_DB_NAME: wordpress_db
volumes:
    db_data: {}

Save and close the file.

# build and run
docker compose up