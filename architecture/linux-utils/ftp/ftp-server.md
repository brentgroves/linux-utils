Share files 

https://phoenixnap.com/kb/install-ftp-server-on-ubuntu-vsftpd 
https://www.jscape.com/blog/setting-up-sftp-public-key-authentication-command-line
You can't set up public key authentication with vsftpd - you are getting confused between FTPs and SFTP which are two different protocols.

To use public key authentication for SFTP it is just a matter of installing your public key on the server, as you would for ssh as detailed here - http://www.noah.org/wiki/SSH_public_keys

Thank you Father for letting me be a part of your creation!

sudo apt install vsftpd 

sudo systemctl start vsftpd 

sudo systemctl enable vsftpd 

# make sure you can write to the server
ssh brent@avi-ubu
sudo sed -i.orig 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
sudo systemctl restart vsftpd.service

you dont need to add a user if you have a login to the destination system.

sudo useradd -m testuser 

sudo passwd testuser 

sudo ftp reports22 

By default, the FTP server uses the /srv/ftp directory as the default directory. You can change this by creating a new directory and changing the FTP user home directory. 

To change the FTP home directory, enter the following: 

sudo mkdir /srv/ftp/new_location 
 
sudo usermod -d /srv/ftp/new_location ftp 

Authenticate FTP Users
If you want to let authenticated users upload files, edit the vsftpd.conf file by entering the following:

sudo nano /etc/vsftpd.conf

Find the entry labeled write_enable=NO, and change the value to “YES.”

Write_Enable option in vsftpd.config file.
Save the file, exit, then restart the FTP service with the following:

or do this: 
sed -i.orig 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
sudo systemctl restart vsftpd.service