https://en.wikipedia.org/wiki/Dnsmasq
dnsmasq

Article
Talk
Read
Edit
View history

Tools
From Wikipedia, the free encyclopedia
dnsmasq
dnsmasq logo
Dnsmasq version screenshot.png
Developer(s)	Simon Kelley
Initial release	2001; 22 years ago
Stable release	
2.89 / 4 February 2023; 3 months ago[1]
Repository	
thekelleys.org.uk/gitweb/?p=dnsmasq.git Edit this at Wikidata
Written in	C[2]
Operating system	Unix-like
Type	DNS server
License	GNU General Public License Version 2 or 3[3]
Website	thekelleys.org.uk/dnsmasq/doc.html Edit this at Wikidata
dnsmasq is free software providing Domain Name System (DNS) caching, a Dynamic Host Configuration Protocol (DHCP) server, router advertisement and network boot features, intended for small computer networks.[4][5]

dnsmasq has low requirements for system resources,[6][7] can run on Linux, BSDs, Android and macOS, and is included in most Linux distributions. Consequently, it "is present in a lot of home routers and certain Internet of Things gadgets"[4] and is included in Android.[5]

Details
dnsmasq is a lightweight, easy to configure DNS forwarder, designed to provide DNS (and optionally DHCP and TFTP) services to a small-scale network. It can serve the names of local machines which are not in the global DNS.

dnsmasq's DHCP server supports static and dynamic DHCP leases, multiple networks and IP address ranges. The DHCP server integrates with the DNS server and allows local machines with DHCP-allocated addresses to appear in the DNS. dnsmasq caches DNS records, reducing the load on upstream nameservers and improving performance, and can be configured to automatically pick up the addresses of its upstream servers.

dnsmasq accepts DNS queries and either answers them from a small, local cache or forwards them to a real, recursive DNS server. It loads the contents of /etc/hosts, so that local host names which do not appear in the global DNS can be resolved. This also means that records added to your local /etc/hosts file with the format "0.0.0.0 annoyingsite.com" can be used to prevent references to "annoyingsite.com" from being resolved by your browser. This can quickly evolve to a local ad blocker when combined with adblocking site list providers. If done on a router, one can efficiently remove advertising content for an entire household or company.

dnsmasq supports modern Internet standards such as IPv6 and DNSSEC, network booting with support for BOOTP, PXE and TFTP and also Lua scripting.

Some Internet service-providers rewrite the NXDOMAIN (domain does not exist) responses from DNS servers, which forces web browsers to a search page whenever a user attempts to browse to a domain that does not exist. dnsmasq can filter out these "bogus" NXDOMAIN records, preventing this potentially unwanted behavior.