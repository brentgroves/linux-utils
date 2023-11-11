https://www.tutorialspoint.com/laravel/laravel_overview.htm
Composer
Composer is a tool which includes all the dependencies and libraries. It allows a user to create a project with respect to the mentioned framework (for example, those used in Laravel installation). Third party libraries can be installed easily with help of composer.

All the dependencies are noted in composer.json file which is placed in the source folder.

Artisan
Command line interface used in Laravel is called Artisan. It includes a set of commands which assists in building a web application. These commands are incorporated from Symphony framework, resulting in add-on features in Laravel 5.1 (latest version of Laravel).


Features of Laravel
Laravel offers the following key features which makes it an ideal choice for designing web applications −

Modularity
Laravel provides 20 built in libraries and modules which helps in enhancement of the application. Every module is integrated with Composer dependency manager which eases updates.

Testability
Laravel includes features and helpers which helps in testing through various test cases. This feature helps in maintaining the code as per the requirements.

Routing
Laravel provides a flexible approach to the user to define routes in the web application. Routing helps to scale the application in a better way and increases its performance.

Configuration Management
A web application designed in Laravel will be running on different environments, which means that there will be a constant change in its configuration. Laravel provides a consistent approach to handle the configuration in an efficient way.

Query Builder and ORM
Laravel incorporates a query builder which helps in querying databases using various simple chain methods. It provides ORM (Object Relational Mapper) and ActiveRecord implementation called Eloquent.

Schema Builder
Schema Builder maintains the database definitions and schema in PHP code. It also maintains a track of changes with respect to database migrations.

Template Engine
Laravel uses the Blade Template engine, a lightweight template language used to design hierarchical blocks and layouts with predefined blocks that include dynamic content.

E-mail
Laravel includes a mail class which helps in sending mail with rich content and attachments from the web application.

Authentication
User authentication is a common feature in web applications. Laravel eases designing authentication as it includes features such as register, forgot password and send password reminders.

Redis
Laravel uses Redis to connect to an existing session and general-purpose cache. Redis interacts with session directly.

Queues
Laravel includes queue services like emailing large number of users or a specified Cron job. These queues help in completing tasks in an easier manner without waiting for the previous task to be completed.

Event and Command Bus
Laravel 5.1 includes Command Bus which helps in executing commands and dispatch events in a simple way. The commands in Laravel act as per the application’s lifecycle.

For managing dependencies, Laravel uses composer. Make sure you have a Composer installed on your system before you install Laravel. In this chapter, you will see the installation process of Laravel.

You will have to follow the steps given below for installing Laravel onto your system −

Step 1 − Visit the following URL and download composer to install it on your system.

https://getcomposer.org/download/

Step 2 − After the Composer is installed, check the installation by typing the Composer command in the command prompt as shown in the following screenshot.

Step 3 − Create a new directory anywhere in your system for your new Laravel project. After that, move to path where you have created the new directory and type the following command there to install Laravel.

composer create-project laravel/laravel –-prefer-dist
Now, we will focus on installation of version 5.7. In Laravel version 5.7, you can install the complete framework by typing the following command −

composer create-project laravel/laravel test dev-develop
The Laravel framework can be directly installed with develop branch which includes the latest framework.

Step 4 − The above command will install Laravel in the current directory. Start the Laravel service by executing the following command.

php artisan serve

