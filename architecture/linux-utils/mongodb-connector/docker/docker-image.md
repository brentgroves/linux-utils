pushd ~/src/linux-utils/mongodb-connector/docker

docker build -t brent/mongobi .
docker run --rm -it brent/mongobi /bin/bash

https://www.mongodb.com/docs/bi-connector/master/tutorial/install-bi-connector-debian/
Prerequisites
OpenSSL installed on your host.

To verify OpenSSL is installed on your system, run the following command:

dpkg -l | grep -i openssl

https://idroot.us/install-openssl-ubuntu-20-04/

Install OpenSSL on Ubuntu 20.04 LTS Focal Fossa
Step 1. First, make sure that all your system packages are up-to-date by running the following apt commands in the terminal.

sudo apt update
sudo apt upgrade
sudo apt install build-essential checkinstall zlib1g-dev
