https://www.nginx.com/resources/wiki/start/topics/tutorials/commandline/

You do not need to restart container to reload new config. Nginx can hot-reload config without restarting.

Once you have mounted volume, you can make changes and they will be reflected in container immediately.

To test your config just execute this command:

docker exec nginx-test nginx -t
To reload new config:

docker exec nginx-test nginx -s reload

Starting, Stopping, and Restarting NGINX
This page shows you how to start NGINX, and once it’s running, how to control it so that it will stop or restart.

Starting NGINX
NGINX is invoked from the command line, usually from /usr/bin/nginx.

Basic Example of Starting NGINX
/usr/bin/nginx
Advanced Example of Starting NGINX
/usr/bin/nginx -t -c ~/mynginx.conf -g "pid /var/run/nginx.pid; worker_processes 2;"
Options
-?, -h	Print help.
-v	Print version.
-V	Print NGINX version, compiler version and configure parameters.
-t	Don’t run, just test the configuration file. NGINX checks configuration for correct syntax and then try to open files referred in configuration.
-q	Suppress non-error messages during configuration testing.
-s signal	Send signal to a master process: stop, quit, reopen, reload. (version >= 0.7.53)
-p prefix	Set prefix path (default: /usr/local/nginx/). (version >= 0.7.53)
-c filename	Specify which configuration file NGINX should use instead of the default.
-g directives	Set global directives. (version >= 0.7.4)
Note
NGINX has only a few command-line parameters. Unlike many other software systems, the configuration is done entirely via the configuration file (imagine that).

Stopping or Restarting NGINX
There are two ways to control NGINX once it’s already running. The first is to call NGINX again with the -s command line parameter. For example, /usr/bin/nginx -s stop will stop the NGINX server. (other -s options are given in the previous section)

The second way to control NGINX is to send a signal to the NGINX master process… By default NGINX writes its master process id to /usr/local/nginx/logs/nginx.pid. You can change this by passing parameter with ./configure at compile-time or by using pid directive in the configuration file.

Here’s how to send the QUIT (Graceful Shutdown) signal to the NGINX master process:

kill -QUIT $( cat /usr/local/nginx/logs/nginx.pid )
The master process can handle the following signals:

TERM, INT	Quick shutdown
QUIT	Graceful shutdown
KILL	Halts a stubborn process
HUP	
Configuration reload

Start the new worker processes with a new configuration

Gracefully shutdown the old worker processes

USR1	Reopen the log files
USR2	Upgrade Executable on the fly
WINCH	Gracefully shutdown the worker processes
There’s no need to control the worker processes yourself. However, they support some signals, too:

TERM, INT	Quick shutdown
QUIT	Graceful shutdown
USR1	Reopen the log files
Loading a New Configuration Using Signals
NGINX supports a few signals that you can use to control it’s operation while it’s running.

The most common of these is 15, which just stops the running process:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      2213  0.0  0.0   6784  2036 ?        Ss   03:01   0:00 nginx: master process /usr/sbin/nginx -c /etc/nginx/nginx.conf
The more interesting option however, is being able to change the NGINX configuration on the fly (notice that we test the configuration prior to reloading it):

2006/09/16 13:07:10 [info]  15686#0: the configuration file /etc/nginx/nginx.conf syntax is ok
2006/09/16 13:07:10 [info]  15686#0: the configuration file /etc/nginx/nginx.conf was tested successfully
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      2213  0.0  0.0   6784  2036 ?        Ss   03:01   0:00 nginx: master process /usr/sbin/nginx -c /etc/nginx/nginx.conf
What happens is that when NGINX receives the HUP signal, it tries to parse the configuration file (the specified one, if present, otherwise the default), and if successful, tries to apply a new configuration (i.e. re-open the log files and listen sockets). If successful, NGINX runs new worker processes and signals graceful shutdown to old workers. Notified workers close listen sockets but continue to serve current clients. After serving all clients old workers shutdown. If NGINX couldn’t successfully apply the new configuration, it continues to work with an old configuration.

