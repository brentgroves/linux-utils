643
# https://stackoverflow.com/questions/786376/how-do-i-run-a-program-with-a-different-working-directory-from-current-from-lin
Call the program like this:

(cd /c; /a/helloworld)
The parentheses cause a sub-shell to be spawned. This sub-shell then changes its working directory to /c, then executes helloworld from /a. After the program exits, the sub-shell terminates, returning you to your prompt of the parent shell, in the directory you started from.

Error handling: To avoid running the program without having changed the directory, e.g. when having misspelled /c, make the execution of helloworld conditional:

(cd /c && /a/helloworld)
Reducing memory usage: To avoid having the subshell waste memory while hello world executes, call helloworld via exec:

(cd /c && exec /a/helloworld)