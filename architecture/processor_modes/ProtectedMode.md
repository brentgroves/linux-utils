https://en.wikipedia.org/wiki/Protected_mode
In computing, protected mode, also called protected virtual address mode,[1] is an operational mode of x86-compatible central processing units (CPUs). It allows system software to use features such as virtual memory, paging and safe multi-tasking designed to increase an operating system's control over application software.[2][3]

When a processor that supports x86 protected mode is powered on, it begins executing instructions in real mode, in order to maintain backward compatibility with earlier x86 processors.[4] Protected mode may only be entered after the system software sets up one descriptor table and enables the Protection Enable (PE) bit in the control register 0 (CR0).[5]

Protected mode was first added to the x86 architecture in 1982,[6] with the release of Intel's 80286 (286) processor, and later extended with the release of the 80386 (386) in 1985.[7] Due to the enhancements added by protected mode, it has become widely adopted and has become the foundation for all subsequent enhancements to the x86 architecture,[8] although many of those enhancements, such as added instructions and new registers, also brought benefits to the real mode.

Multitasking
Further information: Computer multitasking
Through the use of the rings, privileged call gates, and the Task State Segment (TSS), introduced with the 286, preemptive multitasking was made possible on the x86 architecture. The TSS allows general-purpose registers, segment selector fields, and stacks to all be modified without affecting those of another task. The TSS also allows a task's privilege level, and I/O port permissions to be independent of another task's.

In many operating systems, the full features of the TSS are not used.[42] This is commonly due to portability concerns or due to the performance issues created with hardware task switches.[42] As a result, many operating systems use both hardware and software to create a multitasking system.[43]