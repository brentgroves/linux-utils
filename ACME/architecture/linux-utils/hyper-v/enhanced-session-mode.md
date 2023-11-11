https://4sysops.com/archives/activate-enhanced-session-mode-for-ubuntu-vms-in-hyper-v/

In contrast to simple mode, enhanced session mode allows copy/paste between host and guest. This means that files can also be exchanged between the two systems in this way.

Another significant advantage is that you can control the resolution of the guest OS right at startup via the virtual machine. In simple mode, on the other hand, you have to adjust the screen size from within the guest OS using Linux tools.

Configure VM and install Ubuntu
Extended session mode always requires a generation 2 VM, regardless of the guest OS.

When installing Ubuntu, you should disable Secure Boot in the VM's settings; otherwise, the setup will hang. The allocation of resources such as vCPU or vRAM is the same as when installing on physical hardware.

Install XRDP and XORGXRDP
Once you have set up Ubuntu in the VM and it boots successfully, you can start configuring enhanced session mode. This requires the RDP server xrdp as well as XORGXRDP.

The download and installation of these components can be simplified with the help of a shell script. This can be obtained via a URL based on the following pattern:

https://raw.githubusercontent.com/Hinara/linux-vm-tools/ubuntu20-04/ubuntu/<Version>/install.sh

For 20.04, this would be the address:

https://raw.githubusercontent.com/Hinara/linux-vm-tools/ubuntu20-04/ubuntu/20.04/install.sh
apt install -y linux-tools-virtual${HWE}
HWE=""
#HWE="-hwe-20.04"
Normally, even the minimal installation includes a web browser so you can load and save the script there. Alternatively, wget can be used on the command line.

After downloading install.sh, you need to make it executable in the user's download folder:

chmod +x install.sh

