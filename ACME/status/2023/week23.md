Please have courage my son.
Don't give up on what I have given you to do. Don't be discouraged when I do not give you the answer to the problem you are working on right away. The results are up to me and I will do what I think is best for you and the people around you my son.

Next:
Download custom ISO image to mgalb-hv1
curl -u "brent:JesusLives1!" ftp://172.20.88.64/welcome.msg > welcome.msg
test ISO with ssh and rdp on Hyper-V

Good morning dear ones,
I hope you and your loved ones had a terrific weekend of relaxation or excitement whatever you most needed to revive your spirit :-)  Thank you for the priviledge of being a part of this team I feel truly fortunate to be working with each of you!  As always please don't hesitate to contact me about whatever you would like at home or work. We are all in this together through the good times and bad, right?
Sincerely yours,
Brent
260-564-4868

# Big Picture
1. Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases. This includes validating our result sets to ensure they match what Plex shows on its reports and screens.   
2. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
3. Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-syncronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.

# What are development containers?
An identical set of docker containers used by a team which may include a docker volume containing source code, and a container for VS Code server, and containers running servers needed by the application being built such as a web server, database server, and cache server. 
# Why use development containers?
Microsoft Visual Studio Code IDE is now featuring something called development containers and the framework we are using to build our Microsoft Teams based UI, Laravel, is encouraging the adoption of this method of development.  So I thought I would spend some time setting one up. What I found is that it relies upon Docker Compose to keep your container set up and running.  We usually run a few containers during development for testing before publishing them to Kubernetes.  The difference is with docker compose all of the software needed to support your application is now running on your development system instead of distributed across several nodes on the Kubernetes cluster.  I found this method resulted in poor performance especially in my Avilla development system which is an i7 Optiplex 7020 with 8GB or ram.  So I asked Jared if it would be ok for me to set up a VM with 4 processors and 32 GB of RAM on mgalb-hv1, Albion's Windows Server 2019 with Hyper-V. 
# Created a Custom ISO to use for development containers.
Used qemu and **[cubic](https://github.com/PJ-Singh-001/Cubic)** to create a custom ISO from the official Ubuntu 22.04 desktop ISO. This image now includes an SSH and RDP server and we can add the VS Code server and other development utilities in the furture if desired. 
## What is QEMU? 
**[QEMU](https://www.qemu.org)** is an open source machine emulator and virtualizer. 
## What does the Canonical ISO structure look like
**![Ubuntu Standard and Minimal layer](https://user-images.githubusercontent.com/19394936/240445460-9e184625-d0e4-4e48-bb46-ac92ab33fc35.png)**

# Which hypervisor is best to run the development container VM.
We have three type 1 hypervisors Hyper-V, vsphere ESXi, and nutanix. In my mind I had several questions such as: Why do we have 3 different types of virtual machine managers? What are the differences between them? I felt that I needed to do some reseach on this to get a little bit more educated on the subject.    

# Research Activity
## How to use curl to download ISO image from Windows Server?
curl https://releases.ubuntu.com/22.04.2/ubuntu-22.04.2-desktop-amd64.iso > ubuntu-22.04.2-desktop-amd64.iso 
## How to user curl to download a file from an FTP server
 curl -u "username:password" ftp://172.20.88.64/welcome.msg > welcome.msg
## Proxmox VE, VMware ESXi, Hyper-V type 1 hypervisor comparison 
**[Comparing Proxmox VE,VMware ESXi, Hyper-V](https://4sysops.com/archives/proxmox-ve-vs-vmware-esxi-vs-hyper-v/)**
### Proxmox VE
Despite providing enterprise-class features, Proxmox VE is mainly adopted by technology enthusiasts in lab environments, home users, development teams, small businesses, and organizations that cannot afford (or do not want to spend much) on expensive licenses. It doesn't mean Proxmox can't handle the requirements of a large-scale enterprise. In fact, it is built to stand and scale massive deployments, but so far, it has rarely been adopted by large companies for running production workloads.
### VMware ESXi
VMware ESXi is the first choice of enterprise environments for running production workloads, since it is highly popular, well-established, well-documented, and offers the best technical support when needed. It gives organizations everything they could ever need to run, manage, and scale their server infrastructure.
### Hyper-V
Hyper-V has gained significant attention and has emerged as a top competitor of VMware for datacenter virtualization. It is suitable for companies running mostly Windows-based infrastructure. It is stable, well established, and has access to Microsoft support.

## What are the different versions of Hyper-V and What are Hyper-V servers?
**[Hyper-V version types](https://cloudinfrastructureservices.co.uk/hyper-v-vs-esxi-whats-the-difference/)**
Three versions of Hyper-V are available: Hyper-V for Windows Servers, Hyper-V Servers, and Hyper-V for Windows 10. 
### Hyper-V Servers
**[Hyper-V Servers](https://www.microsoft.com/en-us/evalcenter/evaluate-hyper-v-server-2019)**
Description
Microsoft Hyper-V Server is a free product that delivers enterprise-class virtualization for your datacenter and hybrid cloud. Microsoft Hyper-V Server 2019 provides new and enhanced features that can help you deliver the scale and performance needs of your mission-critical workloads.

The Windows hypervisor technology in Microsoft Hyper-V Server 2019 is the same as what's in the Microsoft Hyper-V role on Windows Server 2019. It is a stand-alone product that contains only the Windows hypervisor, a Windows Server driver model, and virtualization components. It provides a simple and reliable virtualization solution to help you improve your server utilization and reduce costs.

## Why is Hyper-V considered a type 1 hypervisor?
**[Hyper-V type 1 hypervisor](https://community.spiceworks.com/topic/2331576-why-is-hyper-v-considered-a-type-1-hypervisor-and-not-a-type-2-hypervisor)**
"Hyper-V is a Type 1 hypervisor because it places the hypervisor layer underneath the "management" Windows OS. If you enable the Hyper-V components in a full Windows OS installation, you are basically converting the Windows OS to a special virtual machine that runs side by side with other virtual machines. There's more nuance to it of course, but that's an exercise for the reader."

## Hyper-V secure boot
**[secure boot](https://bobcares.com/blog/hyper-v-secure-boot-disable/#:~:text=for%20our%20customers.-,Secure%20boot%20in%20Hyper%2DV,boot%20option%20is%20not%20available)**
Secure boot in Hyper-V
Secure boot is a feature of UEFI. It helps to prevent unauthorized firmware, operating systems, or UEFI drivers running at boot time.

## Hyper-V enhanced session mode
**[enhanced session mode](https://4sysops.com/archives/activate-enhanced-session-mode-for-ubuntu-vms-in-hyper-v/)**

In contrast to simple mode, enhanced session mode allows copy/paste between host and guest. This means that files can also be exchanged between the two systems in this way.

Another significant advantage is that you can control the resolution of the guest OS right at startup via the virtual machine. In simple mode, on the other hand, you have to adjust the screen size from within the guest OS using Linux tools.

## Hyper-V Failover cluster
**[Hyper-V cluster](https://www.altaro.com/hyper-v/failover-cluster-manager/)**
Hyper-V is inherently a host-bound service. It controls all of the resources that belong to the physical machine, but that is the extent of its reach. This is where Microsoft Failover Clustering comes in.

Failover Clustering works alongside Hyper-V to protect virtual machines, but it is a separate technology. As a result, it uses its own management interface, aptly named “Failover Cluster Manager”.

## What is VMWare ESXi?
**[ESXi](https://www.parallels.com/blogs/ras/vmware-esxi/)**
"What Is the VMware ESXi Server and Its Role in the VMware Suite?
VMware ESXi is the bare-metal hypervisor in the VMware vSphere virtualization platform. As a bare-metal hypervisor for creating and running virtual machines (VMs), VMware ESXi runs on top and accesses the hardware directly without the need to install an operating system. This direct access to hardware allows it to perform better, run faster and be more scalable than other types of hypervisors. This makes VMware ESXi ideal for use in a large-scale virtual desktop infrastructure (VDI), in conjunction with the other components in the VMware vSphere platform."

## What is the difference between a type 1 and type 2 hypervisor
**[Hypervisor types](https://www.makeuseof.com/type-1-vs-type-2-hypervisor-what-is-the-difference/)**
"Type 1 or bare-metal hypervisor is a virtualization software used to create virtual machines on top of the computer hardware. Direct hardware installation allows Type 1 hypervisors to be fast, efficient, and have better security when compared to a Type 2 hypervisor. The popular types of Type 1 hypervisors include VMware ESXi, Microsoft Hyper-V, and Citrix XenServer.
A Type 2 or hosted hypervisor is a virtualization software installed on top of the host operating system that supports virtualization. Since it works on top of an operating system, Type 2 hypervisors are not as fast, efficient, or secure as Type 1 hypervisors. They are, however, sufficient for various Type 2 hypervisor applications, like using a virtual machine to test a new operating system.

Some popular Type 2 hypervisors used today include VirtualBox, VMware Workstation, and VMware Fusion.
"

## VMWare ESXi cluster
**[ESXi cluster](https://www.nakivo.com/blog/configuring-vmware-esxi-cluster/)**
In a VMware ESXi cluster configuration, multiple ESXi hosts provide the compute, memory, and network resources to the cluster environment as a whole as well as protect cluster-housed VMs against physical server failures. This is accomplished by using a VMware vCenter Server, which is a requirement to create a VMware ESXi cluster. Once created, a vSphere cluster enables “cluster only” features such as HA (high availability) and DRS (distributed resource scheduler). Each of these features contributes to the tolerance of the VMware cluster, failure resilience as well as the distribution of resources across the VMware ESXi hosts. Let us take a look at the process of creating a VMware ESXi Cluster.




