https://www.plesk.com/blog/various/nginx-configuration-guide/#:~:text=Every%20NGINX%20configuration%20file%20will,interchangeably%20as%20blocks%20or%20contexts%20.

NGINX Configuration: Understanding Directives
Every NGINX configuration file will be found in the /etc/nginx/ directory, with the main configuration file located in /etc/nginx/nginx.conf .

NGINX configuration options are known as “directives”: these are arranged into groups, known interchangeably as blocks or contexts .

When a # appears before a line, these are comments and NGINX won’t interpret them. Lines that contain directives should end with a semicolon (;). If not, NGINX will be unable to load the configuration properly and report an error.

Below, we’ve included a shortened copy of the /etc/nginx/nginx.conf file included with installations from NGINX repositories. This file begins with four directives:

user

worker_processes

error_log

pid

These exist outside any particular context or block, and are said to be within the main context.

Additional directives are found within the events and http blocks, and these also exist within the main context.

File: /etc/nginx/nginx.conf

user nginx;
worker_processes 1;
error_log /var/log/nginx/error.log warn;
pid /var/run/nginx.pid;
events {
. . .
}
http {
. . .
}

What is the Http Block?
The http block includes directives for web traffic handling, which are generally known as universal . That’s because they get passed on to each website configuration served by NGINX.

File: /etc/nginx/nginx.conf
http {
include /etc/nginx/mime.types;
default_type application/octet-stream;
log_format main '$remote_addr - $remote_user [$time_local] "$request" '
'$status $body_bytes_sent "$http_referer" '
'"$http_user_agent" "$http_x_forwarded_for"';
access_log /var/log/nginx/access.log main;
sendfile on;
#tcp_nopush on;
keepalive_timeout 65;
#gzip on;
include /etc/nginx/conf.d/*.conf;
}

The application/octet-stream MIME type is used for unknown binary files. It preserves the file contents, but requires the receiver to determine file type, for example, from the filename extension. The Internet media type for an arbitrary byte stream is application/octet-stream .

What are Server Blocks?
The http block shown above features an include directive. This informs NGINX where website configuration files can be found.

When installing from NGINX’s official repository, the line will read include /etc/nginx/conf.d/*.conf; just as you can see in the http block placed above. Every website hosted with NGINX should feature a unique configuration file in /etc/nginx/conf.d/, and the name will be formatted as example.com.conf.Those sites that have been disabled — not served by NGINX — should be titled example.com.conf.disabled.

When installing NGINX from the Ubuntu or Debian repositories, the line will read: include /etc/nginx/sites-enabled/*;. The ../sites-enabled/ folder will include symlinks to the site configuration files located within /etc/nginx/sites-available/. You can disable sites within sites-available if you take out the symlink to sites-enabled.

According to the installation source, an illustrative configuration file can be found at /etc/nginx/conf.d/default.conf or etc/nginx/sites-enabled/default.

No matter the installation source, though, server configuration files feature one or more server blocks for a site. As an example, let’s look at the below:

File: /etc/nginx/conf.d/example.com.conf
server {
listen 80 default_server;
listen [::]:80 default_server;
server_name example.com www.example.com;
root /var/www/example.com;
index index.html;
try_files $uri /index.html;
}

What are Listening Ports?
The listen directive informs NGINX of the hostname/IP and TCP port, so it recognizes where it must listen for HTTP connections.
The argument default_server means that this virtual host will be answering requests on port 80 which don’t match the listen statement of a separate virtual host. When it comes to the second statement, this will listen over IPv6 and demonstrate similar behavior.

What is Name-based Virtual Hosting?
The server_name directive enables a number of domains to be served from just one IP address, and the server will determine which domain it will serve according to the request header received.

Generally, you should create one file for each site or domain you wish to host on your server. Let’s delve into some examples:

Process requests for example.com and www.example.com:

The server_name directive can utilize wildcards. *.example.com and .example.com tell the server to process requests for all example.com subdomains:

File: /etc/nginx/conf.d/example.com.conf

server_name *.example.com;

server_name .example.com;

Process requests for all domain names starting with example.:

File: /etc/nginx/conf.d/example.com.conf

server_name example.*;

With NGINX, you can define server names that are invalid domain names: it utilizes the name from the HTTP header to answer requests regardless of whether the domain name is valid or invalid.

You may find non-domain hostnames helpful if your server is on a LAN or you know all the clients likely to make requests on the server. This encompasses front-end proxy servers with /etc/hosts entries set up for the IP address NGINX is listening on.

