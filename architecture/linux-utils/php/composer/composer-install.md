
https://getcomposer.org/doc/00-intro.md
sudo apt install composer
Introduction#
Composer is a tool for dependency management in PHP. It allows you to declare the libraries your project depends on and it will manage (install/update) them for you.

Dependency management#
Composer is not a package manager in the same sense as Yum or Apt are. Yes, it deals with "packages" or libraries, but it manages them on a per-project basis, installing them in a directory (e.g. vendor) inside your project. By default, it does not install anything globally. Thus, it is a dependency manager. It does however support a "global" project for convenience via the global command.

This idea is not new and Composer is strongly inspired by node's npm and ruby's bundler.

Suppose:

You have a project that depends on a number of libraries.
Some of those libraries depend on other libraries.
Composer:

Enables you to declare the libraries you depend on.
Finds out which versions of which packages can and need to be installed, and installs them (meaning it downloads them into your project).
You can update all your dependencies in one command.
See the Basic usage chapter for more details on declaring dependencies.

Installation - Linux / Unix / macOS#
Downloading the Composer Executable#
Composer offers a convenient installer that you can execute directly from the command line. Feel free to download this file or review it on GitHub if you wish to know more about the inner workings of the installer. The source is plain PHP.

There are, in short, two ways to install Composer. Locally as part of your project, or globally as a system wide executable.

Locally#
To install Composer locally, run the installer in your project directory. See the Download page for instructions.

The installer will check a few PHP settings and then download composer.phar to your working directory. This file is the Composer binary. It is a PHAR (PHP archive), which is an archive format for PHP which can be run on the command line, amongst other things.

Now run php composer.phar in order to run Composer.

You can install Composer to a specific directory by using the --install-dir option and additionally (re)name it as well using the --filename option. When running the installer when following the Download page instructions add the following parameters:

php composer-setup.php --install-dir=bin --filename=composer
Now run php bin/composer in order to run Composer.

