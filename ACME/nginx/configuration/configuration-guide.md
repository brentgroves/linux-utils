https://www.plesk.com/blog/various/nginx-configuration-guide/

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

What are Location Blocks?
NGINX’s location setting helps you set up the way in which NGINX responds to requests for resources inside the server. As the server_name directive informs NGINX how it should process requests for the domain, location directives apply to requests for certain folders and files (e.g. http://example.com/blog/.) .

Let’s consider a few examples:

File: /etc/nginx/sites-available/example.com

location / { }

location /images/ { }

location /blog/ { }

location /planet/ { }

location /planet/blog/ { }

These locations are literal string matches and match any part of an HTTP request following the host segment:

Request: http://example.com/

Returns: Let’s assume there’s a server_name entry for example.com. In this case, the location / directive determines what occurs with this request.

With NGINX, requests are always fulfilled with the most specific match possible:

Request: http://example.com/planet/blog or http://example.com/planet/blog/about/

Returns: This will be fulfilled by the location /planet/blog directive as it’s more specific, despite location /planet being a match too.

File: /etc/nginx/sites-available/example.com

location ~ IndexPage\.php$ { }

location ~ ^/BlogPlanet(/|/index\.php)$ { }

When location directives are followed by a ~ (tilde), NGINX will perform a regular expression match, which is always case-sensitive.

For example, IndexPage.php would be a match with the first of the above examples, while indexpage.php wouldn’t.

In the second example, the regular expression ^/BlogPlanet(/|/index\.php)$ { } would match requests for /BlogPlanet/ and /BlogPlanet/index.php but not /BlogPlanet, /blogplanet/, or /blogplanet/index.php. NGINX utilizes Perl Compatible Regular Expressions (PCRE).

What if you prefer matches to be case-insensitive? Well, you should use a tilde followed closely by an asterisk: ~*. You can see the above examples define that NGINX should process requests ending in a certain file extension: the first example determines that files ending in .pl, PL, .cgi, .perl, .Perl, .prl, and .PrL (as well as others) will all be a match for the request.

File: /etc/nginx/sites-available/example.com

location ^~ /images/IndexPage/ { }

location ^~ /blog/BlogPlanet/ { }

When you add a caret and a tilde (^~) to location directives, you’re informing NGINX that, should it match a particular string, it should stop searching for more specific matches and utilize these directives here instead.

Beyond this, these directives function as the literal string matches do in the first group. Even if a more specific match comes along at a later point, the settings will be utilized if a request is a match for one of these directives.

Now, let’s look at additional details on location directive processing.

File: /etc/nginx/sites-available/example.com

location = / { }

So, for example, the last example will be a match for http://example.com only, as opposed to http://example.com/index.html. If you use exact matches, you can enhance the speed of request times moderately. This can prove beneficial if certain requests are especially popular.

The processing of directives will follow this sequence flow:

Exact string matches will be processed first: NGINX stops searching if a match is located and will fulfill the request.
Any remaining literal string directives will be processed next. NGINX will stop and fulfill a request if it finds a match using the ^~ argument. If not, NGINX will continue processing of location directives.
Each location directive with a regular expression (~ and ~*) will get processed next. If a regular expression is a match for the request, NGINX will end its search and fulfill the request.
Finally, if there are no matching regular expressions, that literal string match which is most specific will be used.

Be sure that every file and folder found under a domain is a match for one or more location directives.

Nested location blocks are not recommended and not supported.

How to Use Location Root and Index
The location setting is another variable with its own arguments block.

When NGINX has identified the location directive that is the best match for a specific request, its response will be based on the associated location directive block’s contents. So, for instance:

File: /etc/nginx/sites-available/example.com

location / {

root html;

index index.html index.htm;

}

We can see, in this example, that the document root is based in the html/ directory. Under the NGINX default installation prefix, the location’s full path is /etc/nginx/html/.

We can see, in this example, that the document root is based in the html/ directory. Under the NGINX default installation prefix, the location’s full path is /etc/nginx/html/.

Request: http://example.com/blog/includes/style.css

Returns: NGINX will try to serve the file found at /etc/nginx/html/blog/includes/style.css

Please note:

Absolute paths for the root directive can be used if you wish. The index variable informs NGINX which file it should serve when or if none are specified.

So, for instance:

Request: http://example.com

Returns: NGINX will try to serve the file found at /etc/nginx/html/index.html.

When a number of files are specified for the index directive, the list will be processed in order and NGINX will fulfill the request with the first file found to exist. If index.html can’t be located in the relevant directory, index.htm will be utilized instead. A 404 message will be delivered in the event that neither exists at all.

Let’s consider a more complicated example that showcases a number of location directives for a server responding to the example domain:

File: /etc/nginx/sites-available/example.com location directive

location / {

root /srv/www/example.com/public_html;

index index.html index.htm;

}

location ~ \.pl$ {

gzip off;

include /etc/nginx/fastcgi_params;

fastcgi_pass unix:/var/run/fcgiwrap.socket;

fastcgi_index index.pl;

fastcgi_param SCRIPT_FILENAME /srv/www/example.com/public_html$fastcgi_script_name;

}

Here, we can see that the second location block handles all requests for resources ending in a .pl extension, and it specifies a fastcgi handler for them. NGINX will use the first location directive otherwise.

Resources are found on the file system at /srv/www/example.com/public_html/. When no exact file names are defined in the request, NGINX will search for the index.html or index.htm file and provide it. A 404 error message will be returned if zero index files are located.

Let’s consider what takes place during a number of example requests:

Request: http://example.com/

Returns: /srv/www/example.com/public_html/index.html if this exists. Otherwise, it will serve /srv/www/example.com/public_html/index.htm. And if both of these don’t exist, a 404 error will be provided.

Request: http://example.com/blog/

Returns: /srv/www/example.com/public_html/blog/index.html if this exists. If the file can’t be found because it doesn’t exist, a /srv/www/example.com/public_html/blog/index.htm will be served. If neither exists, NGINX will return a 404 error.

Request: http://example.com/tasks.pl

Returns: NGINX will take advantage of the FastCGI handler to execute the file found at /srv/www/example.com/public_html/tasks.pl and return the relevant result.

Request: http://example.com/username/roster.pl

Returns: NGINX will utilize the FastCGI handler to execute the file found at /srv/www/example.com/public_html/username/roster.pl and return the relevant result.

This ends our guide on how to configure NGINX. We hope it helps you get started and set up in next to no time!

For getting the list of all running nginx processes, the ps utility may be used, for example, in the following way:

ps -ax | grep nginx
For more information on sending signals to nginx, see Controlling nginx.

Configuration File’s Structure
nginx consists of modules which are controlled by directives specified in the configuration file. Directives are divided into simple directives and block directives. A simple directive consists of the name and parameters separated by spaces and ends with a semicolon (;). A block directive has the same structure as a simple directive, but instead of the semicolon it ends with a set of additional instructions surrounded by braces ({ and }). If a block directive can have other directives inside braces, it is called a context (examples: events, http, server, and location).

Directives placed in the configuration file outside of any contexts are considered to be in the main context. The events and http directives reside in the main context, server in http, and location in server.

