http://mywiki.wooledge.org/BashGuide/JobControl#jobspec

A foreground job can be suspended by pressing Ctrl-Z. There is no way to refer to the foreground job in bash: if there is a foreground job other than bash, then bash is waiting for that job to terminate, and hence cannot execute any code (even traps are delayed until the foreground job terminates). The following commands, therefore, work on background (and suspended) jobs only.

Job control enables the following commands:

fg [jobspec]: bring a background job to the foreground.

bg [jobspec ...]: run a suspended job in the background.

suspend: suspend the shell (mostly useful when the parent process is a shell with job control).

Other commands for interacting with jobs include:

jobs [options] [jobspec ...]: list suspended and background jobs. Options include -p (list process IDs only), -s (list only suspended jobs), and -r (list only running background jobs). If one or more jobspecs are specified, all other jobs are ignored.

kill can take a jobspec instead of a process ID.

disown tells bash to forget about an existing job. This keeps bash from automatically sending SIGHUP to the processes in that job, but also means it can no longer be referred to by jobspec.

So, what does all that mean? Job control allows you to have multiple things going on within a single terminal session. (This was terribly important in the old days when you only had one terminal on your desk, and no way to create virtual terminals to add more.) On modern systems and hardware, you have more choices available -- you could for example run screen or tmux within a terminal to give you virtual terminals. Or within an X session, you could open more xterm or similar terminal emulators (and you can mix the two together as well).

But sometimes, a simple job control "suspend and background" comes in handy. Maybe you started a backup and it's taking longer than you expected. You can suspend it with Ctrl-Z and then put it in the background with bg, and get your shell prompt back, so that you can work on something else in the same terminal session while that backup is running.


Job Specifications
A job specification or "jobspec" is a way of referring to the processes that make up a job. A jobspec may be:

%n to refer to job number n.

%str to refer to a job which was started by a command beginning with str. It is an error if there is more than one such job.

%?str to refer to a job which was started by a command containing str. It is an error if there is more than one such job.

%% or %+ to refer to the current job: the one most recently started in the background, or suspended from the foreground. fg and bg will operate on this job if no jobspec is given.

%- for the previous job (the job that was %% before the current one).

It is possible to run an arbitrary command with a jobspec, using jobs -x ''cmd args...''. This replaces arguments that look like jobspecs with the PIDs of the corresponding process group leaders, then runs the command. For example, jobs -x strace -p %% will attach strace to the current job (most useful if it is running in the background rather than suspended).

Finally, a bare jobspec may be used as a command: %1 is equivalent to fg %1, while %1 & is equivalent to bg %1.

