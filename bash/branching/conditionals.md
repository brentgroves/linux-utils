https://data-skills.github.io/unix-and-bash/03-bash-scripts/index.html
Conditionals in a Bash Script: if Statements
Like other scripting languages, Bash supports the standard if conditional statement. What makes Bash a bit unique is that a command’s exit status provides the true and false (remember: contrary to other languages, 0 represents true/success and anything else is false/failure). The basic syntax is:

if [commands] then
    [if-statements] 
else
    [else-statements] 
fi
were [commands] is a placeholder for any command, set of commands, pipeline, or test condition [if-statements] is a placeholder for all statements executed if [commands] evaluates to true (0). [else-statements] is a placeholder for all statements executed if [commands] evaluates to false (1). The else block is optional.

This is an advantage Bash has over Python when writing pipelines: Bash allows your scripts to directly work with command-line programs without requiring any overhead to call programs.

For example, suppose we wanted to run a set of commands only if a file contains a certain string. Because grep returns 0 only if it matches a pattern in a file and 1 otherwise, we could use:

echo `#!/bin/bash
if grep "pattern" some_file.txt > /dev/null 
    then
    # commands to run if "pattern" is found
    echo "found 'pattern' in 'some_file.txt" 
fi`
The set of commands in an if condition can use all features of Unix we’ve mastered so far. For example, chaining commands with logical operators like && (logical AND) and || (logical OR):

#!/bin/bash
if grep "pattern" file_1.txt > /dev/null && grep "pattern" file_2.txt > /dev/null
  then echo "found 'pattern' in 'file_1.txt' and in 'file_2.txt'" 
fi
# We can also negate our program’s exit status with !: 
# if ! grep "pattern" some_file.txt > /dev/null 
  # then echo "did not find 'pattern' in 'some_file.txt" 
# fi

Finally, it’s possible to use pipelines in if condition statements. Note, however, that the behavior depends on set -o pipefail. If pipefail is set, any nonzero exit status in a pipe in your condition statement will cause skipping the if-statements section (and going on to the else block if it exists).

