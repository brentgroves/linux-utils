https://github.com/FiloSottile/mkcert

# home
openssl version                                                
OpenSSL 1.1.1u  30 May 2023


# this process worked on my home system
https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-22-04

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-20-04

Before starting this tutorial, you’ll need the following:

Access to a Ubuntu 22.04 server with a non-root, sudo-enabled user. Our Initial Server Setup with Ubuntu 22.04 guide can show you how to create this account.

You will also need to have Apache installed. You can install Apache using apt. First, update the local package index to reflect the latest upstream changes:

sudo apt update
Then, install the apache2 package:

sudo apt install apache2
And finally, if you have a ufw firewall set up, open up the http and https ports:

# i skipped this step
sudo ufw allow "Apache Full"

Step 1 — Enabling mod_ssl
Before you can use any TLS certificates, you’ll need to first enable mod_ssl, an Apache module that provides support for SSL encryption.

Enable mod_ssl with the a2enmod command:

sudo a2enmod ssl
See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
To activate the new configuration, you need to run:
systemctl restart apache2

# Restart Apache to activate the module:
sudo systemctl restart apache2

Now that Apache is ready to use encryption, we can move on to generating a new TLS certificate. The certificate will store some basic information about your site, and will be accompanied by a key file that allows the server to securely handle encrypted data.

We can create the TLS key and certificate files with the openssl command:

# create certs and key
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt

notes  
- stored these certs in /home/brent/src/reports/.devcontainer/dockerfiles/httpd/certs-tutorial with CN = moto.busche-cnc.com
- -nodes: This tells OpenSSL to skip the option to secure our certificate with a passphrase. We need Apache to be able to read the file, without user intervention, when the server starts up. A passphrase would prevent this from happening, since we would have to enter it after every restart.
# copy certs and key
pushd /home/brent/src/reports/.devcontainer/dockerfiles/httpd/certs
sudo cp apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt
sudo cp apache-selfsigned.key /etc/ssl/private/apache-selfsigned.key
sudo chmod +r /etc/ssl/private/apache-selfsigned.key

# add certs to trust store
sudo apt-get install -y ca-certificates
sudo cp apache-selfsigned.crt /usr/local/share/ca-certificates
sudo update-ca-certificates
pushd /home/brent/src/reports/volume/pki
https://superuser.com/questions/1717914/make-chrome-trust-the-linux-system-certificate-store-or-select-certificates-via
/home/brent/src/reports/.devcontainer/dockerfiles/httpd/certs
change cert name in script.
./add-trust-store.sh

# create config for virtual host
Open a new file in the /etc/apache2/sites-available directory:
sudo nvim /etc/apache2/sites-available/moto.busche-cnc.com.conf

Home system:
<VirtualHost moto.busche-cnc.com:443>
   ServerName moto.busche-cnc.com
   DocumentRoot /var/www/moto.busche-cnc.com

   SSLEngine on
   SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
   SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>
<VirtualHost moto.busche-cnc.com:80>
	ServerName moto.busche-cnc.com
	Redirect / https://moto.busche-cnc.com/
</VirtualHost>

# did not work or only for curl localhost
<VirtualHost 10.1.1.83:443>
   ServerName moto.busche-cnc.com
   DocumentRoot /var/www/moto.busche-cnc.com

   SSLEngine on
   SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
   SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>

- note
the following file has <VirtualHost *:80>
/etc/apache2/sites-available/000-default.conf
so if we want a specific config file to be used we can add <VirtualHost ip-address:80> to our site config.

Be sure to update the ServerName line to however you intend to address your server. This can be a hostname, full domain name, or an IP address. Make sure whatever you choose matches the Common Name you chose when making the certificate.
The remaining lines specify a DocumentRoot directory to serve files from, and the TLS options needed to point Apache to our newly-created certificate and key.

sudo ls /etc/apache2/sites-enabled                         
000-default.conf  moto.busche-cnc.com.conf

