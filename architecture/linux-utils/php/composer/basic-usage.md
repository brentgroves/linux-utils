Basic usage#
Introduction#
For our basic usage introduction, we will be installing monolog/monolog, a logging library. If you have not yet installed Composer, refer to the Intro chapter.

Note: for the sake of simplicity, this introduction will assume you have performed a local install of Composer.

composer.json: Project setup#
To start using Composer in your project, all you need is a composer.json file. This file describes the dependencies of your project and may contain other metadata as well. It typically should go in the top-most directory of your project/VCS repository. You can technically run Composer anywhere but if you want to publish a package to Packagist.org, it will have to be able to find the file at the top of your VCS repository.


The require key#
The first thing you specify in composer.json is the require key. You are telling Composer which packages your project depends on.

{
    "require": {
        "monolog/monolog": "2.0.*"
    }
}
As you can see, require takes an object that maps package names (e.g. monolog/monolog) to version constraints (e.g. 1.0.*).

Composer uses this information to search for the right set of files in package "repositories" that you register using the repositories key, or in Packagist.org, the default package repository. In the above example, since no other repository has been registered in the composer.json file, it is assumed that the monolog/monolog package is registered on Packagist.org. (Read more about Packagist, and about repositories).

Installing dependencies#
To initially install the defined dependencies for your project, you should run the update command.

php composer.phar update
This will make Composer do two things:

It resolves all dependencies listed in your composer.json file and writes all of the packages and their exact versions to the composer.lock file, locking the project to those specific versions. You should commit the composer.lock file to your project repo so that all people working on the project are locked to the same versions of dependencies (more below). This is the main role of the update command.
It then implicitly runs the install command. This will download the dependencies' files into the vendor directory in your project. (The vendor directory is the conventional location for all third-party code in a project). In our example from above, you would end up with the Monolog source files in vendor/monolog/monolog/. As Monolog has a dependency on psr/log, that package's files can also be found inside vendor/.
Tip: If you are using git for your project, you probably want to add vendor in your .gitignore. You really don't want to add all of that third-party code to your versioned repository.

Commit your composer.lock file to version control#
Committing this file to version control is important because it will cause anyone who sets up the project to use the exact same versions of the dependencies that you are using. Your CI server, production machines, other developers in your team, everything and everyone runs on the same dependencies, which mitigates the potential for bugs affecting only some parts of the deployments. Even if you develop alone, in six months when reinstalling the project you can feel confident the dependencies installed are still working even if your dependencies released many new versions since then. (See note below about using the update command.)

Note: For libraries it is not necessary to commit the lock file, see also: Libraries - Lock file.


Updating dependencies to their latest versions#
As mentioned above, the composer.lock file prevents you from automatically getting the latest versions of your dependencies. To update to the latest versions, use the update command. This will fetch the latest matching versions (according to your composer.json file) and update the lock file with the new versions.

php composer.phar update
Note: Composer will display a Warning when executing an install command if the composer.lock has not been updated since changes were made to the composer.json that might affect dependency resolution.

If you only want to install, upgrade or remove one dependency, you can explicitly list it as an argument:

php composer.phar update monolog/monolog [...]

Packagist#
Packagist.org is the main Composer repository. A Composer repository is basically a package source: a place where you can get packages from. Packagist aims to be the central repository that everybody uses. This means that you can automatically require any package that is available there, without further specifying where Composer should look for the package.

If you go to the Packagist.org website, you can browse and search for packages.

Any open source project using Composer is recommended to publish their packages on Packagist. A library does not need to be on Packagist to be used by Composer, but it enables discovery and adoption by other developers more quickly.

Platform packages#
Composer has platform packages, which are virtual packages for things that are installed on the system but are not actually installable by Composer. This includes PHP itself, PHP extensions and some system libraries.

php represents the PHP version of the user, allowing you to apply constraints, e.g. ^7.1. To require a 64bit version of php, you can require the php-64bit package.

hhvm represents the version of the HHVM runtime and allows you to apply a constraint, e.g., ^2.3.

ext-<name> allows you to require PHP extensions (includes core extensions). Versioning can be quite inconsistent here, so it's often a good idea to set the constraint to *. An example of an extension package name is ext-gd.

lib-<name> allows constraints to be made on versions of libraries used by PHP. The following are available: curl, iconv, icu, libxml, openssl, pcre, uuid, xsl.

You can use show --platform to get a list of your locally available platform packages.

Autoloading#
For libraries that specify autoload information, Composer generates a vendor/autoload.php file. You can include this file and start using the classes that those libraries provide without any extra work:

require __DIR__ . '/vendor/autoload.php';

$log = new Monolog\Logger('name');
$log->pushHandler(new Monolog\Handler\StreamHandler('app.log', Monolog\Logger::WARNING));
$log->warning('Foo');
You can even add your own code to the autoloader by adding an autoload field to composer.json.

{
    "autoload": {
        "psr-4": {"Acme\\": "src/"}
    }
}
Composer will register a PSR-4 autoloader for the Acme namespace.

You define a mapping from namespaces to directories. The src directory would be in your project root, on the same level as the vendor directory. An example filename would be src/Foo.php containing an Acme\Foo class.

After adding the autoload field, you have to re-run this command:

php composer.phar dump-autoload
This command will re-generate the vendor/autoload.php file. See the dump-autoload section for more information.

Including that file will also return the autoloader instance, so you can store the return value of the include call in a variable and add more namespaces. This can be useful for autoloading classes in a test suite, for example.

$loader = require __DIR__ . '/vendor/autoload.php';
$loader->addPsr4('Acme\\Test\\', __DIR__);
In addition to PSR-4 autoloading, Composer also supports PSR-0, classmap and files autoloading. See the autoload reference for more information.

See also the docs on optimizing the autoloader.

Note: Composer provides its own autoloader. If you don't want to use that one, you can include vendor/composer/autoload_*.php files, which return associative arrays allowing you to configure your own autoloader.


