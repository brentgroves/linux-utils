 https://wiki.bash-hackers.org/howto/redirection_tutorial
 
 Closing The File Descriptors
Closing a file through a file descriptor is easy, just make it a duplicate of -. For instance, let's close stdin <&- and stderr 2>&-:

 bash -c '{ lsof -a -p $$ -d0,1,2 ;} <&- 2>&-'
 COMMAND   PID USER   FD   TYPE DEVICE SIZE NODE NAME
 bash    10668 pgas    1u   CHR  136,2         4 /dev/pts/2

 echo $$


https://catonmat.net/bash-one-liners-explained-part-three
Here we simply tell bash to open file for writing and assign it number 4. The file descriptor table looks like this:


As you can see file descriptors don't have to be used in order, you can open any file descriptor number you like from 0 to 255.

Now we can simply write to the file descriptor 4:

$ echo "foo" >&4
And we can close the file descriptor 4:

$ exec 4>&-
It's so simple now once we learned how to work with custom file descriptors!

11. Open a file both for writing and reading

$ exec 3<>file
Here we use bash's diamond operator <>. The diamond operator opens a file descriptor for both reading and writing.

So for example, if you do this:

$ echo "foo bar" > file   # write string "foo bar" to file "file".
$ exec 5<> file           # open "file" for rw and assign it fd 5.
$ read -n 3 var <&5       # read the first 3 characters from fd 5.
$ echo $var

Here we use bash's diamond operator <>. The diamond operator opens a file descriptor for both reading and writing.

So for example, if you do this:

$ echo "foo bar" > file   # write string "foo bar" to file "file".
$ exec 5<> file           # open "file" for rw and assign it fd 5.
$ read -n 3 var <&5       # read the first 3 characters from fd 5.
$ echo $var
This will output foo as we just read the first 3 chars from the file.

Now we can write some stuff to the file:

$ echo -n + >&5           # write "+" at 4th position.
$ exec 5>&-               # close fd 5.
$ cat file

This will output foo+bar as we wrote the + char at 4th position in the file.

12. Send the output from multiple commands to a file

$ (command1; command2) >file
This one-liner uses the (commands) construct that runs the commands a sub-shell. A sub-shell is a child process launched by the current shell.

So what happens here is the commands command1 and command2 get executed in the sub-shell, and bash redirects their output to file.

Execute commands in a shell through a file

Open two shells. In shell 1 do this:

mkfifo fifo
exec < fifo
In shell 2 do this:

exec 3> fifo;
echo 'echo test' >&3
Now take a look in shell 1. It will execute echo test. You can keep writing commands to fifo and shell 1 will keep executing them.

13. Execute commands in a shell through a file

Open two shells. In shell 1 do this:

mkfifo fifo
exec < fifo
In shell 2 do this:

exec 3> fifo;
echo 'echo test' >&3
Now take a look in shell 1. It will execute echo test. You can keep writing commands to fifo and shell 1 will keep executing them.

Here is how it works.

In shell 1 we use the mkfifo command to create a named pipe called fifo. A named pipe (also called a FIFO) is similar to a regular pipe, except that it's accessed as part of the file system. It can be opened by multiple processes for reading or writing. When processes are exchanging data via the FIFO, the kernel passes all data internally without writing it to the file system. Thus, the FIFO special file has no contents on the file system; the file system entry merely serves as a reference point so that processes can access the pipe using a name in the file system.

Next we use exec < fifo to replace current shell's stdin with fifo.

Now in shell 2 we open the named pipe for writing and assign it a custom file descriptor 3. Next we simply write echo test to the file descriptor 3, which goes to fifo.

Since shell 1's stdin is connected to this pipe it executes it! Really simple!

14. Access a website through bash

$ exec 3<>/dev/tcp/www.google.com/80
$ echo -e "GET / HTTP/1.1\n\n" >&3
$ cat <&3

Bash treats the /dev/tcp/host/port as a special file. It doesn't need to exist on your system. This special file is for opening tcp connections through bash.

In this example we first open file descriptor 3 for reading and writing and point it to /dev/tcp/www.google.com/80 special file, which is a connection to www.google.com on port 80.

Next we write GET / HTTP/1.1\n\n to file descriptor 3. And then we simply read the response back from the same file descriptor by using cat.

Similarly you can create a UDP connection through /dev/udp/host/port special file.

With /dev/tcp/host/port you can even write things like port scanners in bash!

This turns on the noclobber option for the current shell. The noclobber option prevents you from overwriting existing files with the > operator.

If you try redirecting output to a file that exists, you'll get an error:

$ program > file
bash: file: cannot overwrite existing file
If you're 100% sure that you want to overwrite the file, use the >| redirection operator:

$ program >| file
This succeeds as it overrides the noclobber option.

$ command | tee file
The tee command is super handy. It's not part of bash but you'll use it often. It takes an input stream and prints it both to standard output and to a file.

