http://mywiki.wooledge.org/BashFAQ/032

How can I redirect the output of 'time' to a variable or file?
Bash's time keyword uses special trickery, so that you can do things like


time find ... | xargs ...
and get the execution time of the entire pipeline, rather than just the simple command at the start of the pipe. (This is different from the behavior of the external command time(1), for obvious reasons.)

Because of this, people who want to redirect time's output often encounter difficulty figuring out where all the file descriptors are going. It's not as hard as most people think, though -- the trick is to call time in a SubShell or block, and then capture stderr of the subshell or block (which will contain time's results). If you need to redirect the actual command's stdout or stderr, you do that inside the subshell/block. For example:

File redirection:
bash -c "time ls" 2>time.output      # Explicit, but inefficient.
( time ls ) 2>time.output            # Slightly more efficient.
{ time ls; } 2>time.output           # Most efficient.

# The general case:
{ time some command >stdout 2>stderr; } 2>time.output
CommandSubstitution:

foo=$( bash -c "time ls" 2>&1 )       # Captures *everything*.
foo=$( { time ls; } 2>&1 )            # More efficient version.

# Keep stdout unmolested.
# The shell's original FD 1 is saved in FD 3, which is inherited by the subshell.
# Inside the innermost block, we send the time command's stdout to FD 3.
exec 3>&1
foo=$( { time bar 1>&3; } 2>&1 )      # Captures stderr and time.
exec 3>&-

# Keep both stdout and stderr unmolested.
exec 3>&1 4>&2
foo=$( { time bar 1>&3 2>&4; } 2>&1 )  # Captures time only.
exec 3>&- 4>&-

# same thing without exec
{ foo=$( { time bar 1>&3- 2>&4-; } 2>&1 ); } 3>&1 4>&2
See FileDescriptor for full explanations of the redirection juggling.