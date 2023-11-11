https://linuxhint.com/bash-exit-code-of-last-command/#:~:text=Checking%20Bash%20Exit%20Code,terminal%2C%20and%20run%20any%20command.&text=Check%20the%20value%20of%20the,the%20exit%20code%20is%200.

Defining Exit Status in Script
When writing a script, we can define custom exit code values. It’s a useful method for easier debugging. In bash scripts, it’s the “exit” command followed by the exit code value.

$ exit <value>
Per the convention, it’s recommended to assign exit code 0 for successful execution and use the rest (1-255) for possible errors. When reaching the exit command, the shell script execution will be terminated, so be careful of its placement.

Have a look at the following shell script. Here, if the condition is met, the script will terminate with the exit code 0. If the condition isn’t met, then the exit code will be 1.

$ #!/bin/bash
$ if [[ "$(whoami)" != root ]]; then
$   echo "Not root user."
$   exit 1
$ fi
$ echo "root user"
$ exit 0

Bash Exit Code
Every UNIX/Linux command executed by the shell script or user leaves an exit status. It’s an integer number that remains unchanged unless the next command is run. If the exit code is 0, then the command was successful. If the exit code is non-zero (1-255), then it signifies an error.

There are many potential usages of the bash exit code. The most obvious one is, of course, to verify whether the last command is executed properly, especially if the command doesn’t generate any output.

In the case of bash, the exit code of the previous command is accessible using the shell variable “$?”.

Checking Bash Exit Code
Launch a terminal, and run any command.


Now, have a look at the following command:

$ cat sample.txt | grep “coin”

When working with a command that has one or more pipes, the exit code will be of the last code executed in the pipe. In this case, it’s the grep command.

As the grep command was successful, it will be 0.

In this example, if the grep command fails, then the exit code will be non-zero.

$ cat sample.txt | grep “abcd”
$ echo $?

Incorporating Exit Code in Scripts
The exit code can also be used for scripting. One simple way to use it is by assigning it to a shell variable and working with it. Here’s a sample shell script that uses the exit code as a condition to print specific output.

$ #!/bin/bash
$ echo "hello world"
$ status=$?
$ [ $status -eq 0 ] && echo "command successful" || echo "command unsuccessful"
