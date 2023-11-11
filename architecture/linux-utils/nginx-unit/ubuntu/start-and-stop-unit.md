# start unit from systemd
sudo systemctl status unit  
sudo systemctl start
sudo systemctl stop unit 
sudo systemctl restart unit 

sudo systemctl enable unit
sudo systemctl disable unit

sudo service unit restart # upstart is depreciated.
