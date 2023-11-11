https://www.educba.com/linux-install-command/

Example #3 – Change the Ownership
In the Linux environment, we can use the install command to change the ownership of the file.

Command

install -D -o educba file1 /owner/
ll /owner/

Explanation

As per the above install command, we are performing the ownership change operation with the help of the “-o” option. We are changing the ownership from “root” user to “educba” user.

Example #4 – Change the Permission Mode
In the install command, we are having the functionality to change the file permission.

Command 

install -D -m 777 file2 /owner/
ll /owner/

Explanation 

As per the above install command, we are performing the permission change operation with the help of the “-m” option. We are changing the file permission from 755 to 777.

The "ll" command is an alias for the "ls -l" command in Linux. It is used to list the files and directories in a directory in a long format. The long format displays additional information about the files and directories, such as their permissions, ownership, size, and timestamps.

In Linux, there are different ways to copy the data from the source location to the destination location. Install is one of the utility to do the same task. It does not only copy the data but also change the ownership and change the permission as well. The install command accepts the different compatible options with location and performs the copy, owner, and permission change task.

Below are the lists of option for the install command.

–backup[=CONTROL]: It will backup each existing destination file
–b: It is similar like –backup option but does not accept an argument
-c: the option is used to ignore
-C: the option is used for the –compare. It will compare each pair of source and destination files.
-d: It is used for the –directory. It will treat all arguments as directory names.
-g: It is used for the –group=GROUP option. It will help to set the group ownership.
-m: It is used for the –mode=MODE option. It will help to set the permission mode.
-o: It is used for the –owner=OWNER option. It will help to set the ownership mode.
-s “–strip”: It is used for the strip symbol table.
-S –suffix=SUFFIX: It is useful to override the usual backup suffix.
-t: It is helpful to copy all the source data or file into the directory.
-T: It will treat the destination is a normal file.
-v: As per the directory creation, it will print the name of each directory –verbose.
-P: It will help to prevent the SELinux security context.
-Z: It will set the security SELinux context of the destination file to be the default type.
Examples to Understand Linux Install Command
Here are the following examples mentioned below:

Example #1 – Install Command
In the Linux environment, we are able to move the files from one location or another location or directory. It is the default nature of the install command.

Command

install test.txt copydata/
ls copydata/

Example #2 – Compare and Copy
In the install command, we are having the functionality to copy the data from one location to another location with the comparison.

Command

install -C /file_data/* copydata/
ls copydata/

Explanation 

We are performing the copy operation with the compare functionality. To perform copy operation with compare, we need to use the “-C” option with the install command.




https://www.geeksforgeeks.org/install-command-in-linux-with-examples/
install [OPTION]... [-T] SOURCE DEST
install [OPTION]... SOURCE... DIRECTORY
install [OPTION]... -t DIRECTORY SOURCE...
install [OPTION]... -d DIRECTORY...
Here, the first three forms are used to copy the SOURCE to DEST or multiple SOURCE(s) to the existing DIRECTORY while setting permission modes and owner/group. But the fourth form is used to create all components of the given DIRECTORY.

Options:

–backup[=CONTROL] : This option is used to create a backup of each existing destination file.
-b : Like –backup but It will not accept an argument.
-C, –compare : Used to compare each pair of source and destination files. But in some cases it does not modify the destination.
-d, –directory : It will act as directory names towards all arguments. And create all components of the specified directories.
-g, –group=GROUP : Used to set group ownership, instead of processing the current group.
-m, –mode=MODE : Set permission mode (as in chmod).
-o, –owner=OWNER : Set ownership (super-user only).
-p, –preserve-timestamps : Apply access/modification times of SOURCE files to corresponding destination files
-t, –target-directory=DIRECTORY : Copy all SOURCE arguments into DIRECTORY.
-T, –no-target-directory : Treat DEST as a normal file.
-v, –verbose : Used to show the name of each directory as it is created.
–help : Display the help message and exit.
–version : Shows the version information and exit.
