https://www.makeuseof.com/configure-static-ip-address-settings-ubuntu-22-04/
sudo nvim /etc/netplan/01-netcfg.yaml
10.1.2.215
172.20.0.39 10.30.1.27
https://tecadmin.net/how-to-configure-static-ip-address-on-ubuntu-22-04/
sudo ip a

2: ens160: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:50:56:9d:db:66 brd ff:ff:ff:ff:ff:ff
    altname enp3s0
    inet 10.1.3.4/22 metric 100 brd 10.1.3.255 scope global dynamic ens160
       valid_lft 345327sec preferred_lft 345327sec
    inet6 fe80::250:56ff:fe9d:db66/64 scope link 
       valid_lft forever preferred_lft forever

sudo vi /etc/netplan/01-netcfg.yaml



https://www.makeuseof.com/configure-static-ip-address-settings-ubuntu-22-04/
sudo apt install network-manager
nmcli connection show

https://www.youtube.com/watch?v=fayx4jWqyWk

sudo netplan apply

nmcli connection show
https://www.makeuseof.com/configure-static-ip-address-settings-ubuntu-22-04/