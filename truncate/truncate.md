https://computingforgeeks.com/how-to-empty-truncate-log-files-in-linux/
Empty log file using truncate command
The safest method to empty a log file in Linux is by using the truncate command. Truncate command is used to shrink or extend the size of each FILE to the specified size.
truncate -s 0 logfile
Where -s is used to set or adjust the file size by SIZE bytes. The file can be relative to the current directory or an absolute path to the file provided.
Shrink or extend the size of each FILE to the specified size

A FILE argument that does not exist is created.

If a FILE is larger than the specified size, the extra data is lost.
If a FILE is shorter, it is extended and the extended part (hole)
reads as zero bytes.

Mandatory arguments to long options are mandatory for short options too.
  -c, --no-create        do not create any files
  -o, --io-blocks        treat SIZE as number of IO blocks instead of bytes
  -r, --reference=RFILE  base size on RFILE
  -s, --size=SIZE        set or adjust the file size by SIZE bytes
      --help     display this help and exit
      --version  output version information and exit

The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).

SIZE may also be prefixed by one of the following modifying characters:
'+' extend by, '-' reduce by, '<' at most, '>' at least,
'/' round down to multiple of, '%' round up to multi

For multiple files you can use wildcard, example:

truncate -s 0 /var/log/*log
For nested folders:
truncate -s 0 /var/log/**/*.log
Or using for loop and truncate:

for logfile in $(ls /var/log/*.log)
do 
  truncate -s 0 $logfile
done
Empty log file using :> or true >
You can also use :> to clear file content. The syntax is

:> logfile
This is equivalent to

true > logfile