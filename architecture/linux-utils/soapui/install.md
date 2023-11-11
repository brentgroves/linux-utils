https://www.soapui.org/getting-started/installing-soapui/installing-on-linux-or-unix/

# install needed package
sudo apt-get install libcanberra-gtk-module

# Installation
Download the install script from http://www.soapui.org/
cd ~/Downloads/
chmod +x SoapUI-x64-5.7.0.sh
./SoapUI-x64-5.7.0.sh

# install projects
cd ~/src
git clone git@github.com:brentgroves/PlexSoapUI.git 
# remove old projects
rm ~/soapui/*
# import projects
Import project PlexSoapProd-soapui-project.xml and PlexSoapTest-soapui-project.xml from repository     

