https://www.baeldung.com/linux/exec-command-in-shell-script

2. The Basics
Whenever we run any command in a Bash shell, a subshell is created by default, and a new child process is spawned (forked) to execute the command. When using exec, however, the command following exec replaces the current shell. This means no subshell is created and the current process is replaced with this new command.

Let’s run an experiment to understand it better:

$ pstree -p
init(1)─┬─init(52)───bash(53)
        ├─init(78)───bash(79)───pstree(108)
        └─{init}(7)
$ echo $$
79
$ exec sleep 300
We checked the PID of the current shell using echo $$ and pstree commands and then executed a sleep of 300 seconds using exec. Let’s now switch to a different terminal to check the process list:

$ ps -aef | grep $USER
user1       53    52  0 23:37 tty2     00:00:00 -bash
user1       79    78  0 23:39 tty1     00:00:00 sleep 300
user1      111    53  0 23:40 tty2     00:00:00 ps -aef
user1      112    53  0 23:40 tty2     00:00:00 grep --color=auto 
As we can see, PID 79, which was initially assigned to Bash, is now assigned to the sleep command.

We’ll also observe that after 300-second sleep finishes, the session (terminal), which had PID 79, exited since the shell was replaced by exec command, and its execution has completed.

3. Process Replacement Using the exec Command
Overriding an existing process with a different command can be a powerful tool. Let’s explore this idea with some other examples.

3.1. User Login Profile
Let’s assume Bash is not the default shell of our Linux box. Interestingly, using exec command, we can replace the default shell in memory with the Bash shell by adding it to the user’s login profile:

exec bash
There are scenarios where we would want to add a specific program or a menu to the user’s login profile (.bashrc or .bash_profile), and in such cases, we can prevent the user to have Bash prompt access after the program exits irrespective of its exit status:

exec operations_menu.sh
3.2. Program Calls Within Scripts
We can call scripts or other programs within a script using exec to override the existing process in memory. This saves the number of processes created and hence the systems resources. This implementation is particularly useful in cases when we don’t want to return to the main script once the sub-script or program is executed:

#! /bin/bash

while true
do
   echo "1. Disk Stats "
   echo "2. Send Evening Report "
   read Input
   case "$Input" in
      1) exec df -kh ;;
      2) exec /home/SendReport.sh  ;;
   esac
done
In this simple user input driven script, we executed the df command and a script using exec within different menu options.

