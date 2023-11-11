https://www.freecodecamp.org/news/test-php-code-with-phpunit/
To get started, create and initiate a new project with composer using these commands:

$ mkdir test-project
$ cd test-project
$ composer init
The first command creates a folder in your current directory, test-project and the second command moves into it. The last command starts an interactive shell.

Screenshot-2022-03-08-at-11.08.39
Composer init prompt
Follow the prompt, filling in the details as required (the default values are fine). You can set the project description, author name (or contributors' names), minimum stability for dependencies, project type, license, and define your dependencies.

You can skip the dependencies part, as we are not installing any dependencies. PHPUnit is supposed to be a dev-dependency because testing as a whole should only happen during development.

Now, when the prompt asks Would you like to define your dev dependencies (require-dev) interactively [yes]?, press enter to accept. Then type in phpunit/phpunit to install PHPUnit as a dev-dependency.

Accept the other defaults and proceed to generating the composer.json file. The generated file should look like this currently:

{
    "name": "zubair/test-project",
    "require-dev": {
        "phpunit/phpunit": "^9.5"
    },
    "autoload": {
        "psr-4": {
            "Zubair\\TestProject\\": "src/"
        }
    },
    "authors": [
        {
            "name": "Idris Aweda Zubair",
            "email": "zubairidrisaweda@gmail.com"
        }
    ],
    "require": {}
}
Composer generated compose.json
To learn how to install PHPUnit globally on your server, read here.