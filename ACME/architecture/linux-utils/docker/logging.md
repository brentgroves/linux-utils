[Docker log collector](https://docs.docker.com/config/containers/logging/)
docker logs --tail=10 -f unit-wsgi-ex
docker logs --tail=10 -f nginx it show a combination of both error log and access log.


https://stackoverflow.com/questions/61564018/in-nginx-docker-how-do-we-see-log-only-from-error-log
View container logs
The docker logs command shows information logged by a running container. The docker service logs command shows information logged by all containers participating in a service. The information that is logged and the format of the log depends almost entirely on the container’s endpoint command.

By default, docker logs or docker service logs shows the command’s output just as it would appear if you ran the command interactively in a terminal. UNIX and Linux commands typically open three I/O streams when they run, called STDIN, STDOUT, and STDERR. STDIN is the command’s input stream, which may include input from the keyboard or input from another command. STDOUT is usually a command’s normal output, and STDERR is typically used to output error messages. By default, docker logs shows the command’s STDOUT and STDERR. To read more about I/O and Linux, see the Linux Documentation Project article on I/O redirection.

In some cases, docker logs may not show useful information unless you take additional steps.

If you use a logging driver which sends logs to a file, an external host, a database, or another logging back-end, and have “dual logging” disabled, docker logs may not show useful information.
If your image runs a non-interactive process such as a web server or a database, that application may send its output to log files instead of STDOUT and STDERR.
In the first case, your logs are processed in other ways and you may choose not to use docker logs. In the second case, the official nginx image shows one workaround, and the official Apache httpd image shows another.

The official nginx image creates a symbolic link from /var/log/nginx/access.log to /dev/stdout, and creates another symbolic link from /var/log/nginx/error.log to /dev/stderr, overwriting the log files and causing logs to be sent to the relevant special device instead. See the Dockerfile.

The official httpd driver changes the httpd application’s configuration to write its normal output directly to /proc/self/fd/1 (which is STDOUT) and its errors to /proc/self/fd/2 (which is STDERR). See the Dockerfile.


docker logs --tail=10 -f nginx it show a combination of both error log and access log.

Nginx Docker file is configured to send error.log to /dev/stderr.

RUN ln -sf /dev/stdout /var/log/nginx/access.log 
    && ln -sf /dev/stderr /var/log/nginx/error.log
When we run docker logs --tail=10 -f nginx it show a combination of both error log and access log. Is there a docker command so I can only see the logs of error.log or stderr?

dockerngdocker logs --tail=10 -f nginx it show a combination of both error log and access log.inx
Share
Improve this question
Follow
asked May 2, 2020 at 18:01
kumar's user avatar
kumar
7,6731818 gold badges8181 silver badges169169 bronze badges
Are you using the default NGINX docker image? or one of your own? – 
james
 May 2, 2020 at 18:16
I use docker logs --tail=50 nginx | grep '\[error\]', note that it will show errors in the last 50 logs (it does not show the "last 50 errors"). – 
pgarciacamou
 Jan 9 at 22:03 
Add a comment
2 Answers
Sorted by:

Highest score (default)

27


Try this command to get only error.log:

docker logs -f nginx 1>/dev/null
And this one for access.log:

docker logs -f nginx 2>/dev/null