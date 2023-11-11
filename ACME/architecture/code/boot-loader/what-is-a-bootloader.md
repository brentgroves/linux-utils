Testing the Bootloader
Perhaps the easiest way to test a bootloader is inside a virtual machine, like VirtualBox or VMware.[1]

Sometimes it is useful if the bootloader supports the GDB remote debug protocol.[2]

Further Reading
 ["How to develop your own Boot Loader" by Alex Kolesnyk 2009](https://www.codeproject.com/Articles/36907/How-to-develop-your-own-Boot-Loader#_Toc231383187)
 "RedBoot Debug and Bootstrap Firmware"

https://en.wikibooks.org/wiki/X86_Assembly/Bootloaders
What is a Bootloader?
Bootloaders are small pieces of software that play a role in getting an operating system loaded and ready for execution when a computer is turned on. The way this happens varies between different computer designs (early computers required a person to manually set the computer up whenever it was turned on), and often there are several stages in the process of boot loading.

It's crucial to understand that the term "bootloader" is simply a classification of software (and sometimes a blurry one). To the processor, a bootloader is just another piece of code that it blindly executes. There are many different kinds of boot loaders. Some are small, others are large; some follow very simple rules while others show fancy screens and give the user a selection to choose from.

On IBM PC compatibles, the first program to load is the Basic Input/Output System (BIOS). The BIOS performs many tests and initialisations, and if everything is OK, the BIOS's boot loader begins. Its purpose is to load another boot loader! It selects a disk (or some other storage media) from which it loads a secondary boot loader.

In some cases, this boot loader loads enough of an operating system to start running it. In other cases, it loads yet another boot loader from somewhere else. This often happens when multiple operating systems are installed on a single computer; each OS may have its own specific bootloader, with a "central" bootloader that loads one of the specific ones according to the user's selection.

Most bootloaders are written exclusively in assembly language (or even machine code), because they need to be compact, they don't have access to OS routines (such as memory allocation) that other languages might require, they need to follow some unusual requirements, and they make frequent use of low-level features. However some bootloaders, particularly those that have many features and allow user input, are quite heavyweight. These are often written in a combination of assembly and C. The GRand Unified Bootloader (GRUB) is an example of such.

Some boot loaders are highly OS-specific, while others are less so - certainly the BIOS boot loader is not OS-specific. The MS-DOS boot loader (which was placed on all MS-DOS formatted floppy disks) simply checks if the files IO.SYS and MSDOS.SYS exist; if they are not present it displays the error "Non-System disk or disk error" otherwise it loads and begins execution of IO.SYS.

The final stage boot loader may be expected (by the OS) to prepare the computer in some way, for instance by placing the processor in protected mode and programming the interrupt controller. While it would be possible to do these things inside the OS's initialisation procedure, moving them into the bootloader can simplify the OS design. Some operating systems require their bootloader to set up a small, basic GDT (Global Descriptor Table) and enter protected mode, in order to remove the need for the OS to have any 16-bit code. However, the OS might replace this with its own sophisticated GDT soon after.

The Bootsector
The first 512 bytes of a disk are known as the bootsector or Master Boot Record. The boot sector is an area of the disk reserved for booting purposes. If the bootsector of a disk contains a valid boot sector (the last word of the sector must contain the signature 0xAA55), then the disk is treated by the BIOS as bootable.

The Boot Process
When switched on or reset, an x86 processor begins executing the instructions it finds at address FFFF:0000 (at this stage it is operating in Real Mode) (Intel Software Developer's Manual Volume 3 Chapter 9 contradicts this information: Execution starts at the physical address 0xFFFFFFF0, among other things). In IBM PC compatible processors, this address is mapped to a ROM chip that contains the computer's Basic Input/Output System (BIOS) code. The BIOS is responsible for many tests and initialisations; for instance the BIOS may perform a memory test, initialise the interrupt controller and system timer, and test that these devices are working.

Eventually the actual boot loading begins. First the BIOS searches for and initialises available storage media (such as floppy drives, hard disks, CD drives), then it decides which of these it will attempt to boot from. It checks each device for availability (e.g. ensuring a floppy drive contains a disk), then the 0xAA55 signature, in some predefined order (often the order is configurable using the BIOS setup tool). It loads the first sector of the first bootable device it comes across into RAM, and initiates execution.

Ideally, this will be another boot loader, and it will continue the job, making a few preparations, then passing control to something else.

While BIOSes remain compatible with 20-year-old software, they have also become more sophisticated over time. Early BIOSes could not boot from CD drives, but now CD and even DVD booting are standard BIOS features. Booting from USB storage devices is also possible, and some systems can boot from over the network. To achieve such advanced functioning, BIOSes sometimes enter protected mode and the like, but then return to real mode in order to be compatible with legacy boot loaders. This creates a chicken-and-egg problem: bootloaders are written to work with the ubiquitous BIOS, and BIOSes are written to support all those bootloaders, preventing much in the way of new boot loading features.

However, a new bootstrap technology, the UEFI, is beginning to gain momentum. It is much more sophisticated and will not be discussed in this article.

Note also that other computer systems - even some that use x86 processors - may boot in different ways. Indeed, some embedded systems whose software is compact enough to be stored on ROM chips may not need bootloaders at all.

Technical Details
A bootloader runs under certain conditions that the programmer must appreciate in order to make a successful bootloader. The following pertains to bootloaders initiated by the PC BIOS:

The first sector of a drive contains its boot loader.
One sector is 512 bytes — the last two bytes of which must be 0xAA55 (i.e. 0x55 followed by 0xAA), or else the BIOS will treat the drive as unbootable.
If everything is in order, said first sector will be placed at RAM address 0000:7C00, and the BIOS's role is over as it transfers control to 0000:7C00 (that is, it JMPs to that address).
The DL register will contain the drive number that is being booted from, useful if you want to read more data from elsewhere on the drive.
The BIOS leaves behind a lot of code, both to handle hardware interrupts (such as a keypress) and to provide services to the bootloader and OS (such as keyboard input, disk read, and writing to the screen). You must understand the purpose of the Interrupt Vector Table (IVT), and be careful not to interfere with the parts of the BIOS that you depend on. Most operating systems replace the BIOS code with their own code, but the boot loader can't use anything but its own code and what the BIOS provides. Useful BIOS services include int 10h (for displaying text/graphics), int 13h (disk functions) and int 16h (keyboard input).
This means that any code or data that the boot loader needs must either be included in the first sector (be careful not to accidentally execute data) or manually loaded from another sector of the disk to somewhere in RAM. Because the OS is not running yet, most of the RAM will be unused. However, you must take care not to interfere with the RAM that is required by the BIOS interrupt handlers and services mentioned above.
The OS code itself (or the next bootloader) will need to be loaded into RAM as well.
The BIOS places the stack pointer 512 bytes beyond the end of the boot sector, meaning that the stack cannot exceed 512 bytes. It may be necessary to move the stack to a larger area.
There are some conventions that need to be respected if the disk is to be readable under mainstream operating systems. For instance you may wish to include a BIOS Parameter Block on a floppy disk to render the disk readable under most PC operating systems.
Most assemblers will have a command or directive similar to ORG 7C00h that informs the assembler that the code will be loaded starting at offset 7C00h. The assembler will take this into account when calculating instruction and data addresses. If you leave this out, the assembler assumes the code is loaded at address 0 and this must be compensated for manually in the code.

Usually, the bootloader will load the kernel into memory, and then jump to the kernel. The kernel will then be able to reclaim the memory used by the bootloader (because it has already performed its job). However it is possible to include OS code within the boot sector and keep it resident after the OS begins.

Here is a simple bootloader demo designed for NASM:

         org 7C00h
 
         jmp short Start ;Jump over the data (the 'short' keyword makes the jmp instruction smaller)
 
 Msg:    db "Hello World! "
 EndMsg:
 
 Start:  mov bx, 000Fh   ;Page 0, colour attribute 15 (white) for the int 10 calls below
         mov cx, 1       ;We will want to write 1 character
         xor dx, dx      ;Start at top left corner
         mov ds, dx      ;Ensure ds = 0 (to let us load the message)
         cld             ;Ensure direction flag is cleared (for LODSB)
 
 Print:  mov si, Msg     ;Loads the address of the first byte of the message, 7C02h in this case
 
                         ;PC BIOS Interrupt 10 Subfunction 2 - Set cursor position
                         ;AH = 2
 Char:   mov ah, 2       ;BH = page, DH = row, DL = column
         int 10h
         lodsb           ;Load a byte of the message into AL.
                         ;Remember that DS is 0 and SI holds the
                         ;offset of one of the bytes of the message.
 
                         ;PC BIOS Interrupt 10 Subfunction 9 - Write character and colour
                         ;AH = 9
         mov ah, 9       ;BH = page, AL = character, BL = attribute, CX = character count
         int 10h
 
         inc dl          ;Advance cursor
 
         cmp dl, 80      ;Wrap around edge of screen if necessary
         jne Skip
         xor dl, dl
         inc dh
 
         cmp dh, 25      ;Wrap around bottom of screen if necessary
         jne Skip
         xor dh, dh
 
 Skip:   cmp si, EndMsg  ;If we're not at end of message,
         jne Char        ;continue loading characters
         jmp Print       ;otherwise restart from the beginning of the message
 
 
 times 0200h - 2 - ($ - $$)  db 0    ;Zerofill up to 510 bytes
 
         dw 0AA55h       ;Boot Sector signature
 
 ;OPTIONAL:
 ;To zerofill up to the size of a standard 1.44MB, 3.5" floppy disk
 ;times 1474560 - ($ - $$) db 0

To compile the above file, suppose it is called 'floppy.asm', you can use following command:

nasm -f bin -o floppy.img floppy.asm
While strictly speaking this is not a bootloader, it is bootable, and demonstrates several things:

How to include and access data in the boot sector
How to skip over included data (this is required for a BIOS Parameter Block)
How to place the 0xAA55 signature at the end of the sector (NASM will issue an error if there is too much code to fit in a sector)
The use of BIOS interrupts
On Linux, you can issue a command like

cat floppy.img > /dev/fd0
to write the image to the floppy disk (the image may be smaller than the size of the disk in which case only as much information as is in the image will be written to the disk). A more sophisticated option is to use the dd utility:

 dd if=floppy.img of=/dev/fd0
Under Windows you can use software such as RAWRITE.

Testing the Bootloader
Perhaps the easiest way to test a bootloader is inside a virtual machine, like VirtualBox or VMware.[1]

Sometimes it is useful if the bootloader supports the GDB remote debug protocol.[2]

Further Reading
 "How to develop your own Boot Loader" by Alex Kolesnyk 2009
 "RedBoot Debug and Bootstrap Firmware"
