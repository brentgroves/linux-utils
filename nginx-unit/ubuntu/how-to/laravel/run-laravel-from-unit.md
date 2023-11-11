https://unit.nginx.org/howto/laravel/
pushd ~/src/linux-utils/nginx-unit/ubuntu/how-to/laravel

# start unit
sudo systemctl status unit # systemd 
sudo systemctl start unit
sudo systemctl start/stop/restart unit # systemd 
sudo systemctl enable/disable unit
sudo service unit restart # upstart is depreciated.

https://laravel.com/docs/8.x/deployment#server-requirements
https://unit.nginx.org/howto/laravel/
To run apps based on the Laravel framework using Unit:
Install Unit with a PHP language module.
Install and configure Laravel’s prerequisites.
Create a Laravel project. For our purposes, the path is /path/to/app/:
composer create-project laravel/laravel app
Run the following command so Unit can access the application directory:

sudo chown -R root:root app
sudo cp -R app /usr/share/doc/unit-php/examples
sudo chmod -R 777 /usr/share/doc/unit-php/examples/app
Note
The unit:unit user-group pair is available only with official packages, Docker images, and some third-party repos. Otherwise, account names may differ; run the ps aux | grep unitd command to be sure.

Upload the updated configuration. Assuming the JSON above was added to config.json:

sudo curl -X PUT --data-binary @unit.config.laravel --unix-socket /var/run/control.unit.sock http://localhost/config
curl -x localhost
curl -X PUT --data-binary @config.json --unix-socket \
       /path/to/control.unit.sock http://localhost/config/
