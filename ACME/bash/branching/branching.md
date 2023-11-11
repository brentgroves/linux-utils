http://www.compciv.org/topics/bash/conditional-branching/

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


echo "hello world" | grep not
status=$?
[ $status -eq 0 ] && echo "command successful" || echo "command unsuccessful"


if [[ $num -eq 42 ]]
then # if/then branch
  echo 'num is actually equal to 42'
else # else branch
  echo 'num is not 42'
fi

Just an if-statement
If there is a command-sequence that should optionally run based on whether a conditional expression is true, then the if/then statement can look as simple as this:

if [[ some condition ]]; then
  do_something
fi
Note some key things about the syntax:

Double-brackets [[ ]] are used to enclose the conditional expression
There must be a space between the enclosing brackets and the expression.
This is bad: [[$x == $y]]
This is fine: [[ $x == $y ]]
Example of Just an if-statement
Inside a script named just_an_if.sh, write the following code:

echo 'Hello'
if [[ $1 == 'awesome' ]]; then
  echo 'You are awesome'
fi
echo 'Bye'


if [[ $status -eq 0 ]]
then # if/then branch
  echo 'success'
else # else branch
  echo 'fail'
fi

# if [[ some condition ]]; then
#   do_something
# fi


# if [[ some condition ]]; then
#   do_this
# elif [[ another condition ]]; then
#   do_that_a
# elif [[ yet another condition]]; then
#   do_that_b
# else
#   do_that_default_thing
# fi