https://stackoverflow.com/questions/23927561/how-to-debug-laravel-framework
Recently I came to discover this amazing plugin that allows you to dump variables, trace requests, executions, views, controllers, queries, profile memory, execution time, etc., everything related to the current rendered page. Very helpful :

https://laravel-news.com/laravel-debugbar

You can install it via composer:

composer require barryvdh/laravel-debugbar --dev
Then add it to your service providers array in /config/app.php

The Debugbar will start working inmediately if the debug mode is turned on: To do it so, you just need to modify in your config/app.php or .env file the debug_mode to true.

If you wish to use the dump methods in the debugbar console, you need to include the alias to your /config/app.php array:

'Debugbar' => Barryvdh\Debugbar\Facade::class,
Now you can start dumping variables like this:

\Debugbar::info($variable);
Pretty cool plugin. Cheers!

Share
Improve this answer
Follow
answered Mar 2, 2018 at 16:16
leopinzon's user avatar
leopinzon
67766 silver badges1313 bronze badges

At first install this package:

composer require barryvdh/laravel-debugbar --dev
In config/app.php Add Inside providers array:

Barryvdh\Debugbar\ServiceProvider::class,
And then aliases array:

'Debugbar' => Barryvdh\Debugbar\Facade::class,
After that you can debugging by:

Debugbar::info($object);
Debugbar::error('Error!');
Debugbar::warning('Watch out…');
Debugbar::addMessage('Another message', 'mylabel');