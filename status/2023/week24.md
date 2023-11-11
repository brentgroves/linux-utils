I love you my son and have a great plan for you and all people so please stay close to me!
Father thank you for all that you do for your people and all of your creation.
You purpose it to help everyone that you can in every way that I give you the opportunity.
Don't forget that I have a plan for you and love you no matter what or how you perform!
Your purpose my son is to look for ways to help people. You are not your body or your memories which will deterorate and fade over time. Trust in my love for you and my ability to take care of you when your body deterorates and your memory fades!
Once I got the base php devcontainer installed from the website I added the docker from docker and kubernetes and help features and the container was rebuilt fine and xdebug still worked.

Next try to build an image with the cli
https://github.com/devcontainers/cli so maybe you can take those features out of the devcontainer.json file when using the new image.
Good morning dear ones,
I hope you and your loved ones had a nice weekend and you are feeling refreshed enough to enjoy your work or at least to make it through this Monday morning :-) What a pleasure it is to work with each one you.  I feel very grateful to have the oppurtunity to be a part of our team.  Thank you for your patience and kindness and please feel free to contact me to help with anything at home or at work!
-Sincerely yours
Brent
260-564-4868

# Big Picture
1. Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases. This includes validating our result sets to ensure they match what Plex shows on its reports and screens.   
2. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
3. Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-syncronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.

# What are Development Containers?
**[development containers](https://containers.dev/)**
**[github devt containers](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers)**

"A Development Container (or Dev Container for short) allows you to use a container as a full-featured development environment. It can be used to run an application, to separate tools, libraries, or runtimes needed for working with a codebase, and to aid in continuous integration and testing. Dev containers can be run locally or remotely, in a private or public cloud."

IMO this seems like a great way to develop software and thought we should use it when creating the reporting software.  Fortunately Microsoft thinks so too and has invested much effort in development container integration with VS Code which is my IDE of choice.  So I am currently working on modifying Laravel's development container so we can leverage some of VS Code's development container features for the reporting UI. 

# How has development changed with dev containers?
Microsoft is making money from dev containers through github codespaces but if you install docker on your development system you don't need to purchase codespaces which are VMs running the docker containers that you can communicate securely with from your home or business.

**[golang with postgress](https://github.com/devcontainers/templates/tree/main/src/go-postgres)**
Let's say you want to write a program in golang that uses a postgres database.  Well you can easily find a tutorial but you need to install golang and postgress before you get started.  With dev containers you can go to the github template repo and the go-postgress template and when you run it VS Code will create a container with golang compiler and debugging tools, git CLI, and any other VSCode extensions you want to add.  It will also create another container with postgress installed and the port mappings you need to access it from your golang container or your localhost. So all that you really need to do is add the .devcontainer directory to your VS Code project and copy the source code for the tutorial into some file which will be mounted to the golang container and run it. 

This way of development will save much time setting up development systems and ensures development environments are identical and testing is done before checkins if desired.

With the switch to dev containers and VS Code a repo not only has your source code but it also contains a .devcontainer directory containing a docker image, dockerfile, or a docker-compose file and a devcontainer.json file with information such as needed VSCode extensions and bindings to the local file system or docker volume, and mapping to the local docker installation and .kube directory containing every Kubernetes Clusters you connect to.

The end result is when VSCode sees that your project has a .devcontainer directory it downloads all the docker images your application needs, starts the containers and VS Coder server and connects remotely to it without you having to install anything except docker on your computer.  So anyone can work on the project no matter if they are using Windows WSL2, Mac OS, or Linux as long as the have docker installed and have an Azure Dev OPs or Github account to access the project.

# What is a codespace?
**[github codespaces](https://docs.github.com/en/codespaces/overview)**
"A codespace is a development environment that's hosted in the cloud. You can customize your project for GitHub Codespaces by committing configuration files to your repository (often known as Configuration-as-Code), which creates a repeatable codespace configuration for all users of your project."

This looks like a good way to go if you want to use development containers from the cloud. 


# Development Containers VM, devcon2
Worked on devcon2 VM on Hyper-V running on mgalb-hv1.busche-cnc.com. Used cubic and QEMU to install RDP and SSH servers on the Ubuntu-22.04 desktop ISO image. This new ISO image allows us to use RDP or SSH to connect to the VM without using the Hyper-V connect feature. 

## Why Run VS Code inside a Docker container  
**[Dev Containers tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial)**
- Once the development environment is setup the way the team wants it we can publish it to either dockerhub or our private Azure container repository.
- Anyone in our team can pull the image onto there own system and start development without delay.
- I'm currently using a PHP development container but you can easily create or use one of the default containers for most popular languages.
- You can create and deploy docker images to Kubernetes from the development container. 
**[Deploy to Kubernetes](https://code.visualstudio.com/remote/advancedcontainers/use-docker-kubernetes)**

## How does it work
- All the development software is installed in a docker image.
- After the container is built, VS Code automatically connects to it and maps the project folder from your local file system into the container.
- your local copy of Visual Studio Code connects to the Visual Studio Code Server running inside of your new dev container.

# Research Activity
## What is Cubic.
Used qemu and **[cubic](https://github.com/PJ-Singh-001/Cubic)** to create a custom ISO from the official Ubuntu 22.04 desktop ISO. This image now includes an SSH and RDP server and we can add the VS Code server and other development utilities in the furture if desired. 
## What is QEMU? 
**[QEMU](https://www.qemu.org)** is an open source machine emulator and virtualizer. 
## Compare some populare desktop protocals.
https://en.wikipedia.org/wiki/Comparison_of_remote_desktop_software
VNC, RDP, NX, SPICE,
### RDP
RDP works great on Ubuntu's default desktop environment GNOME 42.5 
### VNC
https://bytexd.com/how-to-install-configure-vnc-server-on-ubuntu/
"If you have worked with Microsoft Remote Desktop Protocol (RDP) before, think of VNC as an open-source alternative. Works with GNOME 42.5"
https://kb.wisc.edu/biochem/it/page.php?id=127360
https://gist.github.com/indyfromoz/739cd53d47b91ba1d3b540ab53b1f46c
### X2go 
**[X2go](https://en.wikipedia.org/wiki/X2Go)**
Works with many traditional desktop environments such as LXDE and XFCE
X2Go is open source remote desktop software for Linux that uses a modified NX 3 protocol.[7]
https://wiki.x2go.org/doku.php/download:start
https://wiki.x2go.org/doku.php/doc:installation:x2goserver
### Spice
**[spice](https://spice-space.org/)**
"The SPICE project aims to provide a complete open source solution for remote access to virtual machines in a seamless way so you can play videos, record audio, share usb devices and share folders without complications."
Meant to work with KVM virtual machines.

## How to connect to Virtual Machines with HTML5?
### Azure Bastian
**[Azure Bastian](https://azure.microsoft.com/en-us/products/azure-bastion)**
"Azure Bastion is a fully managed service that provides more secure and seamless Remote Desktop Protocol (RDP) and Secure Shell Protocol (SSH) access to virtual machines (VMs) without any exposure through public IP addresses. Provision the service directly in your local or peered virtual network to get support for all the VMs within it."
### Apache guacamole? 
**[guacamole](https://guacamole.apache.org/)**
"Apache Guacamole is a clientless remote desktop gateway. It supports standard protocols like VNC, RDP, and SSH.
We call it clientless because no plugins or client software are required.
Thanks to HTML5, once Guacamole is installed on a server, all you need to access your desktops is a web browser."
## How to create a gist in github?
## Can we access remote Kubernetes Clusters and the docker environment configured on the local host from a Development Container?
Modified the Reports development container to do this.
