https://www.baeldung.com/linux/load-env-variables-in-cron-job
https://www.baeldung.com/linux/load-env-variables-in-cron-job
https://www.baeldung.com/linux/load-env-variables-in-cron-job
https://www.baeldung.com/linux/load-env-variables-in-cron-job

https://www.howtogeek.com/devops/how-to-use-cron-with-your-docker-containers/
https://stackoverflow.com/questions/610839/how-can-i-programmatically-create-a-new-cron-job
https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804
https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804

https://stackoverflow.com/questions/37458287/how-to-run-a-cron-job-inside-a-docker-container

docker run -d --name cron-test brentgroves/cron-test:5
0ea3478106f5
# To check if the job is scheduled
docker exec -ti 0ea3478106f5 bash -c "crontab -l"
# To check if the cron service is running
docker exec -ti <your-container-id> bash -c "pgrep cron"

docker exec -ti 0ea3478106f5 bash -c "tail -f /var/log/cron.log"


ENTRYPOINT cron start && tail -f /var/log/cron.log
docker run -d --name cron-test brentgroves/cron-test:7
d09558dc15e3
docker exec -ti d09558dc15e3 bash -c "pgrep cron"
docker exec -ti d09558dc15e3 bash
crontab /etc/cron.d/email-cron



docker attach cron-test

docker run -it 39fdc2a70de4 /bin/bash

docker run --name cron-test --rm -i -t brentgroves/cron-test:4 /bin/bash
Attach to and detach from a running container🔗
docker run -d --name cron-test brentgroves/cron-test:4 /usr/bin/top -b
 docker attach cron-test

https://www.baeldung.com/ops/docker-cron-job

(crontab -l ; echo "0 * * * * your_command") | sort - | uniq - | crontab -
(crontab -l ; echo "* 17 23 5 * echo 'Test cron  Run this command every minute' >> /home/bgroves@BUSCHE-CNC.COM/cron-test.log") | sort - | uniq - | crontab -

https://stackoverflow.com/questions/37458287/how-to-run-a-cron-job-inside-a-docker-container

sudo cp hello-cron /etc/cron.d/hello-cron
sudo chmod 0644 /etc/cron.d/hello-cron
sudo crontab /etc/cron.d/hello-cron
touch /var/log/cron.log

cat /var/log/cron.log

(crontab -l ; 42,43,44 17 23 5 * echo 'Test cron  Run this command every minute' | mail -s 'test mail') 
(crontab -l ; * 17 23 5 * echo 'Test cron  Run this command every minute' >> /home/bgroves@BUSCHE-CNC.COM/cron-test.log) | sort - | uniq - | crontab -

bgroves@buschegroup.com
The best way if you're running as root, is to drop a file into /etc/cron.d

if you use a package manager to package your software, you can simply lay down files in that directory and they are interpreted as if they were crontabs, but with an extra field for the username, e.g.:

Filename: /etc/cron.d/per_minute

Content: * * * * * root /bin/sh /home/root/script.sh

Introduction
Cron is a time-based job scheduling daemon found in Unix-like operating systems, including Linux distributions. Cron runs in the background and operations scheduled with cron, referred to as “cron jobs,” are executed automatically, making cron useful for automating maintenance-related tasks.

This guide provides an overview of how to schedule tasks using cron’s special syntax. It also goes over a few shortcuts you can use to expedite the process of writing job schedules and make them more understandable.

Understanding How Cron Works
Cron jobs are recorded and managed in a special file known as a crontab. Each user profile on the system can have their own crontab where they can schedule jobs, which is stored under /var/spool/cron/crontabs/.

To schedule a job, open up your crontab for editing and add a task written in the form of a cron expression. The syntax for cron expressions can be broken down into two elements: the schedule and the command to run.

The command can be virtually any command you would normally run on the command line. The schedule component of the syntax is broken down into 5 different fields, which are written in the following order:

Field	Allowed Values
minute	0-59
hour	0-23
Day of the month	1-31
month	1-12 or JAN-DEC
Day of the week	0-6 or SUN-SAT

Together, tasks scheduled in a crontab are structured like the following:

minute hour day_of_month month day_of_week command_to_run
Here’s a functional example of a cron expression. This expression runs the command curl http://www.google.com every Tuesday at 5:30 PM:

