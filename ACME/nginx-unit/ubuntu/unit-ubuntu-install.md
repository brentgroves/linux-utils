https://unit.nginx.org/installation/
Issues: the directory tree of "root": "/usr/share/doc/unit-php/examples/phpinfo-app" had to be root:root to work.

Supported architectures: arm64, x86-64.

Download and save NGINX’s signing key:

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


sudo apt update
sudo apt install unit
sudo apt install unit-dev unit-php unit-python3.10 
sudo systemctl restart unit

The Python 3.10 module for NGINX Unit has been installed.
To check out the sample app, run these commands:
sudo systemctl status unit # systemd 
sudo systemctl start/stop/restart unit # systemd 
sudo systemctl enable/disable unit
sudo service unit restart # upstart is depreciated.
# runtime details
https://unit.nginx.org/installation/#ubuntu-2204
Control socket	/var/run/control.unit.sock
Log file	/var/log/unit.log
Non-privileged user and group	unit


pushd ~/src/linux-utils/nginx-unit/how-to
sudo curl -X PUT --data-binary @unit.config.python --unix-socket /var/run/control.unit.sock http://localhost/config
[sudo] password for brent: 
{
	"success": "Reconfiguration done."
}

curl http://localhost:8400/

sudo lsof -i -P -n | grep :80
sudo lsof -i -P -n | grep :8400

https://unit.nginx.org/installation/#ubuntu-2204
Issues: the directory tree of "root": "/usr/share/doc/unit-php/examples/phpinfo-app" had to be root:root to work.

pushd ~/src/linux-utils/nginx-unit/how-to
# start unit
sudo systemctl status unit # systemd 
sudo systemctl start/stop/restart unit # systemd 
sudo systemctl enable/disable unit
sudo service unit restart # upstart is depreciated.
# create index.php in /home/brent/src/linux-utils/nginx-unit/how-to/www

<?php echo "Hello, PHP on Unit!"; ?>

# change config
https://github.com/nginx/unit/issues/283
sudo curl -X PUT --data-binary @unit.config.php --unix-socket /var/run/control.unit.sock http://localhost/config
# output
{
	"success": "Reconfiguration done."
}

cat /var/log/unit.log
# get config
sudo curl --unix-socket /var/run/control.unit.sock http://localhost/config/


curl "http://www.example.com/?$RANDOM"
# test
curl http://localhost:8080