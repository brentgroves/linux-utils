https://hardwaresecrets.com/everything-you-need-to-know-about-the-intel-virtualization-technology/
If you pay close attention, Virtualization Technology uses the same idea as the Virtual 8086 (V86) mode, which has been available since the 386 processor. With the V86 mode you can create several virtual 8086 machines to run DOS-based programs at the same time, each one “thinking” that it is running in a completely independent computer. With VT you can create several “complete” virtual machines to run full operating systems simultaneously.

If there is software such as VMware that enables virtualization, why implement Virtualization Technology inside the CPU? The advantage is that CPUs with Virtualization Technology have some new instructions to control virtualization. With them, controlling software (called VMM, Virtual Machine Monitor) can be simpler, thus improving performance compared to software-based solutions. When the CPU has support to Virtualization Technology, the virtualization is said to be hardware-based or hardware-assisted.

Processors with Virtualization Technology have an extra instruction set called Virtual Machine Extensions or VMX. VMX brings 10 new virtualization-specific instructions to the CPU: VMPTRLD, VMPTRST, VMCLEAR, VMREAD, VMWRITE, VMCALL, VMLAUNCH, VMRESUME, VMXOFF, and VMXON.