30 17 * * 2 curl http://www.google.com

There are also a few special characters you can include in the schedule component of a cron expression to streamline scheduling tasks:

*: In cron expressions, an asterisk is a wildcard variable that represents “all.” Thus, a task scheduled with * * * * * ... will run every minute of every hour of every day of every month.
,: Commas break up scheduling values to form a list. If you want to have a task run at the beginning and middle of every hour, rather than writing out two separate tasks (e.g., 0 * * * * ... and 30 * * * * ...), you could achieve the same functionality with one (0,30 * * * * ...).
-: A hyphen represents a range of values in the schedule field. Instead of having 30 separate scheduled tasks for a command you want to run for the first 30 minutes of every hour (as in 0 * * * * ..., 1 * * * * ..., 2 * * * * ..., and so on), instead, you could schedule it as 0-29 * * * * ....
/: You can use a forward slash with an asterisk to express a step value. For example, instead of writing out eight separate separate cron tasks to run a command every three hours (as in, 0 0 * * * ..., 0 3 * * * ..., 0 6 * * * ..., and so on), you could schedule it to run like this: 0 */3 * * * ....
Note: You cannot express step values arbitrarily; you can only use integers that divide evenly into the range allowed by the field in question. For instance, in the “hours” field you could only follow a forward slash with 1, 2, 3, 4, 6, 8, or 12.

Here are some more examples of how to use cron’s scheduling component:

* * * * * - Run the command every minute.
12 * * * * - Run the command 12 minutes after every hour.
0,15,30,45 * * * * - Run the command every 15 minutes.
*/15 * * * * - Run the command every 15 minutes.
0 4 * * * - Run the command every day at 4:00 AM.
0 4 * * 2-4 - Run the command every Tuesday, Wednesday, and Thursday at 4:00 AM.
20,40 */8 * 7-12 * - Run the command on the 20th and 40th minute of every 8th hour every day of the last 6 months of the year.

If you find any of this confusing or if you’d like help writing schedules for your own cron tasks, Cronitor provides a handy cron schedule expression editor named “Crontab Guru” which you can use to check whether your cron schedules are valid.


Managing Crontabs
Once you’ve settled on a schedule and you know the job you want to run, you’ll need to put it somewhere your daemon will be able to read it.

As mentioned previously, a crontab is a special file that holds the schedule of jobs cron will run. However, these are not intended to be edited directly. Instead, it’s recommended that you use the crontab command. This allows you to edit your user profile’s crontab without changing your privileges with sudo. The crontab command will also let you know if you have syntax errors in the crontab, while editing it directly will not.

You can edit your crontab with the following command:

crontab -e
f this is the first time you’re running the crontab command under this user profile, it will prompt you to select a default text editor to use when editing your crontab:

Output
no crontab for sammy - using an empty one

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.basic
  3. /usr/bin/vim.tiny
  4. /bin/ed

Choose 1-4 [1]: 
Enter the number corresponding to the editor of your choice. Alternatively, you could press ENTER to accept the default choice, nano.

After making your selection, you’ll be taken to a new crontab containing some commented-out instructions on how to use it:

# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
When you run crontab -e in the future, it will bring up your crontab in this text editor automatically. Once in the editor, you can input your schedule with each job on a new line. Otherwise, you can save and close the crontab for now (CTRL + X, Y, then ENTER if you selected nano).

Note: On Linux systems, there is another crontab stored under the /etc/ directory. This is a system-wide crontab that has an additional field for which user profile each cron job should be run under. This tutorial focuses on user-specific crontabs, but if you wanted to edit the system-wide crontab, you could do so with the following command:

sudo ls /var/spool/cron/crontabs/bgroves

sudo nano /etc/crontab
If you’d like to view the contents of your crontab, but not edit it, you can use the following command:

crontab -l
You can erase your crontab with the following command:

Warning: The following command will not ask you to confirm that you want to erase your crontab. Only run it if you are certain that you want to erase it.

crontab -r
This command will delete the user’s crontab immediately. However, you can include the -i flag to have the command prompt you to confirm that you actually want to delete the user’s crontab:

crontab -r -i
Output
crontab: really delete sammy's crontab? (y/n)
When prompted, you must enter y to delete the crontab or n to cancel the deletion.

