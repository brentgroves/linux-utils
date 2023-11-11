http://www.steves-internet-guide.com/using-nslookup/

nslookup      
> server 10.1.2.69
Default server: 10.1.2.69
Address: 10.1.2.69#53
> 10.1.3.80
;; communications error to 10.1.2.69#53: timed out
80.3.1.10.in-addr.arpa	name = MSC1-BUSCHE-P6.BUSCHE-CNC.COM.
> exit

## How to list all records in a DNS Name Server
- https://tweenpath.net/list-all-dns-records-from-a-nameserver-using-nslookup/
List all DNS records from a Nameserver using nslookup
 MARCH 27, 2017 BY RUMI
Method-1)
How to list all records below some domain name.
Usually it’s done from interactive nslookup mode, not from batch mode
nslookup - alb-ad01.busche-cnc.com 
>set q=any
>ls -d busche-cnc.com
listing may be prohibited by administrator or by firewall settings, in that case you get empty output or ‘not implemented’ errors.
Method-2
nslookup 
server 10.1.2.69
10.1.3.80
- For searching records in DNS you could use 3 tools - nslookup, dig, and Resove-DNSName (newer). Look at A, PTR and SRV records relating to former domain controller.
https://learn.microsoft.com/en-us/answers/questions/65182/how-to-find-all-possible-dns-records-for-a-server