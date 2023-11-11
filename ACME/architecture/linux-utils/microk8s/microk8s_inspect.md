<!-- https://github.com/canonical/microk8s/issues/2180 -->
# Warning: iptables-legacy tables present, use iptables-legacy to see them
 WARNING:  IPtables FORWARD policy is DROP. Consider enabling traffic forwarding with: sudo iptables -P FORWARD ACCEPT 
The change can be made persistent with: sudo apt-get install iptables-persistent

sudo iptables-legacy -L -v -n --line-numbers
sudo iptables-legacy -S
sudo update-alternatives --display iptables
iptables - auto mode
  link best version is /usr/sbin/iptables-nft
  link currently points to /usr/sbin/iptables-nft
  link iptables is /usr/sbin/iptables
  slave iptables-restore is /usr/sbin/iptables-restore
  slave iptables-save is /usr/sbin/iptables-save
/usr/sbin/iptables-legacy - priority 10
  slave iptables-restore: /usr/sbin/iptables-legacy-restore
  slave iptables-save: /usr/sbin/iptables-legacy-save
/usr/sbin/iptables-nft - priority 20
  slave iptables-restore: /usr/sbin/iptables-nft-restore
  slave iptables-save: /usr/sbin/iptables-nft-save

sudo iptables -P FORWARD ACCEPT 

Fine...At present, it can only be solved temporarily in this way:

sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

sudo iptables-save > /etc/iptables/rules.v4

robert@k:~$ sudo snap install microk8s --edge --classic
microk8s (edge) v1.13.1 from Canonical✓ installed
robert@k:~$ sudo iptables -S
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT
<trimmed>

