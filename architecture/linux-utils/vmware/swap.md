https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-20-04
https://linuxhint.com/change_swap_size_ubuntu/
change it to 4GB

goto root terminal
sudo -s 

swapon -s
For manipulating the swap file, we have to disable it first.

swapoff -a

Now, change the size of the swap file –


Here, the total size of the swap file will be bs*count = 1M x 4096 = 4GB

Make the “/swapfile” usable again –

mkswap /swapfile

Turn on the swapfile –

swapon /swapfile

After restarting your system, check out the result –

swapon -s