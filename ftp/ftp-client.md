https://linuxopsys.com/topics/lftp-commands

sudo apt-get update && sudo apt-get install lftp

# make sure you can write to the server
ssh brent@avi-ubu
sudo sed -i.orig 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
sudo systemctl restart vsftpd.service

# connect 
lftp brent@avi-ubu

# mirror
mirror -c source_dir target_dir
source_dir is the ftp server dir
target_dir is the ftp client dir

example:
mkdir ~/backups
lftp brent@alb-ubu
lftp brent@reports41
mirror /home/brent/backups /home/brent/backups

# List contents of remote directory
We can check what have been done with ls command.
lftp brent@avi-ubu:~> ls

# This command takes one file from local directory and uploads it to server. We will upload file test1.
lftp brent@avi-ubu:~> put test1

# Reverse mirroring of directory
If we want to mirror the entire directory to the server, we will use reverse mirror command.

lftp brent@reports24:~> mirror -R

# Change local directory
The local directory can be changed with lcd command
lftp brent@avi-ubu:~> lcd /mnt/data/
lcd ok, local cwd=/home/miki/Videos

# Print local working directory
You can check what is your local working directory with lpwd command
lftp brent@avi-ubu:~> lpwd

# Downloading the file from ftp server
Downloading files from the remote directory to local directory is done with pget command
lftp miki@192.168.122.65:~> pget ubuntu-16.04.1-server-amd64.iso

# Mirroring from the server to the local directory
We earlier show how to do the opposite, now we use mirror command to get data pulled from the server
mirror
