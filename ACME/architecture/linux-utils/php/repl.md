phpinfo();
https://www.php.net/manual/en/features.commandline.interactive.php
Interactive shell ¶
The CLI SAPI provides an interactive shell using the -a option if PHP is compiled with the --with-readline option. As of PHP 7.1.0 the interactive shell is also available on Windows, if the readline extension is enabled.

Using the interactive shell you are able to type PHP code and have it executed directly.

Example #1 Executing code using the interactive shell

$ php -a
Interactive shell

php > echo 5+8;
13
php > function addTwo($n)
php > {
php { return $n + 2;
php { }
php > var_dump(addtwo(2));
int(4)
php >
The interactive shell also features tab completion for functions, constants, class names, variables, static method calls and class constants.

Example #2 Tab completion

Pressing the tab key twice when there are multiple possible completions will result in a list of these completions:

php > strp[TAB][TAB]
strpbrk   strpos    strptime  
php > strp
When there is only one possible completion, pressing tab once will complete the rest on the same line:

php > strpt[TAB]ime(
Completion will also work for names that have been defined during the current interactive shell session:

php > $fooThisIsAReallyLongVariableName = 42;
php > $foo[TAB]ThisIsAReallyLongVariableName

https://www.php.net/manual/en/features.commandline.interactive.php