https://wiki.ubuntu.com/Valgrind
https://askubuntu.com/questions/1019721/using-time-v-to-calculate-execution-time-command-not-found
https://valgrind.org/docs/manual/quick-start.html
date +"%T" && cp -r ./file  /destination/folder/here && date +"%T"

Valgrind is a suite of tools for debugging and profiling programs. There are three tools: a memory error detector, a time profiler, and a space profiler.

For debugging purposes, the memory error detector is a handy tool.

Memory error detection
The most important of these is the memory error detector, which tracks the usage of every single bit in a program, and warns if there's something suspicious. Valgrind can detect if memory is used before it has a value, memory is leaked, or memory is used twice.

This makes it ideal for tracking down segmentation faults, bus errors, and general memory leaks.

Warning /!\ Please ensure you have packages with debug symbols installed. You can do this by following the instructions at DebuggingProgramCrash.

Make sure Valgrind is installed.

sudo apt-get install valgrind
Remove any old Valgrind logs:

rm valgrind.log*
Start the program under control of memcheck:


G_SLICE=always-malloc G_DEBUG=gc-friendly  valgrind -v --tool=memcheck --leak-check=full --num-callers=40 --log-file=valgrind.log $(which <program>) <arguments>
N.B. valgrind can't solve paths, so you should feed it the full program path, to get it: $(which <program>)

The program will start. It may take a while; this is normal, because Valgrind must perform extensive checking to detect memory errors.
Perform any actions necessary to reproduce the crash.
Package up the log files (no need if there is only one):

tar -zcf valgrind-logs-<program>.tar.gz valgrind.log*
Attach the complete output from Valgrind, contained in valgrind-logs-<program>.tar.gz, in your bug report.

