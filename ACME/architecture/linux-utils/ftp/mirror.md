
# mirror
mirror -c source_dir target_dir
source_dir is the ftp server dir
target_dir is the ftp client dir

example:
mkdir ~/backups
lftp brent@alb-ubu
lftp brent@reports41
mirror /home/brent/backups /home/brent/backups
mirror /var/snap/microk8s/4595/inspection-report-20230130_181058.tar.gz /home/brent/Downloads
# List contents of remote directory
We can check what have been done with ls command.
lftp brent@avi-ubu:~> ls

# This command takes one file from local directory and uploads it to server. We will upload file test1.
lftp brent@avi-ubu:~> put test1

# Reverse mirroring of directory
If we want to mirror the entire directory to the server, we will use reverse mirror command.

lftp brent@reports24:~> mirror -R
