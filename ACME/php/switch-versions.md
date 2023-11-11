https://tecadmin.net/how-to-install-php-on-ubuntu-22-04/

Switch Default PHP Version for CLI
You can use an `update-alternatives` command to set the default PHP version. Use this tutorial to read more details about switching the PHP version for CLI and Apache.

sudo update-alternatives --config php
There are 4 choices for the alternative php (providing /usr/bin/php).

  Selection    Path             Priority   Status
------------------------------------------------------------
* 0            /usr/bin/php8.1   81        auto mode
  1            /usr/bin/php5.6   56        manual mode
  2            /usr/bin/php7.4   74        manual mode
  3            /usr/bin/php8.0   80        manual mode
  4            /usr/bin/php8.1   81        manual mode
  5            /usr/bin/php8.2   82        manual mode

Press  to keep the current choice[*], or type selection number: 2
The above output shows all the installed PHP versions on your system. Selection number 2 set PHP 7.4 as the default PHP version for the command line.

