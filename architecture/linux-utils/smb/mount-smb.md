
TW9iZXhHbG9iYWxOQVMyMDIyIQ==
https://support.zadarastorage.com/hc/en-us/articles/213024986-How-to-Mount-a-SMB-Share-in-Ubuntu
https://linuxize.com/post/how-to-mount-cifs-windows-share-on-linux/
mongodump mongodb://adminuser:password123@reports11:30311 --out /home/brent/backups/mongo
sudo apt-get install cifs-utils

sudo mkdir /mnt/qnap_avi
sudo chmod 777 /mnt/qnap_avi
sudo umount -l /mnt/qnap_avi
sudo vi /etc/qnap-credentials
sudo mount -t cifs -o username=admin,dir_mode=0777,file_mode=0777,password=TW9iZXhHbG9iYWxOQVMyMDIyIQ== //172.20.1.34/home /mnt/qnap_avi 
sudo mount -t cifs -o username=admin,dir_mode=0777,file_mode=0777,password=TW9iZXhHbG9iYWxOQVMyMDIyIQ== //qnap-avi/home /mnt/qnap_avi 
# use this one
sudo mount -t cifs -o credentials=/etc/qnap-credentials,dir_mode=0777,file_mode=0777 //qnap-avi/home /mnt/qnap_avi 
sudo umount -l /mnt/qnap_avi

/etc/fstab
# <file system>             <dir>          <type> <options>                                                   <dump>  <pass>
//WIN_SHARE_IP/share_name  /mnt/win_share  cifs  credentials=/etc/win-credentials,file_mode=0755,dir_mode=0755 0       0
//qnap-avi/home /mnt/qnap_avi cifs  credentials=/etc/qnap-credentials,dir_mode=0777,file_mode=0777  0 0

sudo mount /mnt/qnap_avi
//qnap-avi/home /mnt/qnap_avi cifs  credentials=/etc/qnap-credentials,dir_mode=0777,file_mode=0777  0 0