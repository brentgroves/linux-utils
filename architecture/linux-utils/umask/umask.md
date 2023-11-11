https://www.cyberciti.biz/tips/understanding-linux-unix-umask-value-usage.html
But, how do I calculate umask value under Linux?
The octal umasks are calculated via the bitwise AND of the unary complement of the argument using bitwise NOT. The octal notations are as follows:

Octal value : Permission
0 : read, write and execute
1 : read and write
2 : read and execute
3 : read only
4 : write and execute
5 : write only
6 : execute only
7 : no permissions
Now, you can use above table to calculate file permission. For example, if umask is set to 077, the permission can be calculated as follows:

Bit	Targeted at	File permission
0	Owner	read, write and execute
7	Group	No permissions
7	Others	No permissions