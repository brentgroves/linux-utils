https://www.gnu.org/software/bash/manual/bash.html#Pipelines

3.2.7 GNU Parallel
There are ways to run commands in parallel that are not built into Bash. GNU Parallel is a tool to do just that.

GNU Parallel, as its name suggests, can be used to build and run commands in parallel. You may run the same command with different arguments, whether they are filenames, usernames, hostnames, or lines read from files. GNU Parallel provides shorthand references to many of the most common operations (input lines, various portions of the input line, different ways to specify the input source, and so on). Parallel can replace xargs or feed commands from its input sources to several different instances of Bash.

For a complete description, refer to the GNU Parallel documentation. A few examples should provide a brief introduction to its use.

For example, it is easy to replace xargs to gzip all html files in the current directory and its subdirectories:

find . -type f -name '*.html' -print | parallel gzip
If you need to protect special characters such as newlines in file names, use find’s -print0 option and parallel’s -0 option.

You can use Parallel to move files from the current directory when the number of files is too large to process with one mv invocation:

printf '%s\n' * | parallel mv {} destdir
As you can see, the {} is replaced with each line read from standard input. While using ls will work in most instances, it is not sufficient to deal with all filenames. printf is a shell builtin, and therefore is not subject to the kernel’s limit on the number of arguments to a program, so you can use ‘*’ (but see below about the dotglob shell option). If you need to accommodate special characters in filenames, you can use

printf '%s\0' * | parallel -0 mv {} destdir
as alluded to above.

This will run as many mv commands as there are files in the current directory. You can emulate a parallel xargs by adding the -X option:

printf '%s\0' * | parallel -0 -X mv {} destdir
(You may have to modify the pattern if you have the dotglob option enabled.)

GNU Parallel can replace certain common idioms that operate on lines read from a file (in this case, filenames listed one per line):

	while IFS= read -r x; do
		do-something1 "$x" "config-$x"
		do-something2 < "$x"
	done < file | process-output
with a more compact syntax reminiscent of lambdas:

cat list | parallel "do-something1 {} config-{} ; do-something2 < {}" |
           process-output
Parallel provides a built-in mechanism to remove filename extensions, which lends itself to batch file transformations or renaming:

ls *.gz | parallel -j+0 "zcat {} | bzip2 >{.}.bz2 && rm {}"
This will recompress all files in the current directory with names ending in .gz using bzip2, running one job per CPU (-j+0) in parallel. (We use ls for brevity here; using find as above is more robust in the face of filenames containing unexpected characters.) Parallel can take arguments from the command line; the above can also be written as

parallel "zcat {} | bzip2 >{.}.bz2 && rm {}" ::: *.gz
If a command generates output, you may want to preserve the input order in the output. For instance, the following command

{
    echo foss.org.my ;
    echo debian.org ;
    echo freenetproject.org ;
} | parallel traceroute
will display as output the traceroute invocation that finishes first. Adding the -k option

{
    echo foss.org.my ;
    echo debian.org ;
    echo freenetproject.org ;
} | parallel -k traceroute
will ensure that the output of traceroute foss.org.my is displayed first.

Finally, Parallel can be used to run a sequence of shell commands in parallel, similar to ‘cat file | bash’. It is not uncommon to take a list of filenames, create a series of shell commands to operate on them, and feed that list of commands to a shell. Parallel can speed this up. Assuming that file contains a list of shell commands, one per line,

parallel -j 10 < file
will evaluate the commands using the shell (since no explicit command is supplied as an argument), in blocks of ten shell jobs at a time.

