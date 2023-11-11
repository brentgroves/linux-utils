# Create a VM to run development containers
Requirement:
a development container can have many containers running at one time and I have found that running the containers on an 8GB i7 system is sluggish so I asked if it would be ok to create a VM with 32GB.  
Hyper-V:
I got the ok to use the newly created Windows Server 2019 Hyper-V enabled mgalb-hv1 system for this purpose. 
Custom-ISO:
To ensure Ubuntu works well under Hyper-V and we can use RDP to connect I wanted to install some additional software.
https://askubuntu.com/questions/1440141/just-upgraded-hyper-v-machine-to-ubuntu-22-04-1-lts-server-edition-now-keyboard
https://www.makeuseof.com/create-custom-ubuntu-iso-cubic/
