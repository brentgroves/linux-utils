About PHP Configuration Files
The PHP configuration files are stored under /etc/php directory with the version numbers. For example, all the configuration files related to PHP 8.2 are located below:

https://xdebug.org/docs/install#configure-php
php --ini
Alternatively, you can run php --ini on the command line.

If there is a file with xdebug in the name, such as /etc/php/7.4/cli/conf.d/99-xdebug.ini, then this is the file to use.

If that file does not exist, but there are other files in a conf.d or similar directory, you can create a new file there too. Please name it 99-xdebug.ini in that case.



php -a
var_dump(php_ini_loaded_file(), php_ini_scanned_files());

Main PHP configuration file location:
PHP CLI: /etc/php/8.2/cli/php.ini
Apache: /etc/php/8.2/apache2/php.ini
PHP FPM: /etc/php/8.2/fpm/php.ini
All the installed PHP modules are stored under /etc/php/8.2/mods-available directory.
PHP Active modules configuration directory location:
PHP CLI: /etc/php/8.2/cli/conf.d/
Apache: /etc/php/8.2/apache2/conf.d/
PHP FPM: /etc/php/8.2/fpm/conf.d/
To check files for the other PHP versions, just change the PHP version number (8.2 in the above example) in the files and directory path.



https://www.php.net/manual/en/configuration.file.php

The configuration file ¶
The configuration file (php.ini) is read when PHP starts up. For the server module versions of PHP, this happens only once when the web server is started. For the CGI and CLI versions, it happens on every invocation.

php.ini is searched for in these locations (in order):

SAPI module specific location (PHPIniDir directive in Apache 2, -c command line option in CGI and CLI)
The PHPRC environment variable.
The location of the php.ini file can be set for different versions of PHP. The root of the registry keys depends on 32- or 64-bitness of the installed OS and PHP. For 32-bit PHP on a 32-bit OS or a 64-bit PHP on a 64-bit OS use [(HKEY_LOCAL_MACHINE\SOFTWARE\PHP] for 32-bit version of PHP on a 64-bit OS use [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\PHP]] instead. For same bitness installation the following registry keys are examined in order: [HKEY_LOCAL_MACHINE\SOFTWARE\PHP\x.y.z], [HKEY_LOCAL_MACHINE\SOFTWARE\PHP\x.y] and [HKEY_LOCAL_MACHINE\SOFTWARE\PHP\x], where x, y and z mean the PHP major, minor and release versions. For 32 bit versions of PHP on a 64 bit OS the following registry keys are examined in order: [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6421Node\PHP\x.y.z], [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6421Node\PHP\x.y] and [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6421Node\PHP\x], where x, y and z mean the PHP major, minor and release versions. If there is a value for IniFilePath in any of these keys, the first one found will be used as the location of the php.ini (Windows only).
[HKEY_LOCAL_MACHINE\SOFTWARE\PHP] or [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\PHP], value of IniFilePath (Windows only).
Current working directory (except CLI).
The web server's directory (for SAPI modules), or directory of PHP (otherwise in Windows).
Windows directory (C:\windows or C:\winnt) (for Windows), or --with-config-file-path compile time option.
If php-SAPI.ini exists (where SAPI is the SAPI in use, so, for example, php-cli.ini or php-apache.ini), it is used instead of php.ini. The SAPI name can be determined with php_sapi_name().

Note:

The Apache web server changes the directory to root at startup, causing PHP to attempt to read php.ini from the root filesystem if it exists.

Using environment variables can be used in php.ini as shown below.

Example #1 php.ini Environment Variables

; PHP_MEMORY_LIMIT is taken from environment
memory_limit = ${PHP_MEMORY_LIMIT}
The php.ini directives handled by extensions are documented on the respective pages of the extensions themselves. A list of the core directives is available in the appendix. Not all PHP directives are necessarily documented in this manual: for a complete list of directives available in your PHP version, please read your well commented php.ini file. Alternatively, you may find » the latest php.ini from Git helpful too.

Example #2 php.ini example

; any text on a line after an unquoted semicolon (;) is ignored
[php] ; section markers (text within square brackets) are also ignored
; Boolean values can be set to either:
;    true, on, yes
; or false, off, no, none
register_globals = off
track_errors = yes

; you can enclose strings in double-quotes
include_path = ".:/usr/local/lib/php"

; backslashes are treated the same as any other character
include_path = ".;c:\php\lib"
It is possible to refer to existing .ini variables from within .ini files. Example: open_basedir = ${open_basedir} ":/new/dir".

Scan directories ¶
It is possible to configure PHP to scan for .ini files in a directory after reading php.ini. This can be done at compile time by setting the --with-config-file-scan-dir option. The scan directory can then be overridden at run time by setting the PHP_INI_SCAN_DIR environment variable.

It is possible to scan multiple directories by separating them with the platform-specific path separator (; on Windows, NetWare and RISC OS; : on all other platforms; the value PHP is using is available as the PATH_SEPARATOR constant). If a blank directory is given in PHP_INI_SCAN_DIR, PHP will also scan the directory given at compile time via --with-config-file-scan-dir.

Within each directory, PHP will scan all files ending in .ini in alphabetical order. A list of the files that were loaded, and in what order, is available by calling php_ini_scanned_files(), or by running PHP with the --ini option.

Assuming PHP is configured with --with-config-file-scan-dir=/etc/php.d,
and that the path separator is :...

$ php
  PHP will load all files in /etc/php.d/*.ini as configuration files.

$ PHP_INI_SCAN_DIR=/usr/local/etc/php.d php
  PHP will load all files in /usr/local/etc/php.d/*.ini as
  configuration files.

$ PHP_INI_SCAN_DIR=:/usr/local/etc/php.d php
  PHP will load all files in /etc/php.d/*.ini, then
  /usr/local/etc/php.d/*.ini as configuration files.

$ PHP_INI_SCAN_DIR=/usr/local/etc/php.d: php
  PHP will load all files in /usr/local/etc/php.d/*.ini, then
  /etc/php.d/*.ini as configuration files.