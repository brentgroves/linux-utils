# Install Laravel on Ubuntu Using Composer

https://getcomposer.org/doc/00-intro.md
sudo apt install composer
Introduction#
Composer is a tool for dependency management in PHP. It allows you to declare the libraries your project depends on and it will manage (install/update) them for you.
With Composer installed, now we can install Laravel. To do this, run the following command:
pushd ~/src/
git clone git@github.com:brentgroves/laravel-test.git
cd laravel-test
composer create-project --prefer-dist laravel/laravel laravel-test


cd laravel-test
Using Laravel for Local Development
To develop applications locally, we can use PHP serve and specify the host and port of our server. To do this execute the commands following commands, and replace [IP] with your server IP, and [port] with the port you wish to use.

# start dbgpClient or VSCode
## dbgpClient
from another terminal run dbgpClient
Xdebug Simple DBGp client (0.5.0)
Copyright 2019-2020 by Derick Rethans

Waiting for debug server to connect on port 9003.
Connect from 127.0.0.1:59186
DBGp/1.0: Xdebug 3.2.0 — For PHP 8.2.6
Debugging file:///home/brent/src/laravel-test/laravel-test/artisan (ID: 1746143/)
## VSCode
open artisan file 
from debug dropdown select add configuration(laravel-test) 
this will generate the launch.json config file
now select the "Listen for Xdebug" option from the debug drop down menu
set a breakpoint in the artisan file.
now VSCode will be listening on port 9003 just like the dbgpClient program did.
from the terminal run "php artisan serve"
xdebug should stop execution at the breakpoint set from VSCode

# start php server
php artisan serve --host=[IP] --port=[port]

# dbgpClient
Connect from 127.0.0.1:59186
DBGp/1.0: Xdebug 3.2.0 — For PHP 8.2.6
Debugging file:///home/brent/src/laravel-test/laravel-test/artisan (ID: 1746143/)
# just run laravel app
(cmd) run
