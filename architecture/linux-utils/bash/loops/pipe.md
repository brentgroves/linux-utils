Pipelines
According to the bash manual section on pipelines (3.2.2 Pipelines), A pipeline is a sequence of one or more commands separated by one of the control operators ‘|’ or ‘|&’. That means every command is a pipeline whether or not you use its pipeline control operators.

When we strip away all of the options in the format for a pipeline:

[time [-p]] [!] command1 [ | or |& command2 ] …


https://www.gnu.org/software/bash/manual/bash.html#Pipelines
A pipeline is a sequence of one or more commands separated by one of the control operators ‘|’ or ‘|&’.

The format for a pipeline is

[time [-p]] [!] command1 [ | or |& command2 ] …
The output of each command in the pipeline is connected via a pipe to the input of the next command. That is, each command reads the previous command’s output. This connection is performed before any redirections specified by the command.

If ‘|&’ is used, command1’s standard error, in addition to its standard output, is connected to command2’s standard input through the pipe; it is shorthand for 2>&1 |. This implicit redirection of the standard error to the standard output is performed after any redirections specified by the command.

he reserved word time causes timing statistics to be printed for the pipeline once it finishes. The statistics currently consist of elapsed (wall-clock) time and user and system time consumed by the command’s execution. The -p option changes the output format to that specified by POSIX. When the shell is in POSIX mode (see Bash POSIX Mode), it does not recognize time as a reserved word if the next token begins with a ‘-’. The TIMEFORMAT variable may be set to a format string that specifies how the timing information should be displayed. See Bash Variables, for a description of the available formats. The use of time as a reserved word permits the timing of shell builtins, shell functions, and pipelines. An external time command cannot time these easily.

select
The select construct allows the easy generation of menus. It has almost the same syntax as the for command:

select name [in words …]; do commands; done
The list of words following in is expanded, generating a list of items. The set of expanded words is printed on the standard error output stream, each preceded by a number. If the ‘in words’ is omitted, the positional parameters are printed, as if ‘in "$@"’ had been specified. The PS3 prompt is then displayed and a line is read from the standard input. If the line consists of a number corresponding to one of the displayed words, then the value of name is set to that word. If the line is empty, the words and prompt are displayed again. If EOF is read, the select command completes. Any other value read causes name to be set to null. The line read is saved in the variable REPLY.

The commands are executed after each selection until a break command is executed, at which point the select command completes.

Here is an example that allows the user to pick a filename from the current directory, and displays the name and index of the file selected.

select fname in *;
do
	echo you picked $fname \($REPLY\)
	break;
done

When the shell is in POSIX mode (see Bash POSIX Mode), time may be followed by a newline. In this case, the shell displays the total user and system time consumed by the shell and its children. The TIMEFORMAT variable may be used to specify the format of the time information.

If the pipeline is not executed asynchronously (see Lists), the shell waits for all commands in the pipeline to complete.

The exit status of a pipeline is the exit status of the last command in the pipeline, unless the pipefail option is enabled (see The Set Builtin). If pipefail is enabled, the pipeline’s return status is the value of the last (rightmost) command to exit with a non-zero status, or zero if all commands exit successfully. If the reserved word ‘!’ precedes the pipeline, the exit status is the logical negation of the exit status as described above. The shell waits for all commands in the pipeline to terminate before returning a value.

3.2.4 Lists of Commands
A list is a sequence of one or more pipelines separated by one of the operators ‘;’, ‘&’, ‘&&’, or ‘||’, and optionally terminated by one of ‘;’, ‘&’, or a newline.

Of these list operators, ‘&&’ and ‘||’ have equal precedence, followed by ‘;’ and ‘&’, which have equal precedence.

A sequence of one or more newlines may appear in a list to delimit commands, equivalent to a semicolon.

If a command is terminated by the control operator ‘&’, the shell executes the command asynchronously in a subshell. This is known as executing the command in the background, and these are referred to as asynchronous commands. The shell does not wait for the command to finish, and the return status is 0 (true). When job control is not active (see Job Control), the standard input for asynchronous commands, in the absence of any explicit redirections, is redirected from /dev/null.

Commands separated by a ‘;’ are executed sequentially; the shell waits for each command to terminate in turn. The return status is the exit status of the last command executed.

AND and OR lists are sequences of one or more pipelines separated by the control operators ‘&&’ and ‘||’, respectively. AND and OR lists are executed with left associativity.

An AND list has the form

