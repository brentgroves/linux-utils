pstree -p

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