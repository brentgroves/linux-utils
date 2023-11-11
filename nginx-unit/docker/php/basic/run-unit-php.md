http://unit.nginx.org/howto/docker/
http://unit.nginx.org/howto/docker/#apps-in-a-containerized-unit
https://unit.nginx.org/howto/cakephp/

pushd ~/src/linux-utils/nginx-unit/docker/php/example
[here doc](https://en.wikipedia.org/wiki/Here_document)
mkdir webapp
cat << EOF > webapp/index.py
<?php phpinfo(); ?>
EOF

Next, create a simple Unit configuration for the app:

mkdir config
cat << EOF > config/config.json
{
  "listeners": {
      "*:8080": {
          "pass": "applications/php"
      }
  },
  "applications": {
      "php": {
          "type": "php",
          "root": "/www/"
      }
  }
}
EOF

Finally, let’s create log/ and state/ directories to store Unit log and state respectively:

mkdir log
touch log/unit.log
mkdir state
Our file structure so far:

/path/to/app
├── config
│   └── config.json
├── log
│   └── unit.log
├── requirements.txt
├── state
└── webapp
    └── index.py

Everything is ready for a containerized Unit. First, let’s create a Dockerfile to install app prerequisites:

FROM unit:1.30.0-php8.2
# port used by the listener in config.json
EXPOSE 8080


# build docker image
docker build --tag=unit-webapp-php .

# start container
pushd ~/src/linux-utils/nginx-unit/docker/php/basic
Next, we start a container and map it to our directory structure:
export UNIT=$(                                                         \
      docker run --name unit-webapp-php -d                                 \
      --mount type=bind,src="$(pwd)/config/",dst=/docker-entrypoint.d/   \
      --mount type=bind,src="$(pwd)/log/unit.log",dst=/var/log/unit.log  \
      --mount type=bind,src="$(pwd)/state",dst=/var/lib/unit             \
      --mount type=bind,src="$(pwd)/webapp",dst=/www                     \
      -p 8080:8080 unit-webapp-php                                           \
  )

With this mapping, Unit stores its state and log in your file structure. By default, our Docker images forward their log output to the [Docker log collector](https://docs.docker.com/config/containers/logging/).


We’ve mapped the source config/ to /docker-entrypoint.d/ in the container; the official image uploads any .json files found there into Unit’s config section if the state is empty. Now we can test the app:

curl -X GET localhost:8080

    Hello, World!
# examine logs
docker logs --tail=10 -f unit-webapp-php

# stop and remove container
docker rm $(docker stop $(docker ps -a -q --filter NAME=unit-webapp-php --format="{{.ID}}"))

## run interactive terminal
docker exec -it some-nginx /bin/bash
docker exec -it tmp-nginx-container sh
