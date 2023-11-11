https://catonmat.net/bash-one-liners-explained-part-three
Redirect a single line of text to the stdin of a command

$ command &lt;&lt;&lt; "foo bar baz"
For example, let's say you quickly want to pass the text in your clipboard as the stdin to a command. Instead of doing something like:

$ echo "clipboard contents" | command
You can now just write:

$ command &lt;&lt;&lt; "clipboard contents"
This trick changed my life when I learned it!
 Redirect stderr of all commands to a file forever

$ exec 2>file
$ command1
$ command2
$ ...
This one-liner uses the built-in exec bash command. If you specify redirects after it, then they will last forever, meaning until you change them or exit the script/shell.

In this case the 2>file redirect is setup that redirects the stderr of the current shell to the file. Running commands after setting up this redirect will have the stderr of all of them redirected to file. It's really useful in situations when you want to have a complete log of all errors that happened in the script, but you don't want to specify 2>file after every single command!

In general exec can take an optional argument of a command. If it's specified, bash replaces itself with the command. So what you get is only that command running, and there is no more shell.

pen a file for reading using a custom file descriptor

$ exec 3&lt;file
Here we use the exec command again and specify the 3<file redirect to it. What this does is opens the file for reading and assigns the opened file-descriptor to the shell's file descriptor number 3. The file descriptor table now looks like this:


Now you can read from the file descriptor 3, like this:

$ read -u 3 line
This reads a line from the file that we just opened as fd 3.

Or you can use regular shell commands such as grep and operate on file descriptor 3:

$ grep "foo" <&3
What happens here is file descriptor 3 gets duplicated to file descriptor 1 - stdin of grep. Just remember that once you read the file descriptor it's been exhausted and you need to close it and open it again to use it. (You can't rewind an fd in bash.)

After you're done using fd 3, you can close it this way:

$ exec 3>&-
Here the file descriptor 3 is duped to -, which is bash's special way to say "close this fd".

10. Open a file for writing using a custom file descriptor

$ exec 4>file

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


