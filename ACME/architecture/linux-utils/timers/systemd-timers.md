systemctl list-timers

https://askubuntu.com/questions/1051066/cronjob-every-20-minutes-starting-direct-after-reboot/1051208#1051208

https://opensource.com/article/20/7/systemd-timers
I am in the process of converting my cron jobs to systemd timers. I have used timers for a few years, but usually, I learned just enough to perform the task I was working on. While doing research for this systemd series, I learned that systemd timers have some very interesting capabilities.

Like cron jobs, systemd timers can trigger events—shell scripts and programs—at specified time intervals, such as once a day, on a specific day of the month (perhaps only if it is a Monday), or every 15 minutes during business hours from 8am to 6pm. Timers can also do some things that cron jobs cannot. For example, a timer can trigger a script or program to run a specific amount of time after an event such as boot, startup, completion of a previous task, or even the previous completion of the service unit called by the timer.

https://askubuntu.com/questions/1083537/how-do-i-properly-install-a-systemd-timer-and-service

Further reading:

timers: https://www.freedesktop.org/software/systemd/man/systemd.timer.html
services: https://www.freedesktop.org/software/systemd/man/systemd.service.html
units (applies to both timers and services): https://www.freedesktop.org/software/systemd/man/systemd.unit.html
a related post


To run a unit at specified times or intervals you need two units:

a service unit that defines what to run
a timer unit that defines when to run the service unit
By convention, the timer unit starts another unit with the same name, i.e. foo.timer starts foo.service. You can override this by defining the Unit=other.service attribute in the timer unit (like you did).

If both unit files are created and put in /etc/systemd/system you need to make systemd aware of them by issuing

systemctl daemon-reload
This makes systemd reload all unit files and re-consider their dependencies because systemd caches these files somehow. So whenever you change a unit file, this command is required.

After that you need to enable the timer unit:

systemctl enable foo.timer
This commands simply enables auto-start at boot time (but doesn't start the unit yet). Do not enable the service unit because that would mean to start the service at boot time (independent of any timer settings).

Now the next time you boot, the timer will be engaged. To start it immediately (without booting) you would run

systemctl start foo.timer
From now on, the timer unit will start the service unit whenever the time comes. You can combine enabling and starting with

systemctl enable --now foo.timer
You can (and should) leave the service unit alone, i.e. neither enable nor start it. This is now handled by the timer unit.

To see the current status of both timer and service, issue

systemctl status foo.timer foo.service
To summarize
systemctl enable/disable controls the behaviour when booting
systemctl start/stop controls the behaviour right now
enable does not imply start (neither does disable imply stop). This can be overriden with the --now switch.
only enable and start the timer unit, not the service unit
issue systemctl daemon-reload whenever you edit the unit files