https://dev.to/manuelojeda/create-a-proper-debug-setup-in-vs-code-with-laravel-sail-57kn
Questions:
- Can we make changes to the software and see the changes right away like we can when we use the Vite development server and Hot module reloading.

cd ~/src
git clone git@github.com:brentgroves/example-app.git
1. Create a new Laravel Sail project
curl -s https://laravel.build/example-app | bash
curl -s https://laravel.build/example-app > create-example-app.sh
cd ./example-app
Publish all the Docker config files
Once we are inside the directory, we need to turn on the project with:
sail up -d

And then we run the next command to publish the Docker config files we need to edit:
sail artisan sail:publish
sail down
or
sail stop
Config the project
Open docker-compose.yml and add the next:

We are done with the docker-compose.yml config, now we go and edit ./docker/8.2/php.ini and add to the end of the file:
[XDebug]
xdebug.start_with_request = yes
xdebug.show_local_vars = on
xdebug.mode = debug
xdebug.discover_client_host = true
xdebug.client_host = host.docker.internal
xdebug.client_port = 9003


Last but not least we modify the .env add in the end of the file:
SAIL_XDEBUG_MODE=develop,debug
SAIL_XDEBUG_CONFIG="client_host=localhost"

Once we have everything set, we should turn on the project once more but rebuilding everything again (it won't take too much time, I promise!):
sail up --build -d

4. Set up VSCode to work with Laravel Sail
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

click the Remote explorer extension on left.
Choose Dev Containers from drop down
attach to example-app-lvaravel-test-1 container
Once the container is open in VSCode we need to open /var/www/html, the Laravel code resides here.

Note: We need to confirm that we have PHP Debug installed by navigating the extensions list, in case is not installed it will have the next label Install in Container...

Config the debugger
Finally we go the Debugger section and create a launch.json file:

Open some php file such as index.php
So code knows to create a php launch.json file.

The article tells us to update the launch.json file but when I did debugging did not work.

Install Xdebug helper
Now go to your browser and install:

Chrome: https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc
Firefox: https://addons.mozilla.org/en-US/firefox/addon/xdebug-helper-for-firefox/
Look up for the extension and click it, it will show a list and enable Debug, this will help us to send the signal from our browser to your IDE to start the debugging when you visit a route:

5. Testing
Now go to VS Code and edit routes/web.php, select a breakpoint like in the image and press F5, it will start the debug session:

Open up the browser and go to http://localhost, it should automatically execute the debugger in VSCode, like this:

I used the browser to request http://localhost and the breakpoint hit but curl http://localhost did not until after I did the first request from the browser.

When I made a change to welcome.blade.php and made a request from the browser again I saw the change.







