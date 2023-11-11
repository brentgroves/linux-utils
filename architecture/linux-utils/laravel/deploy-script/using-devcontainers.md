https://laravel.com/docs/8.x/sail#using-devcontainers
Using Devcontainers
If you would like to develop within a Devcontainer, you may provide the --devcontainer option to the sail:install command. The --devcontainer option will instruct the sail:install command to publish a default .devcontainer/devcontainer.json  file to the root of your application:

php artisan sail:install --devcontainer