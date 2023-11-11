sudo chmod 777 /etc/iptables/rules.v4
sudo iptables -P FORWARD ACCEPT
sudo /sbin/iptables-save > /etc/iptables/rules.v4


https://linuxconfig.org/how-to-make-iptables-rules-persistent-after-reboot-on-linux

How to make iptables rules persistent after reboot on Linux step by step instructions
DID YOU KNOW?
Some iptables front ends, such as firewalld for Red Hat based systems and ufw for Ubuntu based systems, will automatically save your rules for you and they will persist even after reboot.
Before proceeding, make sure that you already have some rules configured on your system. In particular, this tutorial assumes that you have configured the rules with iptables, rather than a front end firewall application like firewalld or ufw.

To see the rules on your system, you can use the following iptables command.

$ sudo iptables -L
Save iptables rules on DEB based systems
In order to make your iptables rules persistent after reboot, install the iptables-persistent package using the apt package manager:
$ sudo apt install iptables-persistent
Any currently erected iptables rules will be saved to the corresponding IPv4 and IPv6 files below:

/etc/iptables/rules.v4
/etc/iptables/rules.v6

To update persistent iptables with new rules simply use iptables command to include new rules into your system. To make changes permanent after reboot run iptables-save command:
$ sudo iptables-save > /etc/iptables/rules.v4
OR
$ sudo ip6tables-save > /etc/iptables/rules.v6

To remove persistent iptables rules simply open a relevant /etc/iptables/rules.v* file and delete lines containing all unwanted rules.


https://linuxconfig.org/collection-of-basic-linux-firewall-iptables-rules
DID YOU KNOW?
Be aware that the order of your iptables rules matters. When your system receives a packet of network traffic, iptables will match it to the first rule it can. Therefore, if you have a rule to accept SSH traffic, followed by a rule to deny SSH traffic, iptables will always accept the traffic because that rule comes before the deny rule in the chain. You can always change the rule order by specifying a rule number in your command.

The purpose of this guide is to show some of the most common iptables commands for Linux systems. iptables is the firewall built into all Linux distributions. Even distros like Ubuntu, which utilizes ufw (uncomplicated firewall), and Red Hat, which utilizes firewalld still pass their commands to iptables and use it in the background.

sudo iptables -L -v -n --line-numbers

iptables to reject all outgoing network connections
The second line of the rules only allows current outgoing and established connections. This is very useful when you are logged in to the server via ssh or telnet.

# iptables -F OUTPUT
# iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -j REJECT

Rule: iptables to reject all incoming network connections
# iptables -F INPUT
# iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
# iptables -A INPUT -j REJECT

Rule: iptables to reject all network connections
This rule will drop and block all network connection whether incoming or outgoing. More importantly this will also include current ongoing established connections.

# iptables -F
# iptables -A INPUT -j REJECT
# iptables -A OUTPUT -j REJECT
# iptables -A FORWARD -j REJECT

Rule: iptables to drop incoming ping requests
This iptables rule will DROP all incoming ping requests. Note that it is possible to use REJECT instead of DROP. The difference between DROP vs REJECT is that DROP silently discards the incoming package, whereas REJECT will result in ICMP error being returned.
# iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

Rule: iptables to drop outgoing telnet connections
This iptables rule will block any outgoing traffic to any host where destination port is 23 (telnet).
# iptables -A OUTPUT -p tcp --dport telnet -j REJECT

Rule: iptables to reject incoming telnet connections
This iptables rule will refuse all incoming connection requests to a local port 23.
# iptables -A INPUT -p tcp --dport telnet -j REJECT

Rule: iptables to reject outgoing ssh connections
This iptables rule will refuse all outgoing connections coming from a local port 22 (ssh).
# iptables -A OUTPUT -p tcp --dport ssh -j REJECT

Rule: iptables to reject incoming ssh connections
Refuse all incoming connections to a local port 22 (ssh).
# iptables -A INPUT -p tcp --dport ssh -j REJECT

Rule: iptables to reject all incoming traffic except ssh and local connections
These rules will reject all incoming connections to the server except those on port 22 (SSH). It will also accept connections on the loopback interface.
# iptables -A INPUT -i lo -j ACCEPT
# iptables -A INPUT -p tcp --dport ssh -j ACCEPT
# iptables -A INPUT -j REJECT

Rule: iptables to accept incoming ssh connections from specific IP address
Using this iptables rule we will block all incoming connections to port 22 (ssh) except host with IP address 77.66.55.44. What this means is that only host with IP 77.66.55.44 will be able to ssh.
# iptables -A INPUT -p tcp -s 77.66.55.44 --dport ssh -j ACCEPT
# iptables -A INPUT -p tcp --dport ssh -j REJECT

Rule: iptables to accept incoming ssh connections from specific MAC address
Using this iptables rule we will block all incoming connections to port 22 (ssh) except host with MAC address 00:e0:4c:f1:41:6b. In other words all ssh connections will be limited to a single host with a MAC address 00:e0:4c:f1:41:6b.

# iptables -A INPUT -m mac --mac-source 00:e0:4c:f1:41:6b -p tcp --dport ssh -j ACCEPT
# iptables -A INPUT -p tcp --dport ssh -j REJECT

Rule: iptables to reject incoming connections on a specific TCP port
The following iptables rule will drop all incoming traffic on TCP port 3333.
# iptables -A INPUT -p tcp --dport 3333 -j REJECT

Rule: iptables to drop all incoming connections on a specific network interface
The following rule will drop incoming traffic on a specific network interface coming from subnet 192.168.0.0/16. The is very useful in attempt to drop all spoofed IP addresses. If eth0 is an external network interface, no incoming traffic originating from internal network should hit eth0 network interface.
# iptables -A INPUT -i eth0 -s 192.168.0.0/16 -j DROP

Rule: iptables to create a simple IP Masquerading
The following rule will create a simple IP Masquerading gateway to allow all host on the same subnet to access the Internet. The below specified eth0 is a external interface connected to the Internet.
# echo "1" > /proc/sys/net/ipv4/ip_forward
# iptables -t nat -A POSTROUTING -o $EXT_IFACE -j MASQUERADE

Rule: Reject all incoming telnet traffic except specified IP address
The following iptables rule will reject all incoming telnet traffic except connection request from IP 222.111.111.222
# iptables -A INPUT -t filter ! -s 222.111.111.222 -p tcp --dport 23 -j REJECT

Rule: Reject all incoming ssh traffic except specified IP address range
The following iptables rule will reject all incoming ssh traffic except connection request from IP address range 10.1.1.90 – 10.1.1.1.100.

Removing negator “!” from the below rule reject all ssh traffic originating from IP address range 10.1.1.90 – 10.1.1.100.
# iptables -A INPUT -t filter -m iprange ! --src-range 10.1.1.90-10.1.1.100  -p tcp --dport 22 -j REJECT


Rule: iptables to reject all outgoing traffic to a specific remote host
The following iptables rule will reject all outgoing traffic to a remote host with an IP address 222.111.111.222
# iptables -A OUTPUT -d 222.111.111.222 -j REJECT

Rule: iptables to block an access to a specific website
The following iptables rule will block all incoming traffic from facebook.com where source port is port 80 / www.
# iptables -A INPUT -s facebook.com -p tcp --sport www -j DROP
Note that the above iptables rule will block access to facebook.com as well as www.facebook.com.

https://linuxconfig.org/collection-of-basic-linux-firewall-iptables-rules



