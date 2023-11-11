https://portal.nutanix.com/page/documents/details?targetId=AHV-Admin-Guide-v6_6:wc-vm-create-acropolis-wc-t.html

 VirtIO is a specification for para-virtualized I/O in a virtual machine (VM).
     Traditionally, the hypervisor emulated real devices such as an Ethernet interface or disk
     controller to provide the VM with I/O.  This emulation is often inefficient.

     VirtIO defines an interface for efficient I/O between the hypervisor and VM.  The virtio
     module provides a shared memory transport called a virtqueue.  The virtio_pci device driver
     represents an emulated PCI device that the hypervisor makes available to the VM.  This
     device provides the probing, configuration, and interrupt notifications needed to interact
     with the hypervisor.  FreeBSD supports the following VirtIO devices:

           Ethernet  An emulated Ethernet device is provided by the vtnet(4) device driver.

           Block     An emulated disk controller is provided by the virtio_blk(4) device driver.

           SCSI      An emulated SCSI HBA is provided by the virtio_scsi(4) device driver.

           Balloon   A pseudo-device to allow the VM to release memory back to the hypervisor is
                     provided by the virtio_balloon(4) device driver.



During this task we will create a new VM which will be associated with an previously uploaded disk image.

Return to the Nutanix Prism Central console.
In the main navigation menu select (Top menu) > VM.
The VM pane will display.
If not already displayed, select the Table tab.
Click Create VM .
The Create VM dialog will open.
In the Create VM pane enter:
Name	A unique name for the VM. For example OAG-VM-2021.07
vCPUs	2
Cores	2
Memory	2GB
Scroll to the Disk section.
Click the x next to the CD-ROM disk as its not required for Access Gateway.
Click Add New Disk.
Select type:DISK.
Select Operation:Clone from image service.
Image: Disk added in Upload a disk image to Nutanix.
Click Add.
Click Save.
Scroll to the Network Adapters(NIC) section.
Click Add New NIC.
Leave all values unchanged.
Click Add.
Click Save.
Click Save.
The new VM will then be created.