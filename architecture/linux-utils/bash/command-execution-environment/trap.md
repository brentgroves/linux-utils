https://linuxhint.com/bash_trap_command/#:~:text=A%20built%2Din%20bash%20command,is%20SIGINT%20(Signal%20Interrupt).

A built-in bash command that is used to execute a command when the shell receives any signal is called `trap`. When any event occurs then bash sends the notification by any signal. Many signals are available in bash. The most common signal of bash is SIGINT (Signal Interrupt). When the user presses CTRL+C to interrupt any process from the terminal then this signal is sent to notify the system.  How you can use trap command to handle different types of signals is explained in this tutorial.
Syntax:

trap [-lp] [[arg] signal_spec ...]
or

trap [action] [signal]
Key	Description
-l	It is used to display the list of all signal names with corresponding number.
-p	It is used to display signal command or trap command for signal_spec.
arg	It is used to execute a command when the shell receives the signal(s).
signal_spec	It contains signal name or signal number.
Trap command without arg value or with ‘-‘ arg value will reset the specified signal to its original value.
Trap command with ‘null’ arg value will ignores the specified signal send by the shell or command.
A signal_spec with the value, exit(0) will execute arg after exiting from the shell.
A signal_spec with the value debug will execute arg before each single command.
A signal_spec with the value return will execute arg each time when a shell function executes or a script run by “.”.
A signal_spec with the value err will execute arg every time on command failure.
Trap command without any option and arg
Run the following command from the terminal to display the list of all commands associated with each condition. If any `trap` command is not set before then the following command will not display any information.

$ trap
Trap command with -l option
Run the following command from the terminal to display the list of all signal names with number.

$ trap –l
The output of the above command will show the list of 64 signals with numbers.


Set trap command for ERR and EXIT
The following first command will set a `trap` command that will execute when any shell error occurs or shell exits. This `trap` command will remove temp.txt file from the current location. `ls` command is used to check the temp.txt file exists or not in the current location. Lastly exit command is used to close the terminal and execute the `trap` command that is set before.

$ trap 'rm temp.txt' err exit
$ ls
$ exit
The following output will appear after running the above commands.


Now, if the user opens the terminal again after exit and executes `ls` command then temp.txt file will not exist.

Set `trap` command with signal number of SIGUP, SIGQUIT and SIGKILL
The signal number of SIGUP, SIGQUIT and SIGKILL are 1, 3 and 9. The following first command will set a trap for these three signals. When any of these signal will occur then the message “Trap command is executed” will print.  Run the following command from the terminal.

$ trap 'echo Trap command executed' 1 3 9
When the user will press Ctrl+C to generate the signal assign by `trap` command then the `echo` command of trap command will execute and the following output will appear.


Set `trap` command for SIGTERM in a script
SIGTERM signal is used to terminate the process immediately by releasing its resources. Create a bash file named ‘trapscript.sh’ with the following code. An infinite for loop is declared in the script that will print a text continuously until SIGTERM signal occurs. The user has to press Ctrl+Z to generate SIGTERM signal.

trapscript.sh

#!/bin/bash
 
# Set a trap for SIGINT and SIGTERM signals
trap "echo The program is terminated." SIGTERM SIGINT
 
#Display message to generate SIGTERM
echo "Press Ctrl+Z stop the process"
 
#Initialize counter variable, i
i=1
 
#declare infinite for loop
for(;;)
do
  #Print message with counter i
  echo “running the loop for $i times”
  #Increment the counter by one
  ((i++))
done
Run the script by executing the following command and press Ctrl+Z to generate SIGTERM signal. The following similar output will appear.

$ bash trapscript.sh

Set a `trap` command to run a function based on particular signal
You can associate a `trap` command with any user-defined function. Create a bash named trapfunc.sh and add the following script. Here, a custom function named func() is declared to print a simple message, “Task completed”. A for-in loop is defined to read and print the list of all files and folders of the current working directory. `trap` command that is defined in the beginning of the list will call the function, func() when the program terminates.

trapfunc.sh

#!/bin/bash
# Call func function on exit
trap func exit
# Declare the function
function func() {
 
  echo "Task completed"
}
# Read the files and folders of the current directory list using for loop
for i  in *
do
  echo "$i"
done
Run the script from the terminal.

Run the script.

$ bash trapfunc.sh
The following output shows that, “Task completed” text is printed after printing all files and folders of the current directory.


Conclusion
This tutorial shows how `trap` command can be used in Linux to do any automated task based on generated signal. It helps users to trace different types of errors and take proper action that can be assigned before by using this command. Many programs or scripts allocate some particular resources when running in the system. If any running program or script exit or terminate abnormally then the resources used by that program are blocked. `trap` command can be used to solve this issue. Resource cleaning task can be done easily by using this command. Hope, the reader will get a clear idea of the uses of this command after reading this tutorial.