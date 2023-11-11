<!-- https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425 -->
# The set -e option instructs bash to immediately exit if any command [1] has a non-zero exit status.
set -e
# Affects variables. When set, a reference to any variable you haven't previously defined - with the exceptions of @ - is an error, and causes the program to immediately exit.
set -u
# This setting prevents errors in a pipeline from being masked. If any command in a pipeline fails, that return code will be used as the return code of the whole pipeline. By default, the pipeline's return code is that of the last command even if it succeeds.
set -o pipefail
# Enables a mode of the shell where all executed commands are printed to the terminal.
set -x
# The IFS variable - which stands for Internal Field Separator - controls what Bash calls word splitting.
# IFS=$' '
# IFS=$'\n'

http://redsymbol.net/articles/unofficial-bash-strict-mode/#expect-nonzero-exit-status
Commands You Expect To Have Nonzero Exit Status
What happens when you want to run a command that will fail, or which you know will have a nonzero exit code? You don't want it to stop your script, because that's actually correct behavior.

There are two choices here. The simplest, which you will usually want to use, is to append "|| true" after the command:

# "grep -c" reports the number of matching lines. If the number is 0,
# then grep's exit status is 1, but we don't care - we just want to
# know the number of matches, even if that number is zero.

# Under strict mode, the next line aborts with an error:
count=$(grep -c some-string some-file)

# But this one behaves more nicely:
count=$(grep -c some-string some-file || true)

echo "count: $count"
This short-circuiting with the boolean operator makes the expression inside $( ... ) always evaluate successfully.

You will probably find that trick almost always solves your problem. But what if you want to know the return value of a command, even if that return value is nonzero? Then you can temporarily disable the exit-immediately option:

# We had started out this script with set -e . And then...

set +e
count=$(grep -c some-string some-file)
retval=$?
set -e

# grep's return code is 0 when one or more lines match;
# 1 if no lines match; and 2 on an error. This pattern
# lets us distinguish between them.

echo "return value: $retval"
echo "count: $count"
