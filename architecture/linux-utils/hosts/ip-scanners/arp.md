sudo apt install net-tools
https://www.techrepublic.com/article/how-to-scan-for-ip-addresses-on-your-network-with-linux/
arp -a
The arp command
The first tool we’ll use for the task is the built-in arp command. Most IT admins are familiar with arp, as it is used on almost every platform. If you’ve never used arp (which stands for Address Resolution Protocol), the command is used to manipulate (or display) the kernel’s IPv4 network neighbor cache. If you issue arp with no mode specifier or options, it will print out the current content of the ARP table. That’s not what we’re going to do. Instead, we’ll issue the command like so:

arp -a

The -a option uses and alternate BSD-style output and prints all known IP addresses found on your LAN. The output of the command will display IP addresses as well as the associated ethernet 
