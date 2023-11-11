https://www.gnu.org/software/bash/manual/html_node/Command-Grouping.html
3.2.5.3 Grouping Commands
Bash provides two ways to group a list of commands to be executed as a unit. When commands are grouped, redirections may be applied to the entire command list. For example, the output of all the commands in the list may be redirected to a single stream.

()
( list )
Placing a list of commands between parentheses causes a subshell environment to be created (see Command Execution Environment), and each of the commands in list to be executed in that subshell. Since the list is executed in a subshell, variable assignments do not remain in effect after the subshell completes.


{}
{ list; }
Placing a list of commands between curly braces causes the list to be executed in the current shell context. No subshell is created. The semicolon (or newline) following list is required.

In addition to the creation of a subshell, there is a subtle difference between these two constructs due to historical reasons. The braces are reserved words, so they must be separated from the list by blanks or other shell metacharacters. The parentheses are operators, and are recognized as separate tokens by the shell even if they are not separated from the list by whitespace.

The exit status of both of these constructs is the exit status of list.
https://www.gnu.org/software/bash/manual/bash.html#Pipelines
Bash provides two ways to group a list of commands to be executed as a unit. When commands are grouped, redirections may be applied to the entire command list. For example, the output of all the commands in the list may be redirected to a single stream.

()
( list )
Placing a list of commands between parentheses causes a subshell environment to be created (see Command Execution Environment), and each of the commands in list to be executed in that subshell. Since the list is executed in a subshell, variable assignments do not remain in effect after the subshell completes.

{}
{}
{ list; }
Placing a list of commands between curly braces causes the list to be executed in the current shell context. No subshell is created. The semicolon (or newline) following list is required.

In addition to the creation of a subshell, there is a subtle difference between these two constructs due to historical reasons. The braces are reserved words, so they must be separated from the list by blanks or other shell metacharacters. The parentheses are operators, and are recognized as separate tokens by the shell even if they are not separated from the list by whitespace.

The exit status of both of these constructs is the exit status of list.

3.2.6 Coprocesses
A coprocess is a shell command preceded by the coproc reserved word. A coprocess is executed asynchronously in a subshell, as if the command had been terminated with the ‘&’ control operator, with a two-way pipe established between the executing shell and the coprocess.

The format for a coprocess is:

coproc [NAME] command [redirections]
This creates a coprocess named NAME. If NAME is not supplied, the default name is COPROC. NAME must not be supplied if command is a simple command (see Simple Commands); otherwise, it is interpreted as the first word of the simple command.

When the coprocess is executed, the shell creates an array variable (see Arrays) named NAME in the context of the executing shell. The standard output of command is connected via a pipe to a file descriptor in the executing shell, and that file descriptor is assigned to NAME[0]. The standard input of command is connected via a pipe to a file descriptor in the executing shell, and that file descriptor is assigned to NAME[1]. This pipe is established before any redirections specified by the command (see Redirections). The file descriptors can be utilized as arguments to shell commands and redirections using standard word expansions. Other than those created to execute command and process substitutions, the file descriptors are not available in subshells.

The process ID of the shell spawned to execute the coprocess is available as the value of the variable NAME_PID. The wait builtin command may be used to wait for the coprocess to terminate.

Since the coprocess is created as an asynchronous command, the coproc command always returns success. The return status of a coprocess is the exit status of command.

Previous: Coprocesses, Up: Shell Commands   [Contents][Index]

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