# create document root
Now let’s create our DocumentRoot and put an HTML file in it just for testing purposes:
sudo mkdir /var/www/moto.busche-cnc.com

Open a new index.html file with your text editor:
sudo nvim /var/www/moto.busche-cnc.com/index.html
Paste the following into the blank file:
/var/www/moto.busche-cnc.com/index.html
<h1>it worked!</h1>
This is not a full HTML file, of course, but browsers are lenient and it will be enough to verify our configuration.

# enable sites
Save and close the file Next, we need to enable the configuration file with the a2ensite tool:
sudo a2ensite 000-default.conf
sudo a2ensite moto.busche-cnc.com.conf
# test config
Next, let’s test for configuration errors:
sudo apache2ctl configtest
If everything is successful, you will get a result that looks like this:
Output
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
Syntax OK
The first line is a message telling you that the ServerName directive is not set globally. If you want to get rid of that message, you can set ServerName to your server’s domain name or IP address in /etc/apache2/apache2.conf. This is optional as the message will do no harm.
- note 
If you include a fully-qualified domain name in the certificate, it must match the CN=common_name. The attribute name “CN” is case insensitive (it can be “CN”, “cn” or “Cn”), but the attribute value for the common name is case sensitive.
at work hostnamectl has:  Static hostname: moto.BUSCHE-CNC.com
but my certificate is CN in all lower case?

If your output has Syntax OK in it, your configuration file has no syntax errors. We can safely reload Apache to implement our changes:
sudo systemctl reload apache2

sudo netstat -plunt |grep ":80"  
tcp6       0      0 :::80                   :::*                    LISTEN      903134/apache2  
sudo netstat -plunt |grep ":443"  
tcp6       0      0 :::443                  :::*                    LISTEN      903134/apache2

https://httpd.apache.org/docs/2.4/vhosts/examples.html
https://www.itsolutionstuff.com/post/how-to-check-apache-access-error-log-files-in-ubuntu-serverexample.html
cat /var/log/apache2/error.log
# moto at work 
[Thu Aug 17 16:41:19.458839 2023] [mpm_prefork:notice] [pid 903134] AH00171: Graceful restart requested, doing restart
[Thu Aug 17 16:41:19.494430 2023] [ssl:warn] [pid 903134] AH01906: moto.busche-cnc.com:443:0 server certificate is a CA certificate (BasicConstraints: CA == TRUE !?)
[Thu Aug 17 16:41:19.494658 2023] [mpm_prefork:notice] [pid 903134] AH00163: Apache/2.4.52 (Ubuntu) OpenSSL/3.0.2 configured -- resuming normal operations
[Thu Aug 17 16:41:19.494667 2023] [core:notice] [pid 903134] AH00094: Command line: '/usr/sbin/apache2'
# moto at home
[Wed Aug 16 13:19:14.444241 2023] [mpm_event:notice] [pid 156193:tid 140270383179648] AH00493: SIGUSR1 received.  Doing graceful restart
[Wed Aug 16 13:19:14.464126 2023] [ssl:warn] [pid 156193:tid 140270383179648] AH01906: moto.busche-cnc.com:443:0 server certificate is a CA certificate (BasicConstraints: CA == TRUE !?)
[Wed Aug 16 13:19:14.464268 2023] [mpm_event:notice] [pid 156193:tid 140270383179648] AH00489: Apache/2.4.52 (Ubuntu) OpenSSL/3.0.2 configured -- resuming normal operations
[Wed Aug 16 13:19:14.464275 2023] [core:notice] [pid 156193:tid 140270383179648] AH00094: Command line: '/usr/sbin/apache2'
[Wed Aug 16 20:16:32.824403 2023] [mpm_event:notice] [pid 156193:tid 140270383179648] AH00492: caught SIGWINCH, shutting down gracefully

- note 
I did not touch this file at home.
https://exampleconfig.com/view/apache-ubuntu20-04-etc-apache2-ports-conf
sudo nvim /etc/apache2/ports.conf
ports.conf
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80

