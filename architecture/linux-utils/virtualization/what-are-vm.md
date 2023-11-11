https://www.ibm.com/topics/virtual-machines

What are virtual machines (VMs)?
A virtual machine is a virtual representation, or emulation, of a physical computer. They are often referred to as a guest while the physical machine they run on is referred to as the host.

Virtualization makes it possible to create multiple virtual machines, each with their own operating system (OS) and applications, on a single physical machine. A VM cannot interact directly with a physical computer. Instead, it needs a lightweight software layer called a hypervisor to coordinate between it and the underlying physical hardware. The hypervisor allocates physical computing resources—such as processors, memory, and storage—to each VM. It keeps each VM separate from others so they don’t interfere with each other.

While this technology can go by many names, including virtual server, virtual server instance (VSI) and virtual private server (VPS), this article will simply refer to them as virtual machines.


What are virtual machines (VMs)?
A virtual machine is a virtual representation, or emulation, of a physical computer. They are often referred to as a guest while the physical machine they run on is referred to as the host.

Virtualization makes it possible to create multiple virtual machines, each with their own operating system (OS) and applications, on a single physical machine. A VM cannot interact directly with a physical computer. Instead, it needs a lightweight software layer called a hypervisor to coordinate between it and the underlying physical hardware. The hypervisor allocates physical computing resources—such as processors, memory, and storage—to each VM. It keeps each VM separate from others so they don’t interfere with each other.

While this technology can go by many names, including virtual server, virtual server instance (VSI) and virtual private server (VPS), this article will simply refer to them as virtual machines.

How virtualization works
When a hypervisor is used on a physical computer or server, (also known as bare metal server), it allows the physical computer to separate its operating system and applications from its hardware. Then, it can divide itself into several independent “virtual machines.”

Each of these new virtual machines can then run their own operating systems and applications independently while still sharing the original resources from the bare metal server, which the hypervisor manages. Those resources include memory, RAM, storage, etc.

The hypervisor acts like a traffic cop of sorts, directing and allocating the bare metal’s resources to each of the various new virtual machines, ensuring they don’t disrupt each other.

There are two primary types of hypervisors.

Type 1 hypervisors run directly on the physical hardware (usually a server), taking the place of the OS. Typically, you use a separate software product to create and manipulate VMs on the hypervisor. Some management tools, like VMware’s vSphere, let you select a guest OS to install in the VM.

You can use one VM as a template for others, duplicating it to create new ones. Depending on your needs, you might create multiple VM templates for different purposes, such as software testing, production databases, and development environments.

Type 2 hypervisors run as an application within a host OS and usually target single-user desktop or notebook platforms. With a Type 2 hypervisor, you manually create a VM and then install a guest OS in it. You can use the hypervisor to allocate physical resources to your VM, manually setting the amount of processor cores and memory it can use. Depending on the hypervisor’s capabilities, you can also set options like 3D acceleration for graphics.

The following video explains the basics of virtualization. Also check out the article, "5 Benefits of Virtualization."