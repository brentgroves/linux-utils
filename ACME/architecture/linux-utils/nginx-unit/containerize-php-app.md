https://blog.castopod.org/containerize-your-php-applications-using-nginx-unit/

If you want your application to run in a single container, you will have to use a web server that embeds a PHP module. The most common solution is to use Apache with its PHP module, but it's not very efficient when facing a lot of requests (that's why Nginx was initially written, but it doesn't include a PHP module so you must use FastCGI). A new solution, Nginx Unit, came out in 2017, and it can be compiled with support for some languages such as PHP or Python.
Let's serve Castopod using Nginx Unit
Ok, so that being said, how can we serve a PHP application using Nginx Unit?

As an example, we will use Castopod.

The first step is to install Nginx Unit on your machine. You can take a look at the documentation. For example on Ubuntu (with root privileges):

curl --output /usr/share/keyrings/nginx-keyring.gpg https://unit.nginx.org/keys/nginx-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ kinetic unit" > /etc/apt/sources.list.d/unit.list
echo "deb-src [signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ kinetic unit" >> /etc/apt/sources.list.d/unit.list
apt update
apt install unit unit-php
systemctl restart unit

Verify that your server runs correctly:

curl --unix-socket /var/run/control.unit.sock http://localhost/status

You should have something like:

{
	"connections": {
		"accepted": 0,
		"active": 0,
		"idle": 0,
		"closed": 0
	},

	"requests": {
		"total": 0
	},

	"applications": {}
}
You will also have to grab a Castopod package here. You must of course install all the required extensions:

apt install php-gd php-exif php-curl php-intl php-mbstring php-mysqli

Now that Castopod is downloaded and the server is installed, let's set it up to serve Castopod. Nginx Unit is dynamically configured using a REST API so we will have to send requests to configure it (we can do this by using curl to send PUT requests with our configuration as JSON).

Add our PHP application:

curl -X PUT -d '{"castopod":{"type":"php","root":"/var/www/castopod/public","script":"index.php"}}' --unix-socket /var/run/control.unit.sock http://localhost/config/applications

This request just says to add a PHP application named "castopod" located at /var/www/castopod/public and to use the index.php script by default.

Then add the routes:

curl -X PUT -d '[{"action":{"share":"/var/www/castopod/public$uri","fallback":{"pass":"applications/castopod"}}}]' --unix-socket /var/run/control.unit.sock http://localhost/config/routes
This request says that when a request is received, we first try to serve the static file in /var/www/castopod/public pointed by the URI, if this file is not present then we pass the request to our previously defined "castopod" application.

Finally we add our listener:

curl -X PUT -d '{"*:8000":{"pass":"routes"}}' --unix-socket /var/run/control.unit.sock http://localhost/config/listeners
It says to listen on the port 8000 and to go through the routes (the only one we defined).

Then you can run:

curl --unix-socket /var/run/control.unit.sock http://localhost/config
You should have something like this:

{
	"listeners": {
		"*:8000": {
			"pass": "routes"
		}
	},

	"applications": {
		"castopod": {
			"type": "php",
			"root": "/var/www/castopod/public",
			"script": "index.php"
		}
	},

	"routes": [
		{
			"action": {
				"share": "/var/www/castopod/public$uri",
				"fallback": {
					"pass": "applications/castopod"
				}
			}
		}
	]
}
We can also summarize all these parameters in a single configuration file and send it to the control socket at once. For example in the config.json file:

{
  "listeners": {
    "*:8000": {
      "pass": "routes"
    }
  },
  "routes": [
    {
      "action": {
        "share": "/var/www/castopod/public$uri",
        "fallback": {
          "pass": "applications/castopod"
        }
      }
    }
  ],
  "applications": {
    "castopod": {
      "type": "php",
      "root": "/var/www/castopod/public/",
      "script": "index.php",
      "options": {
        "admin": {
          "file_uploads": "On",
          "memory_limit": "512M",
          "upload_max_filesize": "500M",
          "post_max_size": "512M",
          "max_execution_time": "300",
          "max_input_time": "300"
        }
      }
    }
  },
  "access_log": {
    "path": "/var/log/unit.log"
  },
  "settings": {
    "http": {
      "body_read_timeout": 300,
      "max_body_size": 536870912
    }
  }
}
And execute curl -X PUT --data-binary @config.json --unix-socket /var/run/control.unit.sock http://localhost/config/ to send it to the Nginx Unit control socket. I added a few directives to handle PHP configuration, HTTP timeout and maximum request size and access logs. You can refer to the documentation to see all the available directives and their meanings.

As usual, you will need to handle HTTPS with a reverse proxy, Nginx Unit can also handle that for you but you will need to generate the certificates on your own (using certbot for example).

Containerize Castopod with Nginx Unit
Nginx Unit is a good candidate to run PHP applications in docker containers without having to deploy both web server and FastCGI containers.

The Nginx team have already published images on the Docker Hub but there are not many PHP versions available, and they seem to quickly drop the support for older versions of PHP. You can also build Nginx Unit yourself with the desired version of PHP, here is an example of a Dockerfile with PHP 8.1 and a few extensions that you can adapt to fit your needs:

FROM docker.io/php:8.1-cli AS UNIT_BUILDER

ARG UNIT_VERSION=1.29.0

RUN apt-get update && \
    apt-get install -y libpcre2-dev git && \
    mkdir -p /usr/lib/unit/modules && \
    git clone https://github.com/nginx/unit.git && \
    cd unit && \
    git checkout $UNIT_VERSION && \
    ./configure --prefix=/usr --state=/var/lib/unit --control=unix:/var/run/control.unit.sock --log=/var/log/unit.log --user=www-data --group=www-data --tmp=/tmp --modules=/usr/lib/unit/modules && \
    ./configure php && \
    make && \
    make install


FROM docker.io/php:8.1-cli

COPY --from=UNIT_BUILDER /usr/sbin/unitd /usr/sbin/unitd
COPY --from=UNIT_BUILDER /usr/lib/unit/ /usr/lib/unit/

COPY entrypoint.sh /entrypoint.sh
COPY app /var/www/app
COPY config.json /config.json

RUN apt-get update && \
    apt-get install -y curl libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev libxpm-dev libpcre2-8-0 libicu-dev && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --with-xpm && \
    docker-php-ext-install mysqli gd intl exif && \
    docker-php-ext-enable mysqli gd intl exif && \
    ln -s /dev/stdout /var/log/unit.log && \
    mkdir -p /var/lib/unit && \
    chmod 544 /entrypoint.sh && \
    chmod -R 750 /var/www/app && \
    chown -R root:www-data /var/www/app

WORKDIR /var/www/app
EXPOSE 8000

ENTRYPOINT [ "sh", "-c" ]
CMD [ "/entrypoint.sh" ]
I'll leave it up to you to fill the configuration file.

In your entrypoint script you can have something like:

#!/bin/bash

#Do useful things

set -m
unitd --no-daemon &
curl -X PUT --data-binary @/config.json --unix-socket /var/run/control.unit.sock http://localhost/config/
fg %1
