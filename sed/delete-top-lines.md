sed -i '1,10d' myfile
would remove the lines from 1st to the 10th line form the file.

I think everybody should at least have a look at this sed 1 liners.

Note that this does not work for logfiles that are being actively appended to by an application (as stated in the question).

sed -i will create a new file and 'delete' the file that is being written to. Most applications will continue to write log records to the deleted log file and will continue to fill disk space. The new, truncated, log file will not be appended to. This will only cease when the application is restarted or is otherwise signalled to close and reopen its log files. At which point there will be a gap (missing log records) in the new log file if there has been any loggable activity between the use of sed and the application restart.

A safe way to do this would be to halt the application, use sed to truncate the log, then restart the application. This approach can be unacceptable for some services (e.g. a web-server with high throughput and high service-continuity requirements)