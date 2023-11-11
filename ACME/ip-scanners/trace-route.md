# Trace route

sudo apt-get install traceroute

## References

<https://help.dreamhost.com/hc/en-us/articles/215840708-Traceroute>

Run the following command once it is installed:
traceroute example.com
Some Linux variants require you to also specify the protocol after -I. For example:
traceroute -I ICMP example.com

traceroute 10.1.0.113
traceroute to 10.1.0.113 (10.1.0.113), 30 hops max, 60 byte packets
 1  reports-alb.busche-cnc.com (10.1.0.113)  0.080 ms  0.025 ms  0.022 ms
