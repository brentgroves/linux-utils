# the following link talks about the 2nd ssh service that will be started on port 1022 in case your ssh server does not upgrade properly.
https://jumpcloud.com/blog/how-to-upgrade-ubuntu-20-04-to-ubuntu-22-04

# install screen
https://askubuntu.com/questions/8884/whats-the-risk-of-upgrading-over-ssh#:~:text=It%20is%20not%20recommended%20to,started%20at%20port%20'9004'.

it will keep the upgrade process in case the ssh session is closed. 

@Marco-Ceppi 's solution is already integrated into do-release-upgrade.

When you run do-release-upgrade it starts a screen session automatically. If your ssh session gets disconnected, you can resume the installation. All you have to do is open a new ssh session, and run do-release-upgrade again. It will reconnect to your previous installation.

A second risk, pointed out by @sepp2k is that your sshd server might need to be upgraded, and it could perhaps not restart correctly. Therefore the upgrade program runs a second deamon, at the port specified. You should check your network configuration to make sure you have access through this port, before resuming.

Good luck.

Moreover, the screen-session do-release-upgrade starts by itself is run under the root account, so if your own screen-session crashes, you will be able to recover by running sudo screen -x, if (for some reason) the command do-release-upgrade doesn't recover it by itself, which seems to be common.

# login on to system to be upgraded
ssh brent@frt-ubu
# start a screen session
screen
# if ssh session is interrupted login again
ssh brent@frt-ubu
if that does not work try the alternate port: ssh brent@frt-ubu -p 1022
run do-release-upgrade again and it will reconnect to your previouse installation: do-release-upgrade
if that does not work you can try: sudo screen -x
# update the system
sudo apt-get install screen
sudo apt update
sudo apt upgrade -y
sudo apt autoremove
sudo reboot
screen
sudo apt install update-manager-core
sudo apt install ubuntu-release-upgrader-core
sudo do-release-upgrade -d
# verify version
lsb_release -a
# check kernel version
uname -mrs
it should be 5.15
# enable 3rd party repositories
ls -l /etc/apt/sources.list.d/
open each file and uncomment the line.
# remove unnecessary packages
sudo apt autoremove --purge