command1 && command2
command2 is executed if, and only if, command1 returns an exit status of zero (success).

An OR list has the form

command1 || command2
command2 is executed if, and only if, command1 returns a non-zero exit status.

The return status of AND and OR lists is the exit status of the last command executed in the list.

3.2.5 Compound Commands
• Looping Constructs	  	Shell commands for iterative action.
• Conditional Constructs	  	Shell commands for conditional execution.
• Command Grouping	  	Ways to group commands.
Compound commands are the shell programming language constructs. Each construct begins with a reserved word or control operator and is terminated by a corresponding reserved word or operator. Any redirections (see Redirections) associated with a compound command apply to all commands within that compound command unless explicitly overridden.

In most cases a list of commands in a compound command’s description may be separated from the rest of the command by one or more newlines, and may be followed by a newline in place of a semicolon.

Bash provides looping constructs, conditional commands, and mechanisms to group commands and execute them as a unit.

3.2.5.1 Looping Constructs
Bash supports the following looping constructs.

Note that wherever a ‘;’ appears in the description of a command’s syntax, it may be replaced with one or more newlines.

until
The syntax of the until command is:

until test-commands; do consequent-commands; done
Execute consequent-commands as long as test-commands has an exit status which is not zero. The return status is the exit status of the last command executed in consequent-commands, or zero if none was executed.

while
The syntax of the while command is:

while test-commands; do consequent-commands; done
Execute consequent-commands as long as test-commands has an exit status of zero. The return status is the exit status of the last command executed in consequent-commands, or zero if none was executed.

for
The syntax of the for command is:

for name [ [in [words …] ] ; ] do commands; done
Expand words (see Shell Expansions), and execute commands once for each member in the resultant list, with name bound to the current member. If ‘in words’ is not present, the for command executes the commands once for each positional parameter that is set, as if ‘in "$@"’ had been specified (see Special Parameters).

The return status is the exit status of the last command that executes. If there are no items in the expansion of words, no commands are executed, and the return status is zero.

An alternate form of the for command is also supported:

for (( expr1 ; expr2 ; expr3 )) ; do commands ; done
First, the arithmetic expression expr1 is evaluated according to the rules described below (see Shell Arithmetic). The arithmetic expression expr2 is then evaluated repeatedly until it evaluates to zero. Each time expr2 evaluates to a non-zero value, commands are executed and the arithmetic expression expr3 is evaluated. If any expression is omitted, it behaves as if it evaluates to 1. The return value is the exit status of the last command in commands that is executed, or false if any of the expressions is invalid.

The break and continue builtins (see Bourne Shell Builtins) may be used to control loop execution.

3.2.5.2 Conditional Constructs
if
The syntax of the if command is:

if test-commands; then
  consequent-commands;
[elif more-test-commands; then
  more-consequents;]
[else alternate-consequents;]
fi
The test-commands list is executed, and if its return status is zero, the consequent-commands list is executed. If test-commands returns a non-zero status, each elif list is executed in turn, and if its exit status is zero, the corresponding more-consequents is executed and the command completes. If ‘else alternate-consequents’ is present, and the final command in the final if or elif clause has a non-zero exit status, then alternate-consequents is executed. The return status is the exit status of the last command executed, or zero if no condition tested true.

case
The syntax of the case command is:

case word in
    [ [(] pattern [| pattern]…) command-list ;;]…
esac
case will selectively execute the command-list corresponding to the first pattern that matches word. The match is performed according to the rules described below in Pattern Matching. If the nocasematch shell option (see the description of shopt in The Shopt Builtin) is enabled, the match is performed without regard to the case of alphabetic characters. The ‘|’ is used to separate multiple patterns, and the ‘)’ operator terminates a pattern list. A list of patterns and an associated command-list is known as a clause.

Each clause must be terminated with ‘;;’, ‘;&’, or ‘;;&’. The word undergoes tilde expansion, parameter expansion, command substitution, arithmetic expansion, and quote removal (see Shell Parameter Expansion) before matching is attempted. Each pattern undergoes tilde expansion, parameter expansion, command substitution, and arithmetic expansion.

There may be an arbitrary number of case clauses, each terminated by a ‘;;’, ‘;&’, or ‘;;&’. The first pattern that matches determines the command-list that is executed. It’s a common idiom to use ‘*’ as the final pattern to define the default case, since that pattern will always match.

Here is an example using case in a script that could be used to describe one interesting feature of an animal:

