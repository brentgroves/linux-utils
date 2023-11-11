https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/Nginx-PHP-FPM-config-example

Why is Nginx, PHP and fastCGI so popular?
Nginx is the DevOps community’s most beloved http web server. And developers love the PHP programming language because it enables them to quickly build and deploy interactive websites.

As such, it’s no wonder that so many sys admins need to configure Nginx, PHP and PHP-FPM on both Linux and Windows servers.

This quick tutorial shows you how to setup PHP and Nginx on Ubuntu Linux with the fastCGI process manager (PHP-FPM) configured as Nginx’s PHP engine.

How to setup Nginx, PHP and PHP-FPM
To setup and configure fastCGI (FPM), PHP, and Nginx on Ubuntu Linux, follow these steps:

Perform an apt-get update to ensure access to the latest packages.
Install Nginx on Ubuntu.
Install the php-fpm for Nginx package.
Edit the server’s default config file to support PHP in Nginx.
Restart the PHP configured Nginx server.
Add a PHP file to Nginx’s html directory.
Test the PHP, Nginx and PHP-FPM configuration.
