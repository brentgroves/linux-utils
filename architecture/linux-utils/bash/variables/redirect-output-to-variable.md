https://stackoverflow.com/questions/2559076/how-do-i-redirect-output-to-a-variable-in-shell
To store "abc" into $foo:

echo "abc" | read foo
But, because pipes create forks, you have to use $foo before the pipe ends, so...

echo "abc" | ( read foo; date +"I received $foo on %D"; )
Sure, all these other answers show ways to not do what the OP asked, but that really screws up the rest of us who searched for the OP's question.

The answer to the question is to use the read command.
Here's how you do it
# I would usually do this on one line, but for readability...
series | of | commands \
| \
(
  read string;
  mystic_command --opt "$string" /path/to/file
) \
| \
handle_mystified_file
Here is what it is doing and why it is important:
Let's pretend that the series | of | commands is a very complicated series of piped commands.

mystic_command can accept the content of a file as stdin in lieu of a file path, but not the --opt arg therefore it must come in as a variable. The command outputs the modified content and would commonly be redirected into a file or piped to another command. (E.g. sed, awk, perl, etc.)

read takes stdin and places it into the variable $string

Putting the read and the mystic_command into a "sub shell" via parenthesis is not necessary but makes it flow like a continuous pipe as if the 2 commands where in a separate script file.

There is always an alternative, and in this case the alternative is ugly and unreadable compared to my example above.

# my example above as a oneliner
series | of | commands | (read string; mystic_command --opt "$string" /path/to/file) | handle_mystified_file

# ugly and unreadable alternative
mystic_command --opt "$(series | of | commands)" /path/to/file | handle_mystified_file
My way is entirely chronological and logical. The alternative starts with the 4th command and shoves commands 1, 2, and 3 into command substitution.

I have a real world example of this in this script but I didn't use it as the example above because it has some other crazy/confusing/distracting bash magic going on also.

