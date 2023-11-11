Sets a file name that will be appended after a URI that ends with a slash, in the value of the $fastcgi_script_name variable. For example, with these settings

fastcgi_index index.php;
fastcgi_param SCRIPT_FILENAME /home/www/scripts/php$fastcgi_script_name;
and the “/page.php” request, the SCRIPT_FILENAME parameter will be equal to “/home/www/scripts/php/page.php”, and with the “/” request it will be equal to “/home/www/scripts/php/index.php”.