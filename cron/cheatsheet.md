https://www.codementor.io/@akul08/the-ultimate-crontab-cheatsheet-5op0f7o4r

Crontab Commands
crontab -e Edit or create a crontab file if doesn’t already exist.
crontab -l To Display the crontab file.
crontab -r To Remove the crontab file.
crontab -v To Display the last time you edited your crontab file. (This option is only available on a few systems.)
Crontab Parameters
# m h dom mon dow command
The above commented line is how the parameters of crontab are defined for each cronjob.

Available Crontab Fields
Field - Full Name - Allowed Values

m - Minute - 0 to 59
h - Hour - 0 to 23
dom - Day of Month - 0 to 31
mon - Month - 0 to 12
dow - Day of Week - 0 to 7 (0 and 7 are both Sunday)
Or a better way to understand this is:

* * * * * command to be executed
– – – – –
| | | | |
| | | | +—– day of week (0 – 6) (Sunday=0)
| | | +——- month (1 – 12)
| | +——— day of month (1 – 31)
| +———– hour (0 – 23)
+————- min (0 – 59)
# remove crontab
# add jobs
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

Change editor
select-editor (did not work on reports31)
export VISUAL="nvim" 

crontab -e
ansible-playbook playbooks/cron/test.yml
sudo tail -f /var/log/syslog