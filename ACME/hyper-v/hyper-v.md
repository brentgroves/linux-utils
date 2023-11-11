10.1.0.14 mgalb-hv1.busche-cnc.com    
curl https://releases.ubuntu.com/23.04/ubuntu-23.04-desktop-amd64.iso --output ubuntu-23.iso

https://techcommunity.microsoft.com/t5/virtualization/bg-p/Virtualization

https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/supported-ubuntu-virtual-machines-on-hyper-v

https://blog.jitdor.com/2020/02/08/enable-hyper-v-integration-services-for-your-ubuntu-guest-vms/

For some legacy reasons, my main hypervisor has been Hyper-V running on a Windows Server. And contrary to popular belief, Linux actually supports Secure Boot and UEFI boot pretty well, and so you can create Generation 2 VM that runs Linux OS just fine. However, after installing the OS, you might have noticed that Hyper-V doesn’t talk to the guest VM very well – features such as shutdown or reset do not work. That is because the Linux kernel does not include Hyper-V drivers and agents. This is akin to VMware’s vmtools for the ESXi platform.

This can be easily rectified by manually installing those components. First, you will have to edit the file at /etc/initramfs-tools/modules and add in the following modules:

hv_utils
hv_vmbus
hv_storvsc
hv_blkvsc
hv_netvsc
After saving the modules file, install the virtual tools:

apt install linux-virtual linux-cloud-tools-virtual linux-tools-virtual
Don’t forget to update initramfs:

update-initramfs -u
Finally, restart the VM. When all is done, you’ll notice your guest VM would run a little bit faster, and you are able to see Networking details of that Linux VM in your Hyper-V Manager. Shutdown and Reset commands from the Hyper-V to the Linux VM should also work.

Azure Kernel
If you do not want to mess with the above, you may also replace your Ubuntu main kernel with an Azure-tuned kernel. This is the same kernel which Microsoft runs on their Azure environment. Simply run the following command as root:

apt install linux-azure
