https://hardwaresecrets.com/everything-you-need-to-know-about-the-intel-virtualization-technology/
Everything You Need to Know About the Intel Virtualization Technology
Several Intel CPUs come with the Intel Virtualization Technology (VT). Formerly known as Vanderpool, this technology enables a CPU to act as if you have several independent computers, in order to enable several operating systems to run at the same time on the same machine. In this tutorial we will explain everything you need to know about this technology.

Intel’s virtualization technology is available in two versions: VT-x, for x86 processors; and VT-i, for Itanium (i.e., IA-64) processors. In this tutorial we will be covering the details of the VT-x technology.

[amazon box=”B072NF4BY3″ template=”table”]

Virtualization technology is nothing new. There is some software on the market that enables virtualization; probably VMware is the most famous one. (Click here for a complete list of virtualization software available on the market.) With this technique, you can “partition” a single computer to act as if it were several independent computers, allowing the system to run several operating systems at the same time. These operating systems can even be different (e.g., you can run Windows in one virtual machine and Linux in another).

You may confuse virtualization with multitasking, multi-core, or Hyper-Threading. When multitasking, there is a single operating system and several programs running at the same time. With virtualization, you can have several operating systems running in parallel, each one with several programs running. Each operating system runs on a “virtual machine,” i.e., each operating system thinks it is running on a completely independent computer.

Multi-core technology allows a single processor to have more than one physical processor inside. For example, a computer with one dual-core processor acts as if it were a computer with two CPUs installed, working under a mode called symmetrical multiprocessing (SMP). Even though multi-core CPUs have more than one processor inside, they cannot be used independently. The operating system is run by the first CPU core, and the additional cores the CPU may have must be used by the same operating system. So, based on any explanation, there is no difference between a single-core CPU and a multi-core one.

Hyper-Threading technology simulates an additional processor per CPU core. For example, a dual-core CPU with Hyper-Threading technology is seen by the operating system as if it were a quad-core CPU. These additional processors cannot run separate operating systems, so for the operating system the Hyper-Threading technology has the same effect as the multi-core technology.

The diagrams below may help you understand the differences between those technologies.

If you pay close attention, Virtualization Technology uses the same idea as the Virtual 8086 (V86) mode, which has been available since the 386 processor. With the V86 mode you can create several virtual 8086 machines to run DOS-based programs at the same time, each one “thinking” that it is running in a completely independent computer. With VT you can create several “complete” virtual machines to run full operating systems simultaneously.

If there is software such as VMware that enables virtualization, why implement Virtualization Technology inside the CPU? The advantage is that CPUs with Virtualization Technology have some new instructions to control virtualization. With them, controlling software (called VMM, Virtual Machine Monitor) can be simpler, thus improving performance compared to software-based solutions. When the CPU has support to Virtualization Technology, the virtualization is said to be hardware-based or hardware-assisted.

Processors with Virtualization Technology have an extra instruction set called Virtual Machine Extensions or VMX. VMX brings 10 new virtualization-specific instructions to the CPU: VMPTRLD, VMPTRST, VMCLEAR, VMREAD, VMWRITE, VMCALL, VMLAUNCH, VMRESUME, VMXOFF, and VMXON.

