https://www.inmotionhosting.com/support/server/linux/check-memory-usage/#:~:text=Linux%20free%20%2Dm,-The%20most%20common&text=1024%20MB%20is%20the%20total,free%20to%20use%20if%20needed.

reports31

free -m 
               total        used        free      shared  buff/cache   available
Mem:            7854        2863        2835           1        2156        4721
Swap:           4095           0        4095


HugePages is a feature integrated into the Linux kernel 2.6. Enabling HugePages makes it possible for the operating system to support memory pages greater than the default (usually 4 KB). Using very large page sizes can improve system performance by reducing the amount of system resources required to access page table entries. HugePages is useful for both 32-bit and 64-bit configurations. HugePage sizes vary from 2 MB to 256 MB, depending on the kernel version and the hardware architecture. For Oracle Databases, using HugePages reduces the operating system maintenance of page states, and increases Translation Lookaside Buffer (TLB) hit ratio

Non-volatile Memory Express (NVMe) is an interface that allows host software utility to communicate with solid state drives. Use the following types of fabric transport to configure NVMe over fabric devices:
