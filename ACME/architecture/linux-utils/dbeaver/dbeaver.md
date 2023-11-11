sudo apt update
sudo apt -y install default-jdk
https://pq.hosting/en/help/instructions/407-ustanovka-dbeaver-v-ubuntu-2204.html
$ java -version
openjdk version "11.0.18" 2023-01-17
OpenJDK Runtime Environment (build 11.0.18+10-post-Ubuntu-0ubuntu120.04.1)
OpenJDK 64-Bit Server VM (build 11.0.18+10-post-Ubuntu-0ubuntu120.04.1, mixed mode, sharing)

Ubuntu PPA:
You can use PPA repository to easily install/upgrade DBeaver on Debian Linuxes. Mostly it is the same as regular Debian repo but it is hosted on Launchpad.

sudo add-apt-repository ppa:serge-rider/dbeaver-ce
sudo apt-get update
# install will upgrade
sudo apt-get install dbeaver-ce

# another way to install dbeaver
sudo  wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt-get update && sudo apt-get install dbeaver-ce

sudo apt update
sudo apt install dbeaver-ce
create dbeaver project to point to mobexsql repository
cd ~/src
git clone git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/mobexsql
launch dbeaver
goto projects tab and create the mobexsql project.
create the project in the /home/brent/src/mobexsql

dark theme
windows/preferences/user interfaces/appearance

# another way to install
curl -fsSL https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/dbeaver.gpg
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list

sudo apt update && sudo apt install dbeaver-ce

Install DBeaver version can be checked using:

$ apt policy dbeaver-ce
dbeaver-ce:
  Installed: 23.0.1
  Candidate: 23.0.1
  Version table:
 *** 23.0.1 500
        500 https://dbeaver.io/debs/dbeaver-ce  Packages
        100 /var/lib/dpkg/status
https://computingforgeeks.com/install-and-configure-dbeaver-on-ubuntu-debian/
