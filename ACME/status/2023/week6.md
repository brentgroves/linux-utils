
Thank you Father for helping me to believe that my joy is not dependant on my circumstances but in you alone!
Good morning my dear friends,
I wanted to say that I enjoy working with each one of you, and hope you and your loved ones are all doing well and enjoying the warmer weather this week!  If you need anything please feel free to call or text me at work or at home.

Scripts:
Worked on python script to import the trial balance CSV file that can be downloaded from Plex.  In Southfield not all the 4000 and some accounts are in this report, hence our TB report, but by importing the YTD and FTD account summaries we can easily compare our TB results against those found in Plex.This was the last of the SSIS scripts that had not been implemented in python.

Storage:
Can MSSQL Server be deployed to k8s and take advantage of replicated storage?  I don't see why not because a linux version of MSSQL Server is available and I'm sure there is an official docker image for it.
Can our QNAP SAN storage device be used by our ESXi and nutanix hypervisors to provide storage for VM? 
- The idea is to mount this storage to the VM OS and use it for SQL dumps/restores.
Can our k8s use our QNAP SAN storage devices for volume provisioning?
- Maybe have to check around, https://operatorhub.io/operator/ember-csi-operator.

tested OpenEBS Mayastor NVMe storage 3-way mirrored persistent volumes, PVs

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

https://mayastor.gitbook.io/
What is a Mayastor Pool?
When a Mayastor node allocates storage capacity for a replica of a Persistent Volume it does so from a Mayastor Pool. Each Mayastor node may create and manage zero, one, or more such pools. The ownership of a pool by a node is exclusive. A pool can manage only one block device, which constitutes the entire data persistence layer for that pool and thus defines its maximum storage capacity.

https://mayastor.gitbook.io/introduction/quickstart/configure-mayastor#create-mayastor-pool-s  
Mayastor dynamically provisions Persistent Volumes (PV) based on StorageClass definitions created by the user. Parameters of the definition are used to set the characteristics and behaviour of its associated PVs. For a detailed description of these parameters see storage class parameter description. Most importantly StorageClass definition is used to control the level of data protection afforded to it (that is, the number of synchronous data replicas which are maintained, for purposes of redundancy). It is possible to create any number of StorageClass definitions, spanning all permitted parameter permutations.


**Mayastore Failure recovery**
https://mayastor.gitbook.io/introduction/reference/replica-operations

Scenario One
A cluster has two Mayastor nodes deployed, "Node-1" and "Node-2". Each Mayastor node hosts two Mayastor pools and currently, no Mayastor volumes have been defined. Node-1 hosts pools "Pool-1-A" and "Pool-1-B", whilst Node-2 hosts "Pool-2-A and "Pool-2-B". When a user creates a PVC from a StorageClass which defines a replica count of 2, the Mayastor control plane will seek to place one replica on each node (it 'follows' Rule 2). Since in this example it can find a suitable candidate pool with sufficient free capacity on each node, the volume is provisioned and becomes "healthy" (Rule 1). Pool-1-A is selected on Node-1, and Pool-2-A selected on Node-2 (all pools being of equal capacity and replica count, in this initial 'clean' state).
Sometime later, the physical disk of Pool-2-A encounters a hardware failure and goes offline. The volume is in use at the time, so its nexus (NVMe controller) starts to receive I/O errors for the replica hosted in that Pool. The associated replica's child from Pool-2-A enters the Faulted state and the volume state becomes Degraded (as seen through the kubectl-mayastor plugin).
Expected Behaviour: The volume will maintain read/write access for the application via the remaining healthy replica. The faulty replica from Pool-2-A will be removed from the Nexus thus changing the nexus state to Online as the remaining is healthy. A new replica is created on either Pool-2-A or Pool-2-B and added to the nexus. The new replica child is rebuilt and eventually the state of the volume returns to Online.


