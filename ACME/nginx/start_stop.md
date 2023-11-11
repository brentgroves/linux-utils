https://nginx.org/en/docs/beginners_guide.html

Starting, Stopping, and Reloading Configuration
To start nginx, run the executable file. Once nginx is started, it can be controlled by invoking the executable with the -s parameter. Use the following syntax:

nginx -s signal
Where signal may be one of the following:

stop — fast shutdown
quit — graceful shutdown
reload — reloading the configuration file
reopen — reopening the log files
For example, to stop nginx processes with waiting for the worker processes to finish serving current requests, the following command can be executed:

nginx -s quit
This command should be executed under the same user that started nginx.
Changes made in the configuration file will not be applied until the command to reload configuration is sent to nginx or it is restarted. To reload configuration, execute:

nginx -s reload

Once the master process receives the signal to reload configuration, it checks the syntax validity of the new configuration file and tries to apply the configuration provided in it. If this is a success, the master process starts new worker processes and sends messages to old worker processes, requesting them to shut down. Otherwise, the master process rolls back the changes and continues to work with the old configuration. Old worker processes, receiving a command to shut down, stop accepting new connections and continue to service current requests until all such requests are serviced. After that, the old worker processes exit.

A signal may also be sent to nginx processes with the help of Unix tools such as the kill utility. In this case a signal is sent directly to a process with a given process ID. The process ID of the nginx master process is written, by default, to the nginx.pid in the directory /usr/local/nginx/logs or /var/run. For example, if the master process ID is 1628, to send the QUIT signal resulting in nginx’s graceful shutdown, execute:

kill -s QUIT 1628

For getting the list of all running nginx processes, the ps utility may be used, for example, in the following way:

ps -ax | grep nginx
For more information on sending signals to nginx, see Controlling nginx.


