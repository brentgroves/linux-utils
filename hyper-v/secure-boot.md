https://bobcares.com/blog/hyper-v-secure-boot-disable/#:~:text=for%20our%20customers.-,Secure%20boot%20in%20Hyper%2DV,boot%20option%20is%20not%20available.

Secure boot in Hyper-V
Secure boot is a feature of UEFI. It helps to prevent unauthorized firmware, operating systems, or UEFI drivers running at boot time.

By default, the secure boot is enabled for Generation 2 virtual machine.

For Generation 1 servers the secure boot option is not available.

If you have created a virtual machine with BIOS architecture OS in Generation 2 then the server will fail to load.

Thus, we need to recreate the virtual machine with Generation 1. Else we can disable the secure boot and make the server load.

 

Disable secure boot in Hyper-V
Recently one of the customers contacted us saying that he needs to disable the secure boot in Hyper-V for this VM to load. Now let’s discuss how our Support Engineers disable it for our customer.

 

From Hyper-V manager
First we open Hyper-V manager.

Then we select the virtual machine. We right-click on the virtual machine and click on Settings.

In the left pane, we click on the security tab.

Then under Secure Boot, we uncheck Enable Secure Boot.