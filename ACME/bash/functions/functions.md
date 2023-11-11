https://www.shellscript.sh/functions.html
One often-overlooked feature of Bourne shell script programming is that you can easily write functions for use within your script. This is generally done in one of two ways; with a simple script, the function is simply declared in the same file as it is called.
However, when writing a suite of scripts, it is often easier to write a "library" of useful functions, and source that file at the start of the other scripts which use the functions. This will be shown later.
The method is the same however it is done; we will primarily be using the first way here. The second (library) method is basically the same, except that the command
. ./library.shgoes at the start of the script.
There could be some confusion about whether to call shell functions procedures or functions; the definition of a function is traditionally that it returns a single value, and does not output anything. A procedure, on the other hand, does not return a value, but may produce output. A shell function may do neither, either or both. It is generally accepted that in shell scripts they are called functions.

A function may return a value in one of four different ways:

Change the state of a variable or variables
Use the exit command to end the shell script
Use the return command to end the function, and return the supplied value to the calling section of the shell script
echo output to stdout, which will be caught by the caller just as c=`expr $a + $b` is caught
This is rather like C, in that exit stops the program, and return returns control to the caller. The difference is that a shell function cannot change its parameters, though it can change global parameters.

A simple script using a function would look like this:

function.sh
#!/bin/sh
# A simple script with a function...

add_a_user()
{
  USER=$1
  PASSWORD=$2
  shift; shift;
  # Having shifted twice, the rest is now comments ...
  COMMENTS=$@
  echo "Adding user $USER ..."
  echo useradd -c "$COMMENTS" $USER
  echo passwd $USER $PASSWORD
  echo "Added user $USER ($COMMENTS) with pass $PASSWORD"
}

###
# Main body of script starts here
###
echo "Start of script..."
add_a_user bob letmein Bob Holness the presenter
add_a_user fred badpassword Fred Durst the singer
add_a_user bilko worsepassword Sgt. Bilko the role model
echo "End of script..."


Line 4 identifies itself as a function declaration by ending in (). This is followed by {, and everything following to the matching } is taken to be the code of that function.
This code is not executed until the function is called. Functions are read in, but basically ignored until they are actually called.

Note that for this example the useradd and passwd commands have been prefixed with echo - this is a useful debugging technique to check that the right commands would be executed. It also means that you can run the script without being root or adding dodgy user accounts to your system!

We have been used to the idea that a shell script is executed sequentially. This is not so with functions.
In this case, the function add_a_user is read in and checked for syntax, but not executed until it is explicitly called. This is where the Shellshock bug of 2014 comes into play. Other commands after the function definition were executed, even though they were not part of the function itself. See http://steve-parker.org/articles/shellshock/ for more information on this.
Execution starts with the echo statement "Start of script...". The next line, add_a_user bob letmein Bob Holness is recognised as a function call so the add_a_user function is entered and starts executing with certain additions to the environment:

$1=bob
$2=letmein
$3=Bob
$4=Holness
$5=the
$6=presenter
So within that function, $1 is set to bob, regardless of what $1 may be set to outside of the function.
So if we want to refer to the "original" $1 inside the function, we have to assign a name to it - such as: A=$1 before we call the function. Then, within the function, we can refer to $A.
We use the shift command again to get the $3 and onwards parameters into $@. The function then adds the user and sets their password. It echoes a comment to that effect, and returns control to the next line of the main code.

Scope of Variables
Programmers used to other languages may be surprised at the scope rules for shell functions. Basically, there is no scoping, other than the parameters ($1, $2, $@, etc).
Taking the following simple code segment:

#!/bin/sh

myfunc()
{
  echo "I was called as : $@"
  x=2
}

### Main script starts here 

echo "Script was called with $@"
x=1
echo "x is $x"
myfunc 1 2 3
echo "x is $x"

The script, when called as scope.sh a b c, gives the following output:
Script was called with a b c
x is 1
I was called as : 1 2 3
x is 2

The $@ parameters are changed within the function to reflect how the function was called. The variable x, however, is effectively a global variable - myfunc changed it, and that change is still effective when control returns to the main script.

A function will be called in a sub-shell if its output is piped somewhere else - that is, "myfunc 1 2 3 | tee out.log" will still say "x is 1" the second time around. This is because a new shell process is called to pipe myfunc(). This can make debugging very frustrating; Astrid had a script which suddenly failed when the "| tee" was added, and it is not immediately obvious why this must be. The tee has to be started up before the function to the left of the pipe; with the simple example of "ls | grep foo", then grep has to be started first, with its stdin then tied to the stdout of ls once ls starts. In the shell script, the shell has already been started before we even knew we were going to pipe through tee, so the operating system has to start tee, then start a new shell to call myfunc(). This is frustrating, but well worth being aware of.

Functions cannot change the values they have been called with, either - this must be done by changing the variables themselves, not the parameters as passed to the script.
An example shows this more clearly:

#!/bin/sh

myfunc()
{
  echo "\$1 is $1"
  echo "\$2 is $2"
  # cannot change $1 - we'd have to say:
  # 1="Goodbye Cruel"
  # which is not a valid syntax. However, we can
  # change $a:
  a="Goodbye Cruel"
}

### Main script starts here 

a=Hello
b=World
myfunc $a $b
echo "a is $a"
echo "b is $b"
This rather cynical function changes $a, so the message "Hello World" becomes "Goodbye Cruel World".

Return Codes
For details about exit codes, see the Exit Codes part of the Hints and Tips section of the tutorial. For now, though we shall briefly look at the return call.

#!/bin/sh

adduser()
{
  USER=$1
  PASSWORD=$2
  shift ; shift
  COMMENTS=$@
  useradd -c "${COMMENTS}" $USER
  if [ "$?" -ne "0" ]; then
    echo "Useradd failed"
    return 1
  fi
  passwd $USER $PASSWORD
  if [ "$?" -ne "0" ]; then
    echo "Setting password failed"
    return 2
  fi
  echo "Added user $USER ($COMMENTS) with pass $PASSWORD"
}

## Main script starts here

adduser bob letmein Bob Holness from Blockbusters
ADDUSER_RETURN_CODE=$?
if [ "$ADDUSER_RETURN_CODE" -eq "1" ]; then
  echo "Something went wrong with useradd"
elif [ "$ADDUSER_RETURN_CODE" -eq "2" ]; then 
   echo "Something went wrong with passwd"
else
  echo "Bob Holness added to the system."
fi
This script checks the two external calls it makes (useradd and passwd), and lets the user know if they fail. The function then defines a return code of 1 to indicate any problem with useradd, and 2 to indicate any problem with passwd. That way, the calling script knows where the problem lay.

For a long time, this tutorial checked "$?" both times, rather than setting ADDUSER_RETURN_CODE=$?, and then looking at the value of ADDUSER_RETURN_CODE each time. This was a bug (thanks to Elyza for pointing it out). You have to save $?, because as soon as you run another command, such as if, its value will be replaced. That is why we save the adduser return value in the $ADDUSER_RETURN_CODE variable, before acting on its content. $ADDUSER_RETURN_CODE is certain to remain the same; $? will change with every command that is executed.