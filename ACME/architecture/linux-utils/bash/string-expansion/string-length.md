https://www.thegeekstuff.com/2010/07/bash-string-manipulation/
1. Identify String Length inside Bash Shell Script
${#string}
The above format is used to get the length of the given bash variable.

$ cat len.sh
#! /bin/bash

var="Welcome to the geekstuff"

echo ${#var}

$ ./len.sh
24