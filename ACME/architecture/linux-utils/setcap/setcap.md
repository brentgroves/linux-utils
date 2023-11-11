From example-app laravel dockerfile:
RUN setcap "cap_net_bind_service=+ep" /usr/bin/php8.2

https://tbhaxor.com/understanding-linux-capabilities/
Understanding Linux Capabilities
Get a basic understanding of what Linux capabilities are and how to use the utility tools like capsh, setcap and getcap to manage or print capabilities of program files and running processes or tasks

You have learned so many misconfigurations on the Linux system that allow attackers to gain privileged shells. This is because even if a program is supposed to perform a specific system-level task, it needs to have the EUID of the root user thus making it vulnerable for attackers to use perform privilege escalation. Let's call this binary system of permissions, which will start two types of process – privileged (EUID == 0) and unprivileged (EUID != 0)

To prevent this, Linux developers have thought and sorted all the privileged tasks into a set of ~40 (as of now) capabilities. So for example, if you want to read a privileged file, you as an administrator allow the running process or program file to allow CAP_DAC_READ_SEARCH privilege, bypassing file read permission checks and directory read and execute permission checks. In this, a non-privileged user can only perform the specific tasks of reading any file and perform a search in protected directories, malicious use like setting UID to 0 and then spawn shell is not possible.

In this post, I will touch upon the brilliant idea of capabilities introduced in the Linux kernel and in my upcoming posts, I will discuss how an attacker can exploit these capabilities when allowed on unusual programs like interpreters

What are the Linux capabilities anyway?
Well, the answer is pretty simple – A granular set of permissions assigned to a running program or thread or even a program file by root user to allow process use privileged (system-level tasks) like killing process owned by different users from a shell of a low privileged user. Each capability provides one or more sets of related privileges to the process. All of them are listed and well explained in capabilities(7) man page

Unlike the DAC / MAC permissions I have discussed in my earlier posts, capabilities can be set or unset in the running process if they are in the permitted set (discussed below). Only a particular set of capabilities are checked by the kernel

NOTE: If a thread is running with the Effective UID value 0, initially it will have all the capabilities enabled.

Where are Capabilities Records Stored?
Extended permissions such as access control lists set by setfacl and capability flags set by setcap which use setxattr(2) are stored in the same place as traditional permissions and set[ug]id flags set by chmod –  in the file's inode.

I have a binary file with some capabilities set already. When I performed getfattr on the file, I found that the information is stored in security.capability section. The syscall used to get extra file attributes is

$ strace -e getxattr getfattr -d -m - cat 
getxattr("cat", "security.capability", NULL, 0) = 20
getxattr("cat", "security.capability", "\1\0\0\2\200\0\0\0\200\0\0\0\0\0\0\0\0\0\0", 256) = 20
# file: cat
security.capability=0sAQAAAoAAAACAAAAAAAAAAAAAAAA=

Type of Capabilities Sets
The capabilities actually come into action during the execution of the process. The kernel will only check for them when the program tries to perform special system calls.

Each process have 5 different sets of capabilities from the list of all capabilities

Effective — Capabilities used by the kernel to perform permission checks for the thread. So if you perform any privileged task and its capability is not in this set, it will throw an "Operation not permitted" error. You can check using EPERM enum.
Permitted — It is a superset for the effective capabilities that the process may assume. If the capability is available in this set, a process transitions it to an effective set and drops it later. But once a process has dropped capability from the permitted set, it can not re-aquire
Inheritable — This set is reserved for execve() syscall. If the capability is set to inheritable, it will be added permitted set when the program is executed with execve() syscall
Bounding — It is the superset of all the capabilities allowed to the thread. That means no process can have the capability from outside this set.
Ambient — This set is also reserved for execve() syscall, but for non-privileged files. You can control them via prctl(), this can not be set via CLI utilities

A binary can be called capability aware if it can actively transition the permitted capabilities to effective using syscalls like capget, capset or prctl. On another hand, a capability unaware binary doesn't have this privilege, to make the capabilities set effective either it's inherited by the parent process or while loading the program in the memory

