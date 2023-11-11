https://www.thegeekstuff.com/2010/05/bash-shell-special-parameters/
Example 3: Process related Parameters – $$ and $!
The special parameter $$ will give the process ID of the shell. $! gives you the process id of the most recently executed background process.

The following script prints the process id of the shell and last execute background process ID.

$ cat proc.sh
#!/bin/bash

echo -e "Process ID=$$"

sleep 1000 &

echo -e "Background Process ID=$!"
Now, execute the above script, and check the process id which its printing.

$ ./proc.sh
Process ID=9502
Background Process ID=9503
$ ps
  PID TTY          TIME CMD
 5970 pts/1    00:00:00 bash
 9503 pts/1    00:00:00 sleep
 9504 pts/1    00:00:00 ps
