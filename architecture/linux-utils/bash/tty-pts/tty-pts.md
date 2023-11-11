https://www.golinuxcloud.com/difference-between-pty-vs-tty-vs-pts-linux/

tty vs pts
In the article I will give you a brief overview on the difference between /dev/tty and /dev/pts i.e. tty vs pts in Linux.

 

TTY
terminal = tty = text input/output environment
Teletypewriter originally and now also means any terminal on Linux/Unix systems. It also means any serial port on Unix/Linux systems
A tty is a regular terminal device (the console on your server, for example).
tty consoles are managed by systemd in Red Hat Enterprise Linux 7 OS.
tty consoles are created on-the-fly upon access.
The allowed number of consoles can be configured in /etc/systemd/logind.conf file.
Set NAutoVTs= value in this file to desired number to have systemd capable of generating those many tty consoles.
To get the list of open terminals

# ps aux | grep tty
root     10139  0.0  0.0 116428   916 ttyS0    Ss+  May29   0:00 /sbin/agetty --keep-baud 115200 38400 9600 ttyS0 vt220
root     11598  0.0  0.0 121904  2328 tty1     Ss+  May31   0:02 -bash
root     29994  0.0  0.0 116428   900 tty3     Ss+  10:37   0:00 /sbin/agetty --noclear tty3 linux
root     30985  0.0  0.0 116428   900 tty2     Ss+  10:41   0:00 /sbin/agetty --noclear tty2 linux
root     31315  0.0  0.0 112712   956 pts/0    S+   10:43   0:00 grep tty
This continues upto tty6 i.e. default number of allowed tty consoles are 6
One can switch from tty1 to tty6 using Ctrl+Alt+F[1-6] on the console
Below screenshot is from my HP iLO console where you can view the terminal id
Difference between /dev/tty and /dev/pts (tty vs pts) in Linux

 

 

PTS
Stands for pseudo terminal slave.
A pts is the slave part of a pty.
A pty (pseudo terminal device) is a terminal device which is emulated by an other program (example: xterm, screen, or ssh are such programs).
/dev/pts contains entries corresponding to devices. /dev/pts is a special directory that is created dynamically by the Linux kernel. The contents of the directory vary with time and reflect the state of the running system.
The entries in /dev/pts correspond to pseudo-terminals (or pseudo-TTYs, or PTYs).
In laymen terms the primary difference between TTY and PTS is the type of connection to the computer. TTY ports are direct connections to the computer such as a keyboard/mouse or a serial connection to the device. PTS connections are SSH connections or telnet connections. All of these connections can connect to a shell which will allow you to issue commands to the computer.
 

Lastly I hope the steps from the article to understand the difference between tty and pts i.e. tty vs pts on Linux was helpful. So, let me know your suggestions and feedback using the comment section.

 