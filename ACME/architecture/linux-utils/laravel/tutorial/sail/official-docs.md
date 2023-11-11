https://laravel.com/docs/8.x/sail
Introduction
Laravel Sail is a light-weight command-line interface for interacting with Laravel's default Docker development environment. Sail provides a great starting point for building a Laravel application using PHP, MySQL, and Redis without requiring prior Docker experience.

At its heart, Sail is the docker-compose.yml file and the sail script that is stored at the root of your project. The sail script provides a CLI with convenient methods for interacting with the Docker containers defined by the docker-compose.yml file.

Laravel Sail is supported on macOS, Linux, and Windows (via WSL2).

Installation & Setup
Laravel Sail is automatically installed with all new Laravel applications so you may start using it immediately. To learn how to create a new Laravel application, please consult Laravel's installation documentation for your operating system. During installation, you will be asked to choose which Sail supported services your application will be interacting with.

Installing Sail Into Existing Applications
If you are interested in using Sail with an existing Laravel application, you may simply install Sail using the Composer package manager. Of course, these steps assume that your existing local development environment allows you to install Composer dependencies:

composer require laravel/sail --dev

After Sail has been installed, you may run the sail:install Artisan command. This command will publish Sail's docker-compose.yml file to the root of your application:

php artisan sail:install

Finally, you may start Sail. To continue learning how to use Sail, please continue reading the remainder of this documentation:

./vendor/bin/sail up

Using Devcontainers
If you would like to develop within a Devcontainer, you may provide the --devcontainer option to the sail:install command. The --devcontainer option will instruct the sail:install command to publish a default .devcontainer/devcontainer.json  file to the root of your application:

php artisan sail:install --devcontainer