In this example it takes the stdout of command, puts it in file, and prints it to stdout.

Here is a graphical illustration of how it works:


17. Send stdout of one process to stdin of another process

$ command1 | command2
This is simple piping. I'm sure everyone is familiar with this. I'm just including it here for completeness. Just to remind you, a pipe connects stdout of command1 with the stdin of command2.

It can be illustrated with a graphic:


As you can see, everything sent to file descriptor 1 (stdout) of command1 gets redirected through a pipe to file descriptor 0 (stdin) of command2.

You can read more about pipes in man 2 pipe.

18. Send stdout and stderr of one process to stdin of another process

$ command1 |& command2
This works on bash versions starting 4.0. The |& redirection operator sends both stdout and stderr of command1 over a pipe to stdin of command2.

As the new features of bash 4.0 aren't widely used, the old, and more portable way to do the same is:

$ command1 2>&1 | command2
Here is an illustration that shows what happens with file descriptors:


First command1's stderr is redirected to stdout, and then a pipe is setup between command1's stdout and command2's stdin.

19. Give file descriptors names

$ exec {filew}>output_file
Named file descriptors is a feature of bash 4.1. Named file descriptors look like {varname}. You can use them just like regular, numeric, file descriptors. Bash internally chooses a free file descriptor and assigns it a name.

20. Order of redirections

You can put the redirections anywhere in the command you want. Check out these 3 examples, they all do the same:

$ echo hello >/tmp/example

$ echo >/tmp/example hello

$ >/tmp/example echo hello
Got to love bash!

21. Swap stdout and stderr

$ command 3>&1 1>&2 2>&3
Here we first duplicate file descriptor 3 to be a copy of stdout. Then we duplicate stdout to be a copy of stderr, and finally we duplicate stderr to be a copy of file descriptor 3, which is stdout. As a result we've swapped stdout and stderr.

Let's go through each redirection with illustrations. Before running the command, we've file descriptors pointing to the terminal:


Next bash setups 3>&1 redirection. This creates file descriptor 3 to be a copy of file descriptor 1:


Next bash setups 1>&2 redirection. This makes file descriptor 1 to be a copy of file descriptor 2:


Next bash setups 2>&3 redirection. This makes file descriptor 2 to be a copy of file descriptor 3:


If we want to be nice citizens we can also close file descriptor 3 as it's no longer needed:

$ command 3>&1 1>&2 2>&3 3>&-
The file descriptor table then looks like this:


As you can see, file descriptors 1 and 2 have been swapped.

22. Send stdout to one process and stderr to another process

$ command > >(stdout_cmd) 2> >(stderr_cmd)
This one-liner uses process substitution. The >(...) operator runs the commands in ... with stdin connected to the read part of an anonymous named pipe. Bash replaces the operator with the filename of the anonymous pipe.

So for example, the first substitution >(stdout_cmd) might return /dev/fd/60, and the second substitution might return /dev/fd/61. Both of these files are named pipes that bash created on the fly. Both named pipes have the commands as readers. The commands wait for someone to write to the pipes so they can read the data.

22. Send stdout to one process and stderr to another process

$ command > >(stdout_cmd) 2> >(stderr_cmd)
This one-liner uses process substitution. The >(...) operator runs the commands in ... with stdin connected to the read part of an anonymous named pipe. Bash replaces the operator with the filename of the anonymous pipe.

So for example, the first substitution >(stdout_cmd) might return /dev/fd/60, and the second substitution might return /dev/fd/61. Both of these files are named pipes that bash created on the fly. Both named pipes have the commands as readers. The commands wait for someone to write to the pipes so they can read the data.

The command then looks like this:

$ command > /dev/fd/60 2> /dev/fd/61
Now these are just simple redirections. Stdout gets redirected to /dev/fd/60, and stderr gets redirected to /dev/fd/61.

When the command writes to stdout, the process behind /dev/fd/60 (process stdout_cmd) reads the data. And when the command writes to stderr, the process behind /dev/fd/61 (process stderr_cmd) reads the data.

command > >(stdout_cmd) 2> >(stderr_cmd)
echo hello > >(grep he) 

23. Find the exit codes of all piped commands

Let's say you run several commands all piped together:

$ cmd1 | cmd2 | cmd3 | cmd4
And you want to find out the exit status codes of all these commands. How do you do it? There is no easy way to get the exit codes of all commands as bash returns only the exit code of the last command.

Bash developers thought about this and they added a special PIPESTATUS array that saves the exit codes of all the commands in the pipe stream.

The elements of the PIPESTATUS array correspond to the exit codes of the commands. Here's an example:

$ echo 'pants are cool' | grep 'moo' | sed 's/o/x/' | awk '{ print $1 }'
$ echo ${PIPESTATUS[@]}
0 1 0 0
In this example grep 'moo' fails, and the 2nd element of the PIPESTATUS array indicates failure.

