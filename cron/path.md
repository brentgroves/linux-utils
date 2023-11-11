https://unix.stackexchange.com/questions/148133/how-to-set-crontab-path-variable
https://stackoverflow.com/questions/40595903/python-program-giving-error-us-bin-env-python-no-such-file-with-crontab

t is possible to set the PATH (or other parameters) in the cronjob line or on a single line. But you are not able to use shell expansion like PATH=$PATH:/usr/local/bin. The tilde (~) character as a shortcut for the home directory works on MacOS, but seems not to work on Linux (at least with debian/buster).

From the books:

An active line in a crontab is either an environment setting or a cron command. An environment setting is of the form: name = value where the white spaces around the equal-sign (=) are optional, and any subsequent non-leading white spaces in value is a part of the value assigned to name. The value string may be placed in quotes (single or double, but matching) to preserve leading or trailing white spaces.

See man 5 crontab for more information.

So this should work:

PATH=/bin:/usr/bin:/home/bgroves@BUSCHE-CNC.COM/anaconda3/bin/python
5 3 * * * command_that_requires_my_path

While they are similar, a user crontab (edited using crontab -e) is different from and keeps a separate path from the system crontab (edited by editing /etc/crontab).

The system crontab has 7 fields, inserting a username before the command. The user crontab, on the other hand, has only 6 fields, going directly into the command immediately after the time fields.

Likewise, the PATH in the system crontab normally includes the /sbin directories, whereas the PATH in the user crontab does not. If you want to set PATH for the user crontab, you need to define the PATH variable in the user crontab.

A simple workaround for adding your regular PATH in shell commands in cron is to have the cronjob source your profile by running bash in a login shell. for example instead of

* * * * * some command
You can instead run

* * * * * bash -lc some command
That way if your profile sets the PATH or other environment variables to something special, it also gets included in your command.

Share
Improve this answer
Follow
edited Jun 20, 2017 at 8:50
answered Aug 3, 2014 at 12:13
user avatar
madumlao
1,6061010 silver badges88 bronze badges
1
Thanks, that explains it... But this way I can only set the PATH, and not edit, because PATH=/sbin:$PATH or similar doesn't work. I tried... – 
csny
 Aug 3, 2014 at 12:17
Yes, you would need to define the PATH from scratch in a case like this, which should be easy enough, since you know all of the commands that are run in your crontab, so you just need to take those into consideration. – 
beans
 Aug 3, 2014 at 12:47
@madumlao bash -lc doesn't help. I'm good for now with setting PATH manually, but if I install some scripts, I want them to be recognized in cronjobs without specifying full paths. I'm sure it is possible somehow, and bash -lc is on the way to a solution :) – 
csny
 Aug 3, 2014 at 15:42
4
bash -lc starts a login shell which sources your user's profile. This means that it uses the PATH set in ~/.bash_profile, ~/.profile, or ~/.bashrc... do you have the path set there? If so and it works ill update my answer for it – 
madumlao
 Aug 4, 2014 at 3:34
Great. Thanks Madunlao. After I manually added bin file folder to ~/.bash_profile, my cronjob works well. – 
Lane
 Jun 30, 2016 at 6:56 