https://linuxize.com/post/bash-wait/
For example, to wait for a background process with PID 7654, you would use:
wait 7654

When multiple processes are given, the command waits for all processes to complete.

Jobs are specified using the job specification (“jobspec”), which is a way to refer to the processes that make up the job. A jobspec starts with a percentage symbol followed by the job number (%n). Here is an example:

Run a command in a background :
rsync -a /home /tmp/home &
Copy
The shell job ID (surrounded with brackets) and process ID will be displayed on your terminal:

[2] 54377
Copy
To wait for the job, run the wait command followed by the job specification:
wait %2
wait is typically used in shell scripts that spawn child processes that execute in parallel.

A job specification or "jobspec" is a way of referring to the processes that make up a job. A jobspec may be:

%n to refer to job number n.
%str to refer to a job which was started by a command beginning with str. It is an error if there is more than one such job.
%?str to refer to a job which was started by a command containing str. It is an error if there is more than one such job.
%% or %+ to refer to the current job: the one most recently started in the background, or suspended from the foreground. fg and bg will operate on this job if no jobspec is given.
%- for the previous job (the job that was %% before the current one).

To illustrate how the command works, create the following script:

#!/bin/bash
echo "Shell script PID: $$"
sleep 30 &
process_id=$!
echo "Background PID: $process_id"
wait $process_id
echo "Exit status: $?"
Copy

Let’s explain the code line by line:
The first line is called shebang and tells the operating system which interpreter to use to parse the rest of the file.
We are using the sleep command to emulate a time-consuming background process.
$! is an internal Bash variable that stores the PID of the last job run in the background. In this example, that is the PID of the sleep command. We’re storing the PID in a variable (process_id).

Prints the PID number.
The PID is passed to the wait command that waits until the sleep command completes.
Prints the exit status of the wait command. $? is an internal Bash variable that holds the exit status of the last command executed.


If you run the script, it will print something like this:

PID: 36353
Exit status: 0
Copy
Here an example using the -n option:
#!/bin/bash
sleep 3 &
sleep 30 &
sleep 5 &
wait -n
echo "First job completed."
wait
echo "All jobs completed."
Copy
When the script is executed, it spawns 3 background processes. wait -n waits until the first job is completed and the echo statement is printed. wait waits for all child background jobs to complete.
first job completed
all jobs completed
Copy
The last example explains the -f option. Open the terminal and run:

sleep 3600 &
Copy
[1] 46671
Copy
Wait for the process:

wait 46671
Copy
Open another terminal and stop the process with the kill command:

kill -STOP 46671
Copy
Once the process status is changed, the wait command will complete and return the process exit code.
Now, repeat the same steps, but this time use wait -f $pid:

sleep 3600 &
wait -f 46671
CopyCopy
Stop the process from the other terminal:

kill -STOP 46671
Copy
This time the wait command will not complete. It will run until the sleep process terminates.


