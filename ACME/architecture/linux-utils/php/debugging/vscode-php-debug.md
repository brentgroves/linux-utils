https://stackify.com/php-debugging-guide/
https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug
Xdebug: [Step Debug] Could not connect to debugging client. Tried: localhost:9000 (through xdebug.client_host/xdebug.client_port).
Installation
Install the extension: Press F1, type ext install php-debug.
This extension is a debug adapter between VS Code and Xdebug by Derick Rethans. Xdebug is a PHP extension (a .so file on Linux and a .dll on Windows) that needs to be installed on your server.

php -i > phpinfo.txt
xclip -selection clipboard -i < phpinfo.txt 
paste the output into the web page
https://xdebug.org/wizard
Instead of compiling xdebug like the wizard suggested I chose to use the following instructions to add a PPA that manages multiple installation of PHP and xdebug.
https://xdebug.org/docs/install#configure-php
Ubuntu (Ondřej Surý's PPA):
sudo apt-get install php7.4-xdebug, or
sudo apt-get install php8.0-xdebug, or
sudo apt-get install php8.1-xdebug
sudo apt-get install php8.2-xdebug

https://xdebug.org/docs/install#configure-php
Find out which PHP ini file to modify.
php -i


php -v
PHP 8.2.6 (cli) (built: May 12 2023 06:24:00) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.2.6, Copyright (c) Zend Technologies
    with Zend OPcache v8.2.6, Copyright (c), by Zend Technologies
    with Xdebug v3.2.0, Copyright (c) 2002-2022, by Derick Rethans

notice that xdebug is already present.
As part of apt-get install the file 20-xdebug.ini was configured with the following option.
sudo nvim /etc/php/8.2/cli/conf.d/20-xdebug.ini
zend_extension=xdebug.so
https://github.com/brentgroves/php-test/pull/1#issue-1722885101
But we need to add the following 2 options to launch xdebug when a php script is ran on port 9003
xdebug.mode = debug
xdebug.start_with_request = yes

# pull test code
cd ~/src
git clone git@github.com:brentgroves/php-test.git
pushd ~/src/php-test

# from vscode
select run and debug icon
select gear icon
and select add config for php-test
open index.php 
## for cli debugging
select debug current php file option from debug menu
add a breakpoint and press F5 to start debugging
## for browser debuggin
Browser Extension Initiation #
The extensions are:
Xdebug Helper for Firefox (source).
[Xdebug Helper for Chrome (source).](https://chrome.google.com/extensions/detail/eadndfjplgieldjbigjakmdgkmoaaaoc)
XDebugToggle for Safari (source).
Each extension adds an icon to your browser where you can select which functionality you want to trigger. Xdebug will continue to start debugging for every request as long as the debug toggle has been enabled.

https://xdebug.org/docs/step_debug

# Questions


