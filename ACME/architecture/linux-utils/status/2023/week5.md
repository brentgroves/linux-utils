Father please help me to focus on others more than on myself.
Good morning my dear brothers,
I hope you and your loved ones are doing well, and I wanted to let you know that I feel very thankful to be working with each of you. It is nice to be working With considerate, fun loving, and sometimes heavy burdened people who try their best to get along with one another's quirks and short-comings :-) Please feel free to contact me anytime at home or at work and I will try to help as best that I can!
-Sincerely yours 
260-564-4868

TB:
My memory played tricks on me and I forgot that the TB ETL scripts were running on the reports0 k8s and I deleted it which caused the TB report not to get updated by the cronjob and lots of concern by the controllers.  I am working on the cron job to run the TB ETL scripts until that is finished the ETL scripts must be run from a shell script. To prevent this from happening again I wrote sed scripts that changes the templated ETL scripts enabling them to pull passwords, hostnames, port numbers, and other configurable parameters from local files or k8s objects so that they can more easily be run on a development system or a production k8s cluster.  
I apologize for the inconvenience this has caused.

Backup:
The Azure data warehouse has a table called Plex.account_period_balance which contains all account balance summaries from 202101 to 202212.  These account balance records for previous periods do not need to be recalculated unless the controller makes a change that affects a previous period. So the TB scripts do not recalculate the Forever To Date,FTD, and YTD totals unless a account period update is detected.  It would be difficult to recreate this table from scratch so we back it up to our MySQL databases which also run the same TB scripts.

k8s:
containerized apps
virtual network with interfaces and DNS
virtual storage that can claimed from containerized apps


Storage:
More luck with iscsi than pVMe SAN protocol
What makes pVMe different?  One way is it takes advantage of huge memory page size introduced in kernel 1.26.  The default page size is 512MB and the new huge page size is 2GB. The OpenEBS mayastore implementation of pVMe requires that we load the tcp_nvme fabric kernel module and configure the number of huge pages to be at least 1024.  
Using jiva iscsi for MySQL and MongoDB.
- 1 instance of each server running on one node in the cluster. 
- every database update is sent to a persistent volume on each node.
- if any node in the cluster crashes the servers will still work.
- will use open source backup software for the MySQL and MongoDB the mayastor database storage.

Mayastor:
The OpenEBS software-only implementation of the new nVME SAN protocol that uses regular TCP networking fabric.

How k8s uses jiva storage:
ETL scripts generate the report result-set which is stored in MongoDB with a unique id.  
Since we are using OpenEBS jiva storage every result-set is inserted into 3 identical database files automatically.  
The MongoDB software engine inserts report result-sets and OpenEBS takes care of updating the 3 database files automatically.
If the node, VM, where the MongoDB software engine crashes it's the k8s job to start a pod on another node.
Since we still have 2 duplicate copies of the MongoDB files the MongoDB software engine still works great.
The MongoDB engine is also available to the network that the k8s is deployed on by a Nodeport service by connecting to one of the other 2 working nodes.  
The nodeport maps MongoDB tcp port connections to the MongoDB software engine no matter which node k8s runs it on.
K8s has it's own internal network with a DNS.


IT Request:
Mayastor does not work from the pieced together Albion server running the VMware ESXi, 6.7.0 hypervisor. I get a piix4 SMB error message. The VMs running on this system are slower at everything than old stand-alone dell optiplex desktops running the same software.
I would like to install 3 Ubuntu 22.04 server VMs with 8GB RAM and 256 GB storage on the almost empty Avilla hypervisor. 