<IfModule ssl_module>
	Listen 443
</IfModule>

<IfModule mod_gnutls.c>
	Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

cat /var/log/apache2/error.log 
[Thu Aug 17 16:14:59.574435 2023] [ssl:warn] [pid 903133] AH01906: moto.busche-cnc.com:443:0 server certificate is a CA certificate (BasicConstraints: CA == TRUE !?)
[Thu Aug 17 16:14:59.603507 2023] [ssl:warn] [pid 903134] AH01906: moto.busche-cnc.com:443:0 server certificate is a CA certificate (BasicConstraints: CA == TRUE !?)
[Thu Aug 17 16:14:59.603604 2023] [core:warn] [pid 903134] AH00098: pid file /var/run/apache2/apache2.pid overwritten -- Unclean shutdown of previous Apache run?
[Thu Aug 17 16:14:59.607588 2023] [mpm_prefork:notice] [pid 903134] AH00163: Apache/2.4.52 (Ubuntu) OpenSSL/3.0.2 configured -- resuming normal operations
[Thu Aug 17 16:14:59.607610 2023] [core:notice] [pid 903134] AH00094: Command line: '/usr/sbin/apache2'


- note these certs are stored in the submodule git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/pki
pushd ~/src/reports/volume/pki

# https://hub.docker.com/_/httpd?tab=description
# https://www.docker.com/blog/how-to-use-the-apache-httpd-docker-official-image/
# https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-22-04#step-5-setting-up-virtual-hosts-recommended
https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-22-04
sudo apt install apache2


# moto at home
hostnamectl
 Static hostname: moto.busche-cnc.com
       Icon name: computer-desktop
         Chassis: desktop
      Machine ID: 8cb6c4b980f340da8ed9465fda465b6e
         Boot ID: 033783a191084ceb892b6a55d5ac25c0
Operating System: Ubuntu 22.04.3 LTS              
          Kernel: Linux 5.15.0-79-generic
    Architecture: x86-64
 Hardware Vendor: To Be Filled By O.E.M.
  Hardware Model: To Be Filled By O.E.M.

sudo systemctl status apache2

● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2023-08-17 18:31:42 EDT; 2s ago
       Docs: https://httpd.apache.org/docs/2.4/
    Process: 1924371 ExecStart=/usr/sbin/apachectl start (code=exited, status=0/SUCCESS)
   Main PID: 1924375 (apache2)
      Tasks: 55 (limit: 28337)
     Memory: 6.9M
        CPU: 38ms
     CGroup: /system.slice/apache2.service
             ├─1924375 /usr/sbin/apache2 -k start
             ├─1924380 /usr/sbin/apache2 -k start
             └─1924381 /usr/sbin/apache2 -k start

# moto at home
curl -H 'Cache-Control: no-cache' http://moto.busche-cnc.com
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>302 Found</title>
</head><body>
<h1>Found</h1>
<p>The document has moved <a href="https://moto.busche-cnc.com/">here</a>.</p>
<hr>
<address>Apache/2.4.52 (Ubuntu) Server at moto.busche-cnc.com Port 80</address>
</body></html>

curl -H 'Cache-Control: no-cache' https://moto.busche-cnc.com
curl: (60) SSL certificate problem: self signed certificate
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.

Step 4 — Managing the Apache Process
Now that you have your web server up and running, let’s review some basic management commands using systemctl.

To stop your web server, run:

sudo systemctl stop apache2
To start the web server when it is stopped, run:

sudo systemctl start apache2
To stop and then start the service again, run:

sudo systemctl restart apache2
If you are simply making configuration changes, Apache can often reload without dropping connections. To do this, use the following command:

sudo systemctl reload apache2
By default, Apache is configured to start automatically when the server boots. If this is not what you want, disable this behavior by running:

sudo systemctl disable apache2
To re-enable the service to start up at boot, run:

sudo systemctl enable apache2
Apache will now start automatically when the server boots again.