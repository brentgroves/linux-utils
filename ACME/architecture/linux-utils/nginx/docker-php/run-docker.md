https://hub.docker.com/r/trafex/php-nginx
https://perishablepress.com/roll-your-own-whats-my-ip/
https://hub.docker.com/_/nginx
pushd ~/src/linux-utils/nginx/docker-php
http://localhost:11371/pks/lookup?op=stats


# copy nginx default conf
If you wish to adapt the default configuration, use something like the following to copy it from a running nginx container:
docker run --name tmp-nginx-container -d trafex/php-nginx
docker cp tmp-nginx-container:/etc/nginx/nginx.conf /home/brent/src/linux-utils/nginx/docker-php/default_nginx.conf
docker cp tmp-nginx-container:/etc/nginx/conf.d/default.conf /home/brent/src/linux-utils/nginx/docker-php/default.conf
# copy php default conf
docker cp tmp-nginx-container:/etc/php81/php.ini "`pwd`/default-config-files/php/php.ini"
docker cp "tmp-nginx-container:/etc/php81/conf.d" "`pwd`/default-config-files/php" 
# copy php-fpm conf
docker cp tmp-nginx-container:/etc/php81/php-fpm.conf "`pwd`/default-config-files/php/php-fpm.conf"
docker cp tmp-nginx-container:/etc/php81/php-fpm.d "`pwd`/default-config-files/php"

# run nginx with php default config
docker run --name nginx-php -p 80:8080 trafex/php-nginx

# run with custom nginx config
docker run --name nginx-php -p 80:8080 -v "`pwd`/config/nginx/conf.d/:/etc/nginx/conf.d/" trafex/php-nginx

docker exec -it nginx-php /bin/bash

# run with custom nginx config and your own code
docker run --name nginx-php -p 80:8080 -v "`pwd`/config/nginx/conf.d/:/etc/nginx/conf.d/" -v "`pwd`/webroot/:/var/www/html/" trafex/php-nginx

# stop and remove container
docker rm $(docker stop $(docker ps -a -q --filter ancestor=trafex/php-nginx --format="{{.ID}}"))

## run interactive terminal
docker exec -it some-nginx /bin/bash
docker exec -it tmp-nginx-container sh

# run nginx
Start the Docker container:
docker run -p 80:8080 trafex/php-nginx

## mount your own code
Or mount your own code to be served by PHP-FPM & Nginx
docker run -p 80:8080 -v ~/my-codebase:/var/www/html trafex/php-nginx


docker run --name some-nginx -v /home/brent/src/linux-utils/nginx/docker/nginx/test/conf.d/test.conf:/etc/nginx/conf.d/test.conf:ro -v /home/brent/src/linux-utils/nginx/docker/webroot:/usr/share/nginx/html:ro -d -p 8080:80 nginx

# run nginx without nginx docker images default.conf in conf.d
docker run --name some-nginx -v /home/brent/src/linux-utils/nginx/docker/nginx/test/conf.d/:/etc/nginx/conf.d/:ro -v /home/brent/src/linux-utils/nginx/docker/webroot:/usr/share/nginx/html:ro -d -p 8080:80 nginx
https://gist.github.com/JsAndDotNet/f8b6fc86c15a4727f737a75bc1bf43b2
# diplay response headers
curl -s -o /dev/null -D - http://virtual-server-1:8080/text.txt
curl -s -o /dev/null -D - http://virtual-server-2:8080/text.txt
curl -s -o /dev/null -D - http://virtual-server-3:8080/text.txt
# displaying detailed response
-L is the follow redirect flag
curl -vL http://virtual-server-1:8080/doesnotexist.html
curl -v http://virtual-server-1:8080/moved.html
curl -v http://moto:8080/
curl -v http://moto:8080/moved.html
curl -vL http://virtual-server-1:8080/moto1

curl -v http://virtual-server-1:8080/no-path
curl -v http://virtual-server-2:8080/no-path
curl -v http://virtual-server-3:8080/no-path

curl -v http://virtual-server-1:8080/
curl -v http://virtual-server-2:8080/
curl -v http://virtual-server-3:8080/

curl -v http://virtual-server-1:8080/canread.md
curl -v http://virtual-server-2:8080/canread.md
curl -v http://virtual-server-3:8080/canread.md

curl -v http://virtual-server-1:8080/LICENSE
curl -v http://virtual-server-2:8080/LICENSE
curl -v http://virtual-server-3:8080/LICENSE

# reload after config change
## run interactive terminal
docker exec -it some-nginx /bin/bash
nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
nginx -s reload

# remove cache
For a specific Site: First, make sure the Site is active in the current tab, then press F5 as described above.If that won't help, press Shift+F5 which will reload the page ignoring the Cache.
https://support.google.com/chrome/answer/157179?hl=en

# get access and error log info
https://stackoverflow.com/questions/61564018/in-nginx-docker-how-do-we-see-log-only-from-error-log
docker logs --tail=10 -f some-nginx 
## it show a combination of both error log and access log.

# stop and remove container
docker rm $(docker stop $(docker ps -a -q --filter ancestor=nginx --format="{{.ID}}"))



# run in debug-mode
docker run --name some-nginx -v /home/brent/src/linux-utils/nginx/docker/nginx/test/conf.d/test.conf:/etc/nginx/conf.d/test.conf:ro -v /home/brent/src/linux-utils/nginx/docker/webroot:/usr/share/nginx/html:ro -d -p 8080:80 nginx nginx-debug -g 'daemon off;'

# reload after config change
## run interactive terminal
docker exec -it some-nginx /bin/bash
nginx -s reload

# remove cache
For a specific Site: First, make sure the Site is active in the current tab, then press F5 as described above.If that won't help, press Shift+F5 which will reload the page ignoring the Cache.
https://support.google.com/chrome/answer/157179?hl=en

# get access and error log info
https://stackoverflow.com/questions/61564018/in-nginx-docker-how-do-we-see-log-only-from-error-log
docker logs --tail=10 -f some-nginx it show a combination of both error log and access log.

# stop and remove container
docker rm $(docker stop $(docker ps -a -q --filter ancestor=nginx --format="{{.ID}}"))


# search went here!!
http://localhost:8080/pks/lookup?search=brent%40moto&fingerprint=on&op=index

# This works
http://reports51:11371/pks/lookup?op=get&options=mr&search=0xA9CB7B55FA3C60CA

docker exec -it some-nginx /bin/bash

# get access and error log info
https://stackoverflow.com/questions/61564018/in-nginx-docker-how-do-we-see-log-only-from-error-log
docker logs --tail=10 -f some-nginx it show a combination of both error log and access log.

# remove cache
For a specific Site: First, make sure the Site is active in the current tab, then press F5 as described above.If that won't help, press Shift+F5 which will reload the page ignoring the Cache.
https://support.google.com/chrome/answer/157179?hl=en



If you add a custom CMD in the Dockerfile, be sure to include -g daemon off; in the CMD in order for nginx to stay in the foreground, so that Docker can track the process properly (otherwise your container will stop immediately after starting)!


# diplay response headers
curl -s -o /dev/null -D - http://site-three:8080/text.txt
# displaying detailed response
curl -v http://site-three:8080/canread.md

The reason is most likely that the server is telling the client (browser) to download the file. This is controlled (usually) via the HTTP header

Content-disposition: attachment
(optionally with a filename).

Check if the server serves your document with this header. To view the headers, you can download the page using a tool that preserves HTTP headers (e.g. wget --save-headers), or use an online service, e.g. http://web-sniffer.net/ .


