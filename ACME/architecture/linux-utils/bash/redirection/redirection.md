https://wiki.bash-hackers.org/howto/redirection_tutorial

stdin, stdout, stderr
When Bash starts, normally, 3 file descriptors are opened, 0, 1 and 2 also known as standard input (stdin), standard output (stdout) and standard error (stderr).

For example, with Bash running in a Linux terminal emulator, you'll see:

# lsof +f g -ap $BASHPID -d 0,1,2
COMMAND   PID USER   FD   TYPE FILE-FLAG DEVICE SIZE/OFF NODE NAME
bash    12135 root    0u   CHR     RW,LG 136,13      0t0   16 /dev/pts/5
bash    12135 root    1u   CHR     RW,LG 136,13      0t0   16 /dev/pts/5
bash    12135 root    2u   CHR     RW,LG 136,13      0t0   16 /dev/pts/5

https://catonmat.net/bash-one-liners-explained-part-three
command >file 2>&1
Is not the same as writing:

$ command 2>&1 >file
The order of redirects matters in bash! This command redirects only the standard output to the file. The stderr will still print to the terminal. To understand why that happens, let's go through the steps again. So before running the command the file descriptor table looks like this:

Working with redirections in bash is really easy once you realize that it's all about manipulating file descriptors. When bash starts it opens the three standard file descriptors: stdin (file descriptor 0), stdout (file descriptor 1), and stderr (file descriptor 2). You can open more file descriptors (such as 3, 4, 5, ...), and you can close them. You can also copy file descriptors. And you can write to them and read from them.

