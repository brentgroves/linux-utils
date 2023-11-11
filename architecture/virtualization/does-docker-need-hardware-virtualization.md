https://www.unixtutorial.org/does-docker-need-hardware-virtualization/

Is Docker a Virtualization?
In a sense of allowing you to run multiple independent environments on the same physical host, yes. Docker containers allow you to run processes in isolation from each other and from the base OS – you decide and specify if you want base system to share any resources (IP addresses, TCP ports, directories with files) with any of the containers.

The key difference from KVM or VMware virtualization is that Docker is not using hardware virtualization. Instead, it leverages Linux functionality: namespaces and control groups.

Linux namespaces are provided and supported by Linux kernel to allow separation (virtualization) of process ID space (PID numbers), network interfaces, interprocess communication (IPC), mount points and kernel information.

Control groups in Linux allow accurate resource control: using control groups allows Docker to limit CPU or memory usage for each container.

Does Docker use Hardware Virtualization?
The short answer is: no. Docker needs a 64-bit Linux OS running a modern enough kernel to operate properly. Which means if that what you have happily running on your hardware without hw virtualization support, it will be plenty enough for Docker.

Now, this gets a bit tricky when you’re talking about Docker in Windows or MacOS. They don’t have a native Linux environment, so they have to run a Linux virtual machine that runs the Docker engine. You then typically have command line tools installed in your base OS (Windows or MacOS) that allow seamless management of the Docker containers in the Docker VM.

Does Your CPU Support Hardware Virtualization?
You can grep the special /proc/cpuinfo file for a quick answer:

if it contains vmx – you have an Intel CPU and it supports HW virtualization if it contains svm – you have an AMD CPU and it supports HW virtualization Here’s how this looks on my XPS laptop:

