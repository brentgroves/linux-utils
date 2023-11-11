https://unit.nginx.org/installation/#docker-images

https://unit.nginx.org/installation/#installation-docker
https://hub.docker.com/_/php

https://unit.nginx.org/howto/docker/

docker pull unit:php8.2
docker run -d unit:php8.2

docker cp "kind_ellis:/usr/local/etc/php" "`pwd`/config/php"
