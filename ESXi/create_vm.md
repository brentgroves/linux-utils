- upload ISO image
- get ip
install set it to DHCP 10.1.3.4/22
10.1.0.116,10.1.0.117,10.1.0.118
DNS: 172.20.0.39 10.30.1.27
gateway: 172.20.88.1
netmask: 10.1.0.0/22

- proceed through the create VM menu
The host or cluster supports more than one VMware virtual machine version. Select a compatibility for the virtual machine.
Compatible with:	
ESXi 6.7 and later
 
This virtual machine uses hardware version 14, which provides the best performance and latest features available in ESXi 6.7.

ubuntu linux


Provisioning type	Create a new virtual machine
Virtual machine name	reports41
Folder	Discovered virtual machine
Host	10.1.0.8
Datastore	
DatastoreALPHA
Guest OS name	Ubuntu Linux (64-bit)
Virtualization Based Security	Disabled
CPUs	1
Memory	1 GB
NICs	1
NIC 1 network	VM Network
NIC 1 type	VMXNET 3
SCSI controller 1	LSI Logic Parallel
Create hard disk 1	New virtual disk
Capacity	16 GB
Datastore	
DatastoreALPHA
Virtual device node	SCSI(0:0)
Mode	Dependent

- go to datacenter
- edit settings of VM
- change cd/dvd to datastore iso image 
- connect at power on
- power on vm
- launch console