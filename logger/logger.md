logger
https://www.rsyslog.com/doc/

# if logging stops
sudo service rsyslog status
sudo service rsyslog restart

https://www.networkworld.com/article/3274570/using-logger-on-linux.html
The logger command provides an easy way to add messages to the /var/log/syslog file from the command line or from other files.

# you may have to restart service if you doe this
sed -i '1,10d' /var/log/syslog

wc -l /var/log/syslog
1677344


Empty log file using truncate command
The safest method to empty a log file in Linux is by using the truncate command. Truncate command is used to shrink or extend the size of each FILE to the specified size.
truncate -s 0 /var/log/syslog

You are looking for the -p (--priority) option, regardless of the name it supports specifying both facility and priority separated by . (by default it uses user.notice).

For example, for logging a message with auth facility and crit priority:

logger -p 'auth.crit' 'Whatever ...'
then check in /var/log/auth.log (default location for logs belonging to the auth facility).

Similar goes for others. For example, for user facility and info priority:

logger -p 'user.info' 'Whatever ...'