These sets are well explained on hacktricks gitbook. To know more, visit – https://book.hacktricks.xyz/linux-unix/privilege-escalation/linux-capabilities#capabilities-sets

Capabilities In Action
There are three CLI utilities to manage the capabilities in Linux

capsh — print the capabilities of the current context or decode the hex-encoded capabilities in the running process status 
grep Cap /proc/PID/status
setcap — set or unset the capabilities to regular files
getcap — get the decoded set of capabilities from the file or recursively in directories

The current running process is a shell with normal users, and for a normal user process, by default, there are no capabilities. You can verify it by executing capsh --print. If the capability set show =ep, that means it has all the capabilities from the bounding set

$ capsh --print
Current: =
Bounding set =cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner, ... trimmed
$ sudo capsh --print
Current: =ep
Bounding set =cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner ... trimmed

All the capabilities for processes and threads are stored in the status file under the process/thread directory in the /proc file system. These properties start "Cap" name.

You can also do the above by grepping "Cap" from /proc/$$/status. In this case, $$ will give the current process ID, which is of course shell

$ grep Cap /proc/$$/task/$$/status

$ sudo su -c sh
# grep Cap /proc/$$/task/$$/status
CapInh:	0000000000000000
CapPrm:	000001ffffffffff
CapEff:	000001ffffffffff
CapBnd:	000001ffffffffff
CapAmb:	0000000000000000
# capsh --decode=000001ffffffffff
0x000001ffffffffff=cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid, ... trimmed

In the current directory, I have only one file which is a python interpreter with group and owner both set to terabyte user. Since this binary has cap_setuid capability set in the effective set, I can perform setuid operation without having the effective uid set to 0

$ ls -l python 
-rwxr-xr-x 1 terabyte terabyte 14168 Aug 25 11:30 python
$ python -q
>>> import os
>>> os.geteuid()
1000
>>> os.setuid(0)
>>> os.system("/bin/sh")
sh-5.1# whoami 
root

Alternatively, for a running process, you can get the hex-encoded capabilities and then later decode it with capsh.

$ grep /proc/$(pgrep python)/status
CapInh: 0000000000000000
CapPrm: 0000000000000080
CapEff: 0000000000000080
CapBnd: 000001ffffffffff
CapAmb: 0000000000000000
$ capsh --decode=0000000000000080
0x0000000000000080=cap_setuid
$ capsh --decode=000001ffffffffff
0x000001ffffffffff=cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap ... trimmed

In Linux the threads are located under /proc/PID/tasks and the status of each task is stored in their individual status file, /proc/PID/tasks/TID/status

$ ls  /proc/60928/task/
60928  60937  60943  60944  60945  ...trimmed
$ grep Cap /proc/60928/task/60937/status 
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000
CapBnd: 000001ffffffffff
CapAmb: 0000000000000000
$ capsh --decode=000001ffffffffff
0x000001ffffffffff=cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner ...trimmed
Getting the capabilities of a specific thread in the process
I didn't check for the 60928 because that is the task id of the main thread. If there is no thread in the process, the kernel automatically kills the process. So to avoid that, a task of the main process is created with the same id as the process

Ping command is supposed to be working for every user to check network connectivity by pinging other live hosts on the network. At its core, the ping command uses special system privilege to handle raw packets directly from the kernel. In the first case, the ping command has CAP_NET_RAW so it went ahead and sent ICMP packet on localhost. Just below the successful execution, I dropped it from the bounding set. So it will not be available in either of permitted or effective set

$ ping -c 1 localhost 
PING localhost(localhost (::1)) 56 data bytes
64 bytes from localhost (::1): icmp_seq=1 ttl=64 time=0.050 ms

--- localhost ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.050/0.050/0.050/0.000 ms
$ capsh --drop=cap_net_raw --print -- -c "/bin/ping -c 1 localhost"
unable to raise CAP_SETPCAP for BSET changes: Operation not permitted


