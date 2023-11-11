https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver16
sudo apt-get update
sudo su
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
#Download appropriate package for the OS version
#Choose only ONE of the following, corresponding to your OS version


curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list

exit
sudo apt-get update
DEBIAN_FRONTEND=noninteractive ACCEPT_EULA=Y sudo apt-get install -y msodbcsql17 
DEBIAN_FRONTEND=noninteractive ACCEPT_EULA=Y sudo apt-get install -y mssql-tools 
DEBIAN_FRONTEND=noninteractive ACCEPT_EULA=Y sudo apt-get install -y msodbcsql18 
DEBIAN_FRONTEND=noninteractive ACCEPT_EULA=Y sudo apt-get install -y mssql-tools18 
sudo apt-get install -y unixodbc-dev

verify if unixODBC is installed 
which odbcinst 
which isql 
conda install -c conda-forge unixodbc # I don't know if we need this it is not in the dockerfile
# maybe we only need it if we don't use DSN

My dotfiles has this in the path already.
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
source ~/.bashrc

cd ~/src
git clone git@github.com:brentgroves/linux-utils.git 
cd linux_utils/odbc
Dont need to extract driver
tar -xf PROGRESS_DATADIRECT_OPENACCESS_OAODBC_8.1.0.HOTFIX_LINUX_64.tar
install ksh already installed in 22.04
sudo su
ksh unixpi.ksh  
Press the space bar around 50 times to get through the license.
Install will ask you for the following which I got from the linux drivers from Plex. (KEY = 35057920,COMPANY = BPG-IN,SERIAL = 004193623) 
This is how the docker file does it. 
message = '\nYES\n\n\n35057920\nBPG-IN\n004193623\n35057920\n\n'
run( [ 'ksh', 'unixpi.ksh' ], input=message.encode() )
exit out of root.
then update the /etc/odbc.ini and /usr/oaodbc81/odbc64.ini files with what is stored in the ETL-Pod dockerfile 
The dockerfile looks like this:

cd ~/src/linux-utils/odbc
sudo cp ./odbc.ini /etc/
cat /etc/odbc.ini
odbc64.ini already had stuff in it but i deleted it and copied the file in this directory
which contained the original content plus Plex and PlexTest entries.
sudo rm /usr/oaodbc81/odbc64.ini
sudo cp ./odbc64.ini /usr/oaodbc81/
cat /usr/oaodbc81/odbc64.ini 
The environment variables need to be set before any connection will work.
The docker file does this:
ENV LD_LIBRARY_PATH="/usr/oaodbc81/lib64"
ENV OASDK_ODBC_HOME="/usr/oaodbc81/lib64"
ENV ODBCINI="/usr/oaodbc81/odbc64.ini"
But these entries are already set in my dotfile.
You can:
source oaodbc64.sh script which exports common unixODBC environmental variables if the dotfiles have
not been installed yet.  
run odbcinst -j to verify the environmental variables were set.
Should look like this:
unixODBC 2.3.9
DRIVERS............: /etc/odbcinst.ini
SYSTEM DATA SOURCES: /etc/odbc.ini
FILE DATA SOURCES..: /etc/ODBCDataSources
USER DATA SOURCES..: /usr/oaodbc81/odbc64.ini
SQLULEN Size.......: 8
SQLLEN Size........: 8
SQLSETPOSIROW Size.: 8

cd ~/src/linux-utils/odbc
conda activate reports
run "python odbc-dsn-plextest.py" to verify connection is ok.  

