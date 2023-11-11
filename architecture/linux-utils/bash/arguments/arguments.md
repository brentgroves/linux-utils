How do I get PID bash?
One can easily find the PID of the last executed command in shell script or bash. This page explains how to get the PID of a last executed app/program.
...
The syntax is as follows:
Open the terminal application.
Run your command or app in the background. ...

To get the PID of the last executed command type: echo "$!"
echo "$!"

https://data-skills.github.io/unix-and-bash/03-bash-scripts/index.html
Bash assigns the number of command-line arguments to the variable $# (this does not count the script name, $0, as an argument). 

echo '
#!/bin/bash 
if [ "$#" -lt 3 ] # are there less than 3 arguments? 
then
    echo "error: too few arguments, you provided $#, 3 required"
    echo "usage: script.sh arg1 arg2 arg3"
    exit 1
fi
echo "script name: $0"
echo "first arg: $1"
echo "second arg: $2"
echo "third arg: $3" ' > args.sh
bash args.sh arg1 arg2

https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script


Let’s take a look at the different ways to process the arguments passed to a bash script inside the script.

2.1. Positional Parameters
Arguments passed to a script are processed in the same order in which they’re sent. The indexing of the arguments starts at one, and the first argument can be accessed inside the script using $1. Similarly, the second argument can be accessed using $2, and so on. The positional parameter refers to this representation of the arguments using their position.

Let’s take an example of the following script, userReg-positional-parameter.sh, which prints username, age, and full name in that order:

echo "Username: $1";
echo "Age: $2";
echo "Full Name: $3";
Now let’s run this script with the three input parameters:

sh userReg-positional-parameter.sh john 25 'John Smith'
The output will be:

Username : john
Age: 25
Full Name: John Smith
