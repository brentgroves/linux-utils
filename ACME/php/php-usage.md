https://hub.docker.com/_/php

How to use this image
Create a Dockerfile in your PHP project
FROM php:7.4-cli
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
CMD [ "php", "./your-script.php" ]

Then, run the commands to build and run the Docker image:

$ docker build -t my-php-app .
$ docker run -it --rm --name my-running-app my-php-app
Run a single PHP script
For many simple, single file projects, you may find it inconvenient to write a complete Dockerfile. In such cases, you can run a PHP script by using the PHP Docker image directly:

$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp php:7.4-cli php your-script.php

How to install more PHP extensions
Many extensions are already compiled into the image, so it's worth checking the output of php -m or php -i before going through the effort of compiling more.

We provide the helper scripts docker-php-ext-configure, docker-php-ext-install, and docker-php-ext-enable to more easily install PHP extensions.

In order to keep the images smaller, PHP's source is kept in a compressed tar file. To facilitate linking of PHP's source with any extension, we also provide the helper script docker-php-source to easily extract the tar or delete the extracted source. Note: if you do use docker-php-source to extract the source, be sure to delete it in the same layer of the docker image.

FROM php:7.4-cli
RUN docker-php-source extract \
	# do important things \
	&& docker-php-source delete