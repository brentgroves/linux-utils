Thank you Father in Heaven for sending your son Jesus Christ to pay the penalty of my sins!

Good morning my friends,
I hope that each of you and your loved ones are keeping your spirits up during these very cold and dreary days. Take heart my friends they won't last forever and we have spring to look forward to!

Tested 2 software only versions of SAN storage working over our existing network:
Why: SAN is great for backing up databases. 
Questions: 
- How much could we increase our network performance if we attached our servers to a SAN?
- How much would it cost for a SAN?
- iscsi: using OpenEBS jiva-stor, open-iscsi, and iscsi_tcp module stack.
- nVme: using OpenEBS mayastor, and nvme_tcp module stack.
Tested SAN storage on microk8s on dell optiplex and VMware vSphere VM with Ubuntu 22.04 servers in a two 3 node clusters.
Also tested on a single Ubuntu 22.04 desktop with 24 GB ram running 3 Ubuntu 22.04 servers each using a bridged network interface. This setup worked best.

SSL/TLS database issues:
- have seen in browsers, sql servers, mongodb.  
- problems fixed in newer SSL/TLS versions:  
```
Denial of service
Heartbleed
Man in the middle
```
- how does database clients use SSL/TLS?  
OpenSSL doesn't run in the background but if installed a database client can load the library.
- how to know which version is installed?  
Checking the versions and the status of both the frontend and the library can be done with the following command:
dpkg -l 'openssl*'


