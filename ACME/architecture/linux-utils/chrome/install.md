https://linuxconfig.org/how-to-install-google-chrome-web-browser-on-ubuntu-22-04-jammy-jellyfish
First, use the wget command to download the Google Chrome installer.
cd ~/Downloads 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
Then, we can use the apt command and root permissions to install Google Chrome.
sudo dpkg -i google-chrome-stable_current_amd64.deb
got a permission error when installing the .deb file with apt
so use dpkg instead.

You will now find Google Chrome accessible under the Activities menu. Just search for it by typing “chrome.” You can right click this icon and add it to your quick launch bar if you want.
How to update Google Chrome on Ubuntu 22.04
Installing Chrome will also add the repository to your package manager. Use the following apt commands to keep Chrome up to date on your system.

sudo apt update
sudo apt install google-chrome-stable
It should be also mentioned that execution of the following two commands will upgrade all packages in your Ubuntu 22.04 Linux system as well as it will also update the Chrome browser package.

$ sudo apt update
google-chrome