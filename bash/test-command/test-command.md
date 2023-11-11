https://data-skills.github.io/unix-and-bash/03-bash-scripts/index.html
test command.
The final component necessary to understand Bash’s if statements is the test command. Like other programs, test exits with either 0 or 1. However test’s exit status indicates the return value of the test specified through its arguments, rather than exit success or error. test supports numerous standard comparison operators (whether two strings are equal, whether two integers are equal, whether one integer is greater than or equal to another, etc.), which is needed because ash can’t rely on familiar syntax such as > for “greater than,” as this is used for redirection: instead, test has its own syntax (see Table 12-1 for a full list). You can get a sense of how test works by playing with it directly on the command line (using ; echo “$?” to print the exit status):

test "ATG" = "ATG" ; echo "$?"
test "ATG" = "atg" ; echo "$?" 
test 3 -lt 1; echo "$?"
test 3 -le 3; echo "$?"
0
1
1
0
In practice, the most common tests are for whether files or directories exist and whether you can write to them. test supports numerous file- and directory- related test operations (the few that are most useful in bioinformatics are in Table 12-2). For examples:

test -d some_directory ; echo $? # is this a directory? 
test -f some_file.txt ; echo $? # is this a file?
test -r some_file.txt ; echo $? $ is this file readable?

test is usually combined with if statements is simple:

if test -f some_file.txt 
  then [...] 
fi
However, Bash provides a simpler syntactic alternative to the test statements: [ -f some_file.txt ]. Note that spaces around and within the brackets are required. This makes for much simpler if statements involving comparisons:

if [ -f some_file.txt ] 
  then [...] 
fi
When using this syntax, we can chain test expressions with -a as logical AND, -o as logical OR, ! as negation, and parentheses to group statements. Our familiar && and || operators won’t work in test, because these are shell operators. As an example, suppose we want to ensure our script has enough arguments and that the input file is readable:

#!/bin/bash
set -e
set -u
set -o pipefail

if [ "$#" -ne 1 -o ! -r "$1" ]
  then echo "usage: script.sh file_in.txt"
  exit 1 
fi