https://phoenixnap.com/kb/linux-mount-cifs
sudo apt-get update
sudo apt-get install cifs-utils
sudo mkdir /mnt/winshare
sudo mount -t cifs //alb-utl.busche-cnc.com/Downloads /mnt/winshare -o username=bgroves