echo -n "Enter the name of an animal: "
read ANIMAL
echo -n "The $ANIMAL has "
case $ANIMAL in
  horse | dog | cat) echo -n "four";;
  man | kangaroo ) echo -n "two";;
  *) echo -n "an unknown number of";;
esac
echo " legs."
If the ‘;;’ operator is used, no subsequent matches are attempted after the first pattern match. Using ‘;&’ in place of ‘;;’ causes execution to continue with the command-list associated with the next clause, if any. Using ‘;;&’ in place of ‘;;’ causes the shell to test the patterns in the next clause, if any, and execute any associated command-list on a successful match, continuing the case statement execution as if the pattern list had not matched.

The return status is zero if no pattern is matched. Otherwise, the return status is the exit status of the command-list executed.




https://linuxhint.com/bash_pipe_tutorial/
What are pipes?
A pipe is an enclosed medium that allows flow from one end to another. In the real-world pipes are used to convey matter, mostly liquid such as water or gas such as smoke but sometimes convey a mixture of liquid and solids. In a Linux environment, a pipe is a special file that connects the output of one process to the input of another process. In bash, a pipe is the | character with or without the & character. With the power of both characters combined we have the control operators for pipelines, | and |&.

Facts about pipes
Pipeline time
A pipeline may begin with time, which reports runtime statistics after completion of the pipeline
Pipeline portable time
time accepts the option -p for improved portability of runtime statistics, replacing tab with single space and converting time to seconds with no unit, the output format specified by POSIX
Pipeline operators and implicit redirection
By default, only standard output of commands on the left-hand side of the operator | is connect to commands on the other side. To have standard error connected as well the &| operator may be used. However, it is simply shorthand for 2>&1|, which redirects standard error to standard error before the pipeline operator.
List precedence in pipelines
If the command on the left-hand side of the pipeline operator is a list ({ command1; command2; …} or (command1;command2;…)), the pipeline waits for the list to complete
Pipeline behavior under lastpipe
Commands in a pipeline are executed in subshells unless the lastpipe shopt is enabled. If lastpipe is enabled, the command on the far-right side is executed as a command belonging to the current shell. See Test lastpipe in Tests.
Custom time format
time output may be customized using the bash variable TIMEFORMAT. See Test time format in Tests.
Pipeline behavior under pipefail
By default, all commands in the pipeline are executed without regard of the exit status of commands on to the left and the exit status of the right-most command is return. However, if pipefail is enabled, the pipeline will terminate abruptly if any of its commands returns a non-zero exit status. Also, the pipeline exit status will be that of the last command exited with a non-zero exit status.

How to use pipes by example
As mentioned in What are pipes, bash has two control operators for pipelines, namely | and |&. That is the groundwork. Let’ go into how to use pipes.

Using | pipes
This is the standard pipeline that most bash programmers have touched sometime or another. It only passes standard output right, down the pipeline.

Using |& pipes
This is the non-standard pipeline that most bash programmers seldom touch. It implicitly redirects standard error to standard output and proceeds as in the standard pipeline.#!/bin/bash
## test-pipeline-time2
## version 0.0.1 – initial
##################################################
func() { read -t ${t} input
time -p {
echo ${input-1} 1>&2
sleep 1
echo $(( ${input-1} + 1 ))
}
}
test-pipeline-time2() {
t=0 ; time echo 1 | func | func | func
t=1 ; time echo 1 | func | func | func
t=2 ; time echo 1 | func | func | func
t=3 ; time echo 1 | func | func | func
t=4 ; time echo 1 | func | func | func
}
##################################################
if [ ${#} -eq 0 ]
then
true
else
exit 1 # wrong args
fi
##################################################
test-pipeline-time2
##################################################
## generated by create-stub2.sh v0.1.2
## on Tue, 23 Jul 2019 22:13:53 +0900
## see <https://github.com/temptemp3/sh2>



#!/bin/bash
## test-pipeline-standard
## version 0.0.1 - initial
##################################################
upper() { { local str ; read str ; }
echo error in upper 1>&2
echo ${str^^}
}
lower() { { local str ; read str ; }
echo error in lower 1>&2
echo ${str,,}
}
test-pipeline-standard() {

echo ${@} | lower | upper
}
##################################################
if [ ! ]
then
true
else
exit 1 # wrong args
fi
##################################################
test-pipeline-standard ${@}
##################################################
## generated by create-stub2.sh v0.1.2
## on Tue, 23 Jul 2019 13:28:31 +0900
## see <https://github.com/temptemp3/sh2>
##################################################
