https://linuxopsys.com/topics/copy-files-to-usb-using-terminal
could not get command line copy to work, but could do the copy from nautilus.

ls /media/brent
Insert the USB flash drive into your system. And let us find out the name of your USB drive using the fdisk command. Fdisk is used to manage hard drive and partitions in Linux.

sudo fdisk -l
lsusb
Using lsblk command you can check the device name and its mount points. Here you can see sda mounted to /media folder.
sdb      8:16   1  57.8G  0 disk 
└─sdb1   8:17   1  57.7G  0 part /media/brent/KINGSTON
sr0     11:0    1  1024M  0 rom  


# mirror
- copy from remote host to local host
mirror -c source_dir target_dir
example:
mkdir ~/backups
lftp brent@alb-ubu
mirror /home/brent/backups /home/brent/backups
- copy to usb drive
ls /media/brent
cp ~/backups/db/2022-11-29-13:47:12.sql.bak /media/brent/KINGSTON/
cp /media/brent/KINGSTON
