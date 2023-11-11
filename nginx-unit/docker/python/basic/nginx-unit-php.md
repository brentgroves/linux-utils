https://unit.nginx.org/installation/#docker-images
1.30.0-php8.2	Single-language; based on the php:8.2-cli image.

cd ~/src
git clone git@github.com:brentgroves/unit-php8.2.git
cd unit-php8.2
docker build -t brentgroves/unit:php8.2 .

http://unit.nginx.org/howto/docker/

https://www.youtube.com/watch?v=gWZ3_dsHaHs
Unit in Docker
To run your apps in a containerized Unit using the images we provide, you need at least to:

Mount your application files to a directory in your container.
Publish Unit’s listener port to the host machine.
For example:

export UNIT=$(                                             \
      docker run -d --mount type=bind,src="$(pwd)",dst=/www  \
      -p 8080:8000 unit:1.30.0-python3.11                 \
  )

export UNIT=$(                                             \
      docker run -d --mount type=bind,src="$(pwd)",dst=/www  \
      -p 8080:8000 brentgroves/unit:php8.2                 \
  )

The command mounts the host’s current directory where your app files are stored to the container’s /www/ directory and publishes the container’s port 8000 that the listener will use as port 8080 on the host, saving the container’s ID in the UNIT environment variable.


