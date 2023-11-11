https://www.geeksforgeeks.org/chroot-command-in-linux-with-examples/#
chroot command in Linux/Unix system is used to change the root directory. Every process/command in Linux/Unix like systems has a current working directory called root directory. It changes the root directory for currently running processes as well as its child processes.
A process/command that runs in such a modified environment cannot access files outside the root directory. This modified environment is known as “chroot jail” or “jailed directory”. Some root user and privileged process are allowed to use chroot command.

chroot” command can be very useful:

To create a test environment.
To recover the system or password.
To reinstall the bootloader.
Syntax:

chroot /path/to/new/root command

Options:

–userspec=USER:GROUP : This option describe the user and group which is to be used. Either name or numeric ID can be used to specify the user and group.
–groups=G_LIST : It describe the supplementary groups as g1,g2,..,gN.
–help : Shows the help message, and exit.
–version : Gives version information, and exit.
Example:

Step 1: We will create a mini-jail with bash and basic commands only. Let’s create a “jail” directory inside the “home” directory, which will be our new root.
$ mkdir $HOME/jail
Step 2: Create directories inside “$HOME/jail”:
$ mkdir -p $HOME/jail/{bin, lib64}
$ cd $HOME/jail
Step 3: Copy /bin/bash and /bin/ls into $HOME/jail/bin/ location using cp command:
$ cp -v /bin/{bash, ls} $HOME/jail/bin


Step 4: Use ldd command to print shared libraries:
$ ldd /bin/bash

Step 5: Copy required libraries into $HOME/jail/lib64/ location using cp command:
cp -v libraries/displayed/by/above/command $HOME/jail/lib64
Similarly, copy the libraries of ls command into $HOME/jail/lib64 location.

Step 6: Finally, chroot into your mini-jail:
$ sudo chroot $HOME/jail /bin/bash
Now user sees $HOME/jail directory as its root directory. This is a great boost in the security.

https://www.geeksforgeeks.org/linux-virtualization-using-chroot-jail/

