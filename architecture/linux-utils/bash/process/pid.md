
https://www.cyberciti.biz/faq/how-to-return-pid-of-a-last-command-in-linux-unix/
How to return pid of a last command in Linux
The syntax is as follows:

Open the terminal application
Run your command or app in the background. For example: firefox &
To get the PID of the last executed command type: echo "$!"
Store the pid of the last command in a variable named foo: foo=$!
Print it, run: echo "$foo"
The PID of the last executed command is in the $! variable
The bash treats several variable specially. These vairable may only be referenced and assignment to them is not allowed. For example, the $! expands to the process ID (PID) of the command/program most recently placed into the background, whether executed as an asynchronous command or using the bg command/builtin.

How to get pid of just started process
Let us start sleep process, run:
sleep 20 &
echo $!

OR
firefox &
echo $!

Shell script example
Let us create a shell script wrapper named my-app.sh:

#!/bin/bash
echo "Starting my Linux/Unix awesome-app..."
/path/to/your/awesome-app &
_pid=$! 
echo "$_pid" > /var/run/awesome-app.pid
echo "Pid $_pid stored in /var/run/awesome-app.pid"

Using jobs internal command
The jobs command show status of jobs such as:
sleep 20 &

To lists process IDs only pass the -p option to the jobs:
my-app &
jobs -p

Sample outputs:

19967
The jobs command works with ksh and other shells. Typically, I put something as follows in my shell script wrappers:

#!/bin/bash
_name="/path/to/my-java-app"
_pid="/path/to/my-java-app.pid"
((${_name}) & jobs -p >${_pid})
It is also possible to get get the command's PID even before it runs using the following syntax:
bash -c 'echo $$; exec /path/to/my-command'

However, I recommend to stick with $_ or jobs -p method to follow KISS (keep it simple stupid) principle.

You learned how to find and display the process ID of last executed application or programe in Linux and Unix-like system using variuous methods. For more information see bash man page by typing the following man command:
man bash
help jobs

Sample outputs:

jobs: jobs [-lnprs] [jobspec ...] or jobs -x command [args]
    Display status of jobs.
 
    Lists the active jobs.  JOBSPEC restricts output to that job.
    Without options, the status of all active jobs is displayed.
 
    Options:
      -l	lists process IDs in addition to the normal information
      -n	lists only processes that have changed status since the last
    		notification
      -p	lists process IDs only
      -r	restrict output to running jobs
      -s	restrict output to stopped jobs
 
    If -x is supplied, COMMAND is run after all job specifications that
    appear in ARGS have been replaced with the process ID of that job's
    process group leader.
 
    Exit Status:
    Returns success unless an invalid option is given or an error occurs.
    If -x is used, returns the exit status of COMMAND.