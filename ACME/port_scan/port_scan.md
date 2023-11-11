https://unix.stackexchange.com/questions/106561/finding-the-pid-of-the-process-using-a-specific-port

Your existing command doesn't work because Linux requires you to either be root or the owner of the process to get the information you desire.

On modern systems, ss is the appropriate tool to use to get this information:

$ sudo ss -lptn 'sport = :80'
State   Local Address:Port  Peer Address:Port              
LISTEN  127.0.0.1:80        *:*                users:(("nginx",pid=125004,fd=12))
LISTEN  ::1:80              :::*               users:(("nginx",pid=125004,fd=11))
You can also use the same invocation you're currently using, but you must first elevate with sudo:

$ sudo netstat -nlp | grep :80
tcp  0  0  0.0.0.0:80  0.0.0.0:*  LISTEN  125004/nginx
You can also use lsof:

$ sudo lsof -n -i :80 | grep LISTEN
nginx   125004 nginx    3u  IPv4   6645      0t0  TCP 0.0.0.0:80 (LISTEN)