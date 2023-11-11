# run with custom nginx config and your own code
docker run --name nginx-php -p 80:8080 -v "`pwd`/config/nginx/conf.d/:/etc/nginx/conf.d/" -v "`pwd`/webroot/:/var/www/html/" trafex/php-nginx

docker run --name unit-php -p 8080:8000 -v "`pwd`/config/nginx/conf.d/:/etc/nginx/conf.d/" -v "`pwd`/webroot/:/var/www/html/" trafex/php-nginx

export UNIT=$(                                             \
      docker run -d --mount type=bind,src="$(pwd)",dst=/www  \
      -p 8080:8000 brentgroves/unit:php8.2                 \
  )


The command mounts the host’s current directory where your app files are stored to the container’s /www/ directory and publishes the container’s port 8000 that the listener will use as port 8080 on the host, saving the container’s ID in the UNIT environment variable.

# stop and remove container
docker rm $(docker stop $(docker ps -a -q --filter ancestor=trafex/php-nginx --format="{{.ID}}"))

## run interactive terminal
docker exec -it some-nginx /bin/bash
docker exec -it tmp-nginx-container sh
