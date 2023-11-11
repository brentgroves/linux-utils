https://www.makeuseof.com/tag/virtualbox-vs-vmware-vs-hyper-v/?newsletter_popup=1

https://www.infinitivehost.com/blog/hyper-v-vs-vmware-which-is-better/#:~:text=When%20it%20comes%20to%20memory,it%20comes%20to%20storage%20deployment.

## Proxmox VE, VMware ESXi, Hyper-V type 1 hypervisor comparison 
**[Comparing Proxmox VE,VMware ESXi, Hyper-V](https://4sysops.com/archives/proxmox-ve-vs-vmware-esxi-vs-hyper-v/)**
The following table shows the supported host maximums:
Proxmox VE,VMware ESXi,Hyper-V
Maximum logical CPUs per host:	768,896,512
Maximum RAM per host:12 TB,24 TB,48 TB
Nodes per cluster:No explicit limit,96,64
Maximum VMs per host:No explicit limit,1024,1024
Comparison at a glance
The following table shows a quick side-by-side comparison of Proxmox VE, VMware ESXi, and Hyper-V:

Features	Proxmox VE	VMware ESXi	Hyper-V
Based on	Linux KVM	VMkernel	Windows
Product type	Open source	Proprietary	Proprietary
Central management	Built-in	Supported with paid license	Supported
High availability	Supported	Supported	Supported
Load balancing	Supported	Supported	Supported
Live VM migration	Supported	Available with paid license	Supported
Migration/Conversion	Possible with third-party tools	Possible with native and third-party tools	Possible with native and third-party tools
Backup and restore	Supported	Supported	Supported
Licensing/Pricing	Free	Free with limited features, fully featured paid license	Free/included with Windows license
Support and updates	Subscription	Subscription	Included with Windows
Remote management options	Web client and CLI	Web client, CLI, PowerCLI, vCenter Server, System Center—Virtual Machine Manager (VMM)	Hyper-V manager, PowerShell, Windows Admin Center (WAC), System Center—Virtual Machine Manager (VMM), vCenter Server
Market share	Low	High	Medium

### Proxmox VE
Despite providing enterprise-class features, Proxmox VE is mainly adopted by technology enthusiasts in lab environments, home users, development teams, small businesses, and organizations that cannot afford (or do not want to spend much) on expensive licenses. It doesn't mean Proxmox can't handle the requirements of a large-scale enterprise. In fact, it is built to stand and scale massive deployments, but so far, it has rarely been adopted by large companies for running production workloads.
### VMware ESXi
VMware ESXi is the first choice of enterprise environments for running production workloads, since it is highly popular, well-established, well-documented, and offers the best technical support when needed. It gives organizations everything they could ever need to run, manage, and scale their server infrastructure.
### Hyper-V
Hyper-V has gained significant attention and has emerged as a top competitor of VMware for datacenter virtualization. It is suitable for companies running mostly Windows-based infrastructure. It is stable, well established, and has access to Microsoft support.

# Hyper-V vs ESXi
**[Hyper-V vs ESXi](https://www.infinitivehost.com/blog/hyper-v-vs-vmware-which-is-better/#:~:text=When%20it%20comes%20to%20memory,it%20comes%20to%20storage%20deployment)**

**[Differences between the 2 type 1 hypervisors](https://cloudinfrastructureservices.co.uk/hyper-v-vs-esxi-whats-the-difference/)**

Primarily, Hyper-V, allows the creation and operation of a software virtual machine (VM). With Hyper-V, numerous virtual machines run simultaneously on a single computer, each with its operating system. 

Microsoft Hyper-V is a Type 1 Hypervisor in addition to being a Type 2 Hypervisor. In Hyper-V, there are parent and child partitions. The host OS is run on the parent partition, while each child partition is a virtual machine (VM) with an installed guest operating system. The same hardware resources are used by the host, the VMs, and both.

It is possible to create many virtual machines on a single Hyper-V host. You can also check out Azure Hyper-V and understand how to set it up on the Azure cloud platform. Three versions of Hyper-V are available: Hyper-V for Windows Servers, Hyper-V Servers, and Hyper-V for Windows 10. 

Importantly, Hyper-V for Windows Servers is a property of the Windows Server operating system. As with Hyper-V for Windows Servers, Hyper-V Servers is a standalone program that you may use to administer virtual and dedicated server instances. 

The version of Hyper-V that operates on your laptop also runs on Windows 10. You require a 64-bit OS to enable Hyper-V on your Windows device. Hence, Windows 10 is not the only option, though. Windows 8.1 also functions.