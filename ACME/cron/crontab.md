https://blog.cronitor.io/5-places-cron-jobs-live-in-linux-4913a57b7c1b

5 places cron jobs live in Linux
It might surprise you that the version of cron that runs on your server today is largely compatible with the crontab spec written in the 1970s. One downside of this careful backwards compatibility is that jobs, even on the same server, can be created and scheduled differently.

1. The user crontab
In Linux, each user has their own crontab that can be viewed and updated using the crontab command. The user crontab is the easiest place to add a job so it’s commonly used and is the first place to look when you’re unsure how a job has been scheduled.

One challenge is to know which user crontab it is in. If you can see the job in syslog, the username may be included. For example, here i can see the ubuntu user running the database backup:

Aug 5 4:05:01 dev01 CRON[2128]: (ubuntu) CMD (/var/cronitor/bin/database-backup.sh)

2. The root user crontab
Like any other user, root has a user crontab. Essentially the same as any other user crontab, you are editing the root crontab when you run sudo crontab -e.

3. The system crontab file
The original and still commonly used way to schedule system-wide cron jobs is by adding entries to /etc/crontab. Writing to /etc/crontab requires sudo privileges and jobs scheduled here can be run as any user. If the first word in your job command matches a user account the command is executed as that user. If no user is specified it’s run by root. In this example, the job will be run by user dataproc:

* 0 * * * dataproc /var/cronitor/bin/database-backup.sh

4. A crontab file in the system drop-in directory /etc/cron.d
At some point we realized it was bad practice to have a single system-wide crontab mutated by installers and automated tooling and the /etc/cron.d/ directory was born. Jobs are scheduled using /etc/cron.d by copying or creating a symlink to a crontab file. Like jobs scheduled in /etc/crontab, the first word of the command can optionally specify the user to run the job.

symlink: A symlink or a Symbolic Link is simply enough a shortcut to another file. It is a file that points to another file. They may sound a little complex

5. A script or command in /etc/cron.hourly, /etc/cron.daily, etc
When precise scheduling is less important than simple frequency, cron jobs can be created by copying or symlinking a script to /etc/cron.hourly, /etc/cron.daily, /etc/cron.weekly or /etc/cron.monthly. In distributions like Ubuntu, you can see when these scripts will be invoked by looking for lines in /etc/crontab:

7 * * * * root cd / && run-parts — report /etc/cron.hourly
5 23 * * * root cd / && run-parts — report /etc/cron.daily
5 23 * * 7 root cd / && run-parts — report /etc/cron.weekly
5 23 1 * * root cd / && run-parts — report /etc/cron.monthly

Bonus: Understanding /var/spool/cron
When individual user crontabs are edited using crontab -e, the crontab files themselves are stored in /var/spool/cron. Avoid the temptation to edit files here directly and instead run crontab -e as the user that will run the scheduled job. If you edit files in /var/spool/cron directly you will lose the benefit of syntax checking that crontab -e provides and you may find that your distribution doesn’t detect changes without an explicit cron daemon reload.

Cron jobs can fail due to bugs, system failure, accidental deletion, and thousands of other reasons. Cronitor will ensure you’ll never lose sight of an important job and that you’ll be alerted first when things go wrong.