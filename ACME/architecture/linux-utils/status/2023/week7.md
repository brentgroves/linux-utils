Thank you Father for helping me to believe in the words of Jesus!
Good morning my dear friends,
I hope you and your loved ones are doing ok! Are you looking forward to spring as much as I am? Are you tired of the cold and dreary days? Think thoughts of spring-time and maybe we can get it to come sooner :-)
As always feel free to contact me at home or work if there is anything I can do for you!
-Sincerely yours,
Brent
260-564-4868

Appoligize for password issue:
I had not changed my password for a long time and evidently someone got a hold of it.  To prevent this from happening again I will change my password more often.  Thank heaven for 2-factor authentication!

Scripts:
Worked on python script to import the trial balance CSV file that can be downloaded from Plex.  In Southfield not all the 4000 and some accounts are in this report, hence our TB report, but by importing the YTD and FTD account summaries we can easily compare our TB results against those found in Plex.This was the last of the SSIS scripts that had not been implemented in python.


Switched to stand-alone kubectl to access k8s.
- Can use kubectl interact with both Azure and local k8s clusters.
- Create k8s cluster in my Azure account for testing purposes.

Azure CLI:
- Used azure CLI to interact with Azure tennant
- Created user principal
- Assigned SSH key to principal
- Created resource group
- Assigned contributor role to user principal
- Created k8s cluster from user principal

Nutanix k8s cluster:
- set up a 4 node k8s cluster on the Avilla's nutanix.

Trial Balance:
Dan Martin said he's expecting to need to run several TB reports in the near future.

Report Archive:
A report is assigned an id for its collection and sent as an Email to the customer. 
For a week the customer is able to access the report instance from the web app and resend if desired.
After a week the report instance is moved from the MongoDB to an archive storage area.
Attempt to use a qnap for the report archive.

OpenEBS Mayastor NVMe k8s storage:
tested OpenEBS Mayastor NVMe storage 3-way mirrored persistent volumes, PVs. It is very fast and works great!

What are OpenEBS Mayastor  prerequisites:
Linux kernel 5.13 or higher with the following modules loaded:
nvme-tcp
ext4 and optionally xfs
x86-64 CPU cores with SSE4.2 (streaming instruction set) instruction support. 
cat /proc/cpuinfo | grep sse4_2 
each core will have a flags tag that will contain sse4_2 if it has it.
cat /proc/cpuinfo | grep sse4_2 
each core will have a flags tag that will contain sse4_2 if it has it.
I believe this streaming instruction set works best with at least 1024 huge memory pages.
HugePages must be enabled. Mayastor requires at least 1024 4MB HugePages.
sudo sysctl vm.nr_hugepages=1048
echo 'vm.nr_hugepages=1048' | sudo tee -a /etc/sysctl.conf
cat /etc/sysctl.conf
brent@reports32:~$ grep HugePages /proc/meminfo
AnonHugePages:     12288 kB
ShmemHugePages:        0 kB
FileHugePages:         0 kB
HugePages_Total:    1048
HugePages_Free:     1048
HugePages_Rsvd:        0
HugePages_Surp:        0


What is declarative storage?
When an app is deployed to k8s you select the amount of storage that is required and how many replicas is to be maintained.  For the MySQL and MongoDB we have selected 3 replicas for database storage. So the Mayastore control plane takes care of replicating every database write to the Mayastore sparse image file, Mayastor pool, on each node.

reports 1 and 3 have the same mysql database.
learned:
- how to use a headless service to access stateful set within a k8s cluster: pod-name.svc-name.svc.local.cluster or just pod-name.svc-name.
- how to use a nodeport service to access a specific pod in a stateful set: k8s.pod_name as a selector.
- that mongodb ceased to be an opensource project and most tutorials are using version 4.
- you don't need a user name or password in version 4 if you do not enable authentication.
- you can run mongo version 4 from k8s and use the --rm flag to remove it after you are finished using the pod as a client for testing. 
Next:
- If it is ok with you I would like create 3 VMs with 8 GB ram and 2 vcpu and 2 cores each on a nutanix, but I did not see the prism web app for Avilla?
I only was able to connect to: 
mghart-ntnx https://10.1.8.110:9440
and 

https://10.30.1.120:9440/console/#login
using the admin password in Nutanix - Prism Element Local Admin

- test mayastor-mongo deployment with authentication.
- write a mongo sed script for the nodeport and stateful set.
- create backup/restore mongodb instructions. 
https://hevodata.com/learn/mongodump/
mongodump --host=10.10.10.59 --port=27017 --authenticationDatabase="admin" -u="barryadmin" -p="testpassword" --out=/mnt/mongo
https://www.bmc.com/blogs/mongodb-mongorestore/
mongorestore [additional options] --uri="mongodb://<host URL/IP>:<Port>" [restore directory/file]
mongorestore --host=10.10.10.59 --port=27017 --authenticationDatabase="admin" -u="barryadmin" -p="testpassword" ./dump/
mongorestore <options> <connection-string> <directory or file to restore>

https://www.geeksforgeeks.org/mongodb-backup-and-restoration/
https://hevodata.com/learn/mongodump/
mongodump --out c:\backupDatabase 

Step 1: Create Direct Backups Using Mongodump
You can run the Mongodump command using the below syntax from the system command line as follows:

mongodump <options> <connection-string>
This structure also permits you to connect to a Mongo database with the –uri command along with a formatted string or flag such as –user, –db, and –password. However, you can’t use more than 1 flag in a single command.
 
Step 2: Backup a Remote MongoDB Instance
As mentioned in Step 1, you can customize a host and a port number with the –uri connection string using the following syntax:

mongodump --uri="mongodb://<host URL/IP>:<Port>" [additional options]
mongodump --host="10.10.10.59" --port=27017
mongodump --host=10.10.10.59 --port=27017 --authenticationDatabase="admin" -u="barryadmin" -p="testpassword" 