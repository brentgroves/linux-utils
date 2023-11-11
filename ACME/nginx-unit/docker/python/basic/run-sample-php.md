https://unit.nginx.org/howto/samples/#sample-php

pushd ~/src/linux-utils/nginx-unit/docker
docker build -t brentgroves/unit-php-sample:1 . 
docker run --name php-sample -p 8080:8080 brentgroves/unit-php-sample:1 