File descriptors always point to some file (unless they're closed). Usually when bash starts all three file descriptors, stdin, stdout, and stderr, point to your terminal. The input is read from what you type in the terminal and both outputs are sent to the terminal.

Assuming your terminal is /dev/tty0, here is how the file descriptor table looks like when bash starts:


When bash runs a command it forks a child process (see man 2 fork) that inherits all the file descriptors from the parent process, then it sets up the redirections that you specified, and execs the command (see man 3 exec).

To be a pro at bash redirections all you need to do is visualize how the file descriptors get changed when redirections happen. The graphics illustrations will help you.

1. Redirect the standard output of a command to a file

$ command >file
Operator > is the output redirection operator. Bash first tries to open the file for writing and if it succeeds it sends the stdout of command to the newly opened file. If it fails opening the file, the whole command fails.

Writing command >file is the same as writing command 1>file. The number 1 stands for stdout, which is the file descriptor number for standard output.

Here is how the file descriptor table changes. Bash opens file and replaces file descriptor 1 with the file descriptor that points to file. So all the output that gets written to file descriptor 1 from now on ends up being written to file:


In general you can write command n>file, which will redirect the file descriptor n to file.

For example,

$ ls > file_list
Redirects the output of the ls command to the file_list file.

2. Redirect the standard error of a command to a file

$ command 2> file
Here bash redirects the stderr to file. The number 2 stands for stderr.

Here is how the file descriptor table changes:


Bash opens file for writing, gets the file descriptor for this file, and it replaces file descriptor 2 with the file descriptor of this file. So now anything written to stderr gets written to file.

3. Redirect both standard output and standard error to a file

$ command &>file
This one-liner uses the &> operator to redirect both output streams - stdout and stderr - from command to file. This is bash's shortcut for quickly redirecting both streams to the same destination.

Here is how the file descriptor table looks like after bash has redirected both streams:


As you can see both stdout and stderr now point to file. So anything written to stdout and stderr gets written to file.

There are several ways to redirect both streams to the same destination. You can redirect each stream one after another:

$ command >file 2>&1
This is a much more common way to redirect both streams to a file. First stdout is redirected to file, and then stderr is duplicated to be the same as stdout. So both streams end up pointing to file.

When bash sees several redirections it processes them from left to right. Let's go through the steps and see how that happens. Before running any commands bash's file descriptor table looks like this:

Now bash processes the first redirection >file. We've seen this before and it makes stdout point to file:


Next bash sees the second redirection 2>&1. We haven't seen this redirection before. This one duplicates file descriptor 2 to be a copy of file descriptor 1 and we get:


Both streams have been redirected to file.

However be careful here! Writing:

command >file 2>&1
Is not the same as writing:

$ command 2>&1 >file
The order of redirects matters in bash! This command redirects only the standard output to the file. The stderr will still print to the terminal. To understand why that happens, let's go through the steps again. So before running the command the file descriptor table looks like this:

Now bash processes redirections left to right. It first sees 2>&1 so it duplicates stderr to stdout. The file descriptor table becomes:


Now bash sees the second redirect >file and it redirects stdout to file:


Do you see what happens here? Stdout now points to file but the stderr still points to the terminal! Everything that gets written to stderr still gets printed out to the screen! So be very, very careful with the order of redirects!

Also note that in bash, writing this:

$ command &>file
Is exactly the same as:

$ command >&file
The first form is preferred however.

4. Discard the standard output of a command

$ command > /dev/null
The special file /dev/null discards all data written to it. So what we're doing here is redirecting stdout to this special file and it gets discarded. Here is how it looks from the file descriptor table's perspective:


Similarly, by combining the previous one-liners, we can discard both stdout and stderr by doing:

$ command >/dev/null 2>&1
Or just simply:

$ command &>/dev/null
File descriptor table for this feat looks like this:


5. Redirect the contents of a file to the stdin of a command

$ command &lt;file
Here bash tries to open the file for reading before running any commands. If opening the file fails, bash quits with error and doesn't run the command. If opening the file succeeds, bash uses the file descriptor of the opened file as the stdin file descriptor for the command.

After doing that the file descriptor table looks like this:


Here is an example. Suppose you want to read the first line of the file in a variable. You can simply do this:

$ read -r line < file
Bash's built-in read command reads a single line from standard input. By using the input redirection operator < we set it up to read the line from the file.

6. Redirect a bunch of text to the stdin of a command

$ command &lt;&lt;EOL
your
multi-line
text
goes
here
EOL
Here we use the here-document redirection operator <<MARKER. This operator instructs bash to read the input from stdin until a line containing only MARKER is found. At this point bash passes the all the input read so far to the stdin of the command.

Here is a common example. Suppose you've copied a bunch of URLs to the clipboard and you want to remove http:// part of them. A quick one-liner to do this would be:

$ sed 's|http://||' <<EOL
http://url1.com
http://url2.com
http://url3.com
EOL
Here the input of a list of URLs is redirected to the sed command that strips http:// from the input.

This example produces this output:

url1.com
url2.com
url3.com
7. Redirect a single line of text to the stdin of a command

$ command &lt;&lt;&lt; "foo bar baz"

https://linuxize.com/post/bash-redirect-stderr-stdout/
http://mywiki.wooledge.org/BashFAQ/032

How to redirect stderr to variable 
Then call python to use variable as a parameter of the stored procedure

When redirecting the output of a command to a file or piping it to another command, you might notice that the error messages are printed on the screen.

In Bash and other Linux shells, when a program is executed, it uses three standard I/O streams. Each stream is represented by a numeric file descriptor:
0 - stdin, the standard input stream.
1 - stdout, the standard output stream.
2 - stderr, the standard error stream.
A file descriptor is just a number representing an open file.
The input stream provides information to the program, generally by typing in the keyboard.

The program output goes to the standard input stream and the error messages goes to the standard error stream. By default, both input and error streams are printed on the screen.
Redirecting Output
Redirection is a way to capture the output from a program and send it as input to another program or file.
Streams can be redirected using the n> operator, where n is the file descriptor number.
When n is omitted, it defaults to 1, the standard output stream. For example, the following two commands are the same; both will redirect the command output (stdout) to the file.

command > file
Redirecting Output
Redirection is a way to capture the output from a program and send it as input to another program or file.
Streams can be redirected using the n> operator, where n is the file descriptor number.
When n is omitted, it defaults to 1, the standard output stream. For example, the following two commands are the same; both will redirect the command output (stdout) to the file.

command > file
Copy
command 1> file
Copy
To redirect the standard error (stderr) use the 2> operator:

command 2> file
Copy
You can write both stderr and stdout to two separate files:

command 2> error.txt 1> output.txt
Copy
To suppress the error messages from being displayed on the screen, redirect stderr to /dev/null:

command 2> /dev/null

Redirecting stderr to stdout
When saving the program’s output to a file, it is quite common to redirect stderr to stdout so that you can have everything in a single file.
To redirect stderr to stdout and have error messages sent to the same file as standard output, use the following:
command > file 2>&1
Copy

> file redirect the stdout to file, and 2>&1 redirect the stderr to the current location of stdout.

The order of redirection is important. For example, the following example redirects only stdout to file. This happens because the stderr is redirected to stdout before the stdout was redirected to file.

command 2>&1 > file 
Copy
Another way to redirect stderr to stdout is to use the &> construct. In Bash &> has the same meaning as 2>&1:
command &> file
Copy
Conclusion
Understanding the concept of redirections and file descriptors is very important when working on the command line.

To redirect stderr and stdout, use the 2>&1 or &> constructs.

If you have any questions or feedback, feel free to leave a comment.

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

How to redirect stderr to variable 
Then call python to use variable as a parameter of the stored procedure
