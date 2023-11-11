https://unit.nginx.org/howto/samples/
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