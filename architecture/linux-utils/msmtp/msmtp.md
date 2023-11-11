https://gist.github.com/movd/7a9e3db63d076f85d16c7dcde62fe401
mobexglobal-com.mail.protection.outlook.com
https://marlam.de/msmtp/
http://manpages.ubuntu.com/manpages/bionic/en/man1/msmtp.1.html

Setting up email with SMTP on Ubuntu/Debian Servers
I used to sift trough my shell history and bookmarks every time I set up a new testing server in order to be able to send mails. So this should help...

Be aware don't use ssmtp anymore. It's unmaintained and has been removed from Debian and Ubuntu will most definitely follow suit.

Install msmtp
First we need the awesome program called msmtp to route all the server's mail through a standard SMTP server.

sudo apt-get install msmtp msmtp-mta mailutils

Set up msmtp
sudo nvim /etc/msmtprc

# see etc_msmtprc_example.md

Install and set up mailx
In order to be able to use the mail command wee need to install mailx

sudo apt-get install bsd-mailx

Set mail transport agent to use msmtp

sudo nvim /etc/mail.rc

append the following:

set mta=/usr/bin/msmtp

Set up aliases
We need to link system users with email addresses in order for system users to receive mails from cronjobs.

sudo nvim /etc/aliases

# Send root to Jane
root: bgroves@buschegroup.com
   
# Send everything else to admin
default: bgroves@buschegroup.com

sudo nvim /etc/mail.rc

append:

alias root root<bgroves@buschegroup.com>


Test it!
echo "Hello World" | msmtp -d bgroves@buschegroup.com

Test sending a mail to root

echo "Testing msmtp from ${HOSTNAME} with mail command" | mail -s "test mail" root

Test sending a mail to another email adress

echo "Testing msmtp from ${HOSTNAME} with mail command" | mail -s "test mail" mcp@mobexglobal.com
echo "Testing msmtp from ${HOSTNAME} with mail command" | mail -s "test mail" bgroves@buschegroup.com

Links
https://marlam.de/msmtp/

https://wiki.archlinux.org/index.php/Msmtp


mailx --host=hostname