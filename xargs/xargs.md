https://www.tecmint.com/xargs-command-examples/

Xargs is a great command that reads streams of data from standard input, then generates and executes command lines; meaning it can take output of a command and passes it as argument of another command. If no command is specified, xargs executes echo by default. You many also instruct it to read data from a file instead of stdin.

There are several ways in which xargs is useful in daily usage of the command line. In this article, we will explain 12 practical Linux xargs command examples for beginners.

1. The first example shows how to find out all the .png images and archive them using the tar utility as follows.

Here, the action command -print0 enables printing of the full file path on the standard output, followed by a null character and -0 xargs flag effectively deals with space in filenames.

$ find Pictures/tecmint/ -name "*.png" -type f -print0 | xargs -0 tar -cvzf images.tar.gz