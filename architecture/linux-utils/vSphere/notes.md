10.1.0.9
administrator@vsphere.local
Bu$ch3@dm!n

Upload ISO
in Datacenter\DatastoreALPHA
Failed to upload on the 1st attempt because of ssl certificate error

Create VM
https://graspingtech.com/vcenter-create-ubuntu-vm/
Click on the Hosts and Clusters icon at the top left.
Right click on your Cluster or a host then click New Virtual Machine…
Select Create a new virtual machine then click NEXT.

Give the machine a name then click NEXT.
Select a host in the cluster to add the VM to then click NEXT.
Select a datastore connected to the ESXi host then click NEXT.
Select the compatibility level then click NEXT.
Select Linux for the Guest OS Family, Ubuntu Linux (64-bit) for the Guest OS Version then click NEXT.

Configure the Virtual Hardware by choosing the amount of CPU cores, Memory and the size of the hard disk. In the following example I’ve used the minimum requirements for Ubuntu (1 CPU, 512 MB RAM, 4 GB HDD).
(4 CPU,16 GB RAM,256 GB HDD)

After assigning the CPU, Memory and hard disk, select the network and change the CD/DVD Drive to Datastore ISO File.

Make sure the CD/DVD drive is connected when the VM powers on by ticking the checkbox box labeled Connect At Power On.
Click BROWSE… to assign the Ubuntu ISO.

Navigate to the folder on a datastore containing the Ubuntu ISO image then click OK.
Click NEXT.

Click FINISH to create the VM.

We’re now ready to power on the VM and install the operating system.

Click on the name of the virtual machine, then click the green power on button next to its name.

Click Launch Web Console.

Click OK.
The web console should open in a new browser tab and the Ubuntu 18.04 installer will begin. Go through the installer, configuring the keyboard, networking, disk, users and software, as you would on any other hardware.
Once finished, the OS will reboot and you should be able to login.

Vcenter template 
https://www.nakivo.com/blog/vm-templates-a-to-z/ 
https://whmcsglobalservices.com/how-to-create-the-ubuntu-20-vm-template-for-vmware-automation/ 
I first created the reports VM and then converted it to a template. 
Then attempted to create reports1 and reports2 from the template. 
https://graspingtech.com/vcenter-create-ubuntu-vm/ 
https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/vmware-ubuntu-template 
Power on the VM and start the Ubuntu installation. No specific instructions here but: 
Consider using a static IP address 
Install OpenSSH server 


Set hostname 

https://phoenixnap.com/kb/ubuntu-20-04-change-hostname 

hostnamectl set-hostname new-hostname 