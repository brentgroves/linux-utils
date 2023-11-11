https://linuxhint.com/linux-command-namei-usage/

03: Long List Information
If you want to make your system, list all the other information regarding the specific path, you can also do that with the namei command in the shell. In other words, you can list out all the read, write, and execution rights of a certain path in the shell with the help of a namei command. For this purpose, you have to utilize the “-l” flag for listing the information within the namei command along with the path mentioned in it. Upon the execution of the namei command with the ”-l” command, we have got the result shown below in the image. The output of this command shows the context like “drwxr-xr-x” along with its owner and group information. The character “d” shows that the specific location of a directory. The first three “rwx” character means that the owner has all the rights to read, write and execute on this file. The “r_x” means the group and other users of this system have rights of reading and executing but not writing. These privileges are for all the three mentioned directories. While the file got only the read and write privileges for its owner and group i.e., “rw-rw-“, and other users can only read it. i.e., “i—“.


We have used the namei list command for another path to the file “read.cc”. The output for this command shows the same output as it did for an above path to the file “new.txt”. The directories contain the same privileges, owner, and group information. The file also contains the same owner, group, and privileges as the “new.txt” file got before.

