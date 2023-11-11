https://dev.to/manuelojeda/create-a-proper-debug-setup-in-vs-code-with-laravel-sail-57kn

https://blog.devsense.com/2022/laravel-on-docker
# examine the current deploy script
curl -s "https://laravel.build/example-app?with=mysql,redis&devcontainer" > deploy-with-devcontainer.sh
# run the deploy script
run the deploy script with the devcontainer querystring parameter
curl -s "https://laravel.build/example-app?with=mysql,redis&devcontainer" | bash

# Publish all the Docker config files
cd example-app
sail up -d
And then we run the next command to publish the Docker config files we need to edit:
sail artisan sail:publish

Now we can stop the project with:
sail down
or
sail stop

# Config the project
https://dev.to/manuelojeda/create-a-proper-debug-setup-in-vs-code-with-laravel-sail-57kn
Open docker-compose.yml and add the next:
I did not change docker-compose.yml

docker/8.2/php.ini and add to the end of the file:
[XDebug]
xdebug.start_with_request = yes
xdebug.show_local_vars = on
xdebug.mode = debug
xdebug.discover_client_host = true
xdebug.client_host = host.docker.internal
xdebug.client_port = 9003

# rebuild the images
Once we have everything set, we should turn on the project once more but rebuilding everything again (it won't take too much time, I promise!):
sail up --build -d

# Set up VSCode to work with Laravel Sail
Open VScode and we are going to need the next:
Install PHP Debug
Install Docker and Remote Explorer
Config the debugger
Install Xdebug Helper in your browser
Install PHP Debug
We need to install the next extension, in case you don't have it:
https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug
Install Docker and Remote Explorer
In case you don't have it, install: https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker y https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
this will help us to gain access through VS Code to the project container and we can edit the code we need while we are in the development.

After I ran the sail composer require --dev barryvdh/laravel-ide-helper command the composer.json removed the ide-help lines below
https://github.com/barryvdh/laravel-ide-helper
First, open up composer.json and update post-update-cmd by adding these commands:

    "scripts": {
        "post-update-cmd": [
            "@php artisan ide-helper:generate",
            "@php artisan ide-helper:models",
            "@php artisan ide-helper:meta"
        ],
    },

They will regenerate ide helper files on each time you update your dependencies. Then run the following command to get the package:

sail composer require --dev barryvdh/laravel-ide-helper

# Install Xdebug helper
Now go to your browser and install:

Chrome: https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc
Firefox: https://addons.mozilla.org/en-US/firefox/addon/xdebug-helper-for-firefox/

# run vscode
cd example-app
code .

# Customizing devcontainer.json file
Let's make slight changes to devcontainer.json. We will want to have full PHP support in the container. So we are going to add PHP Tools extension DEVSENSE.phptools-vscode to the extensions section and also specify code style settings php.format.codeStyle for the formatter (one component of the PHP Tools). Laravel uses PSR-2, so that's what we are going to use. You can just copy the whole file from here:

// https://aka.ms/devcontainer.json
{
    "name": "Existing Docker Compose (Extend)",
    "dockerComposeFile": [
        "../docker-compose.yml"
    ],
    "service": "laravel.test",
    "workspaceFolder": "/var/www/html",
    "settings": {
        "php.format.codeStyle": "PSR-2"
    },
    "extensions": [
        "DEVSENSE.phptools-vscode"
        // "mikestead.dotenv",
        // "amiralizadeh9480.laravel-extra-intellisense",
        // "ryannaddy.laravel-artisan",
        // "onecentlin.laravel5-snippets",
        // "onecentlin.laravel-blade"
    ],
    "remoteUser": "sail",
    "postCreateCommand": "chown -R 1000:1000 /var/www/html"
    // "forwardPorts": [],
    // "runServices": [],
    // "shutdownAction": "none",
}

# devcontainer json docs
https://containers.dev/implementors/json_reference/

# add vscode extensions
https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack
https://marketplace.visualstudio.com/items?itemName=DEVSENSE.phptools-vscode

# git notes
cd ~/src
git clone git@github.com:brentgroves/html.git
the .env file is not in the repo I guess you could add it if this is just a test.
sail up --build -d
code .

