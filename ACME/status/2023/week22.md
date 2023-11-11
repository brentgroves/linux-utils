I love you my son and will be here to guide and direct you always!
Thank you for giving us courage when facing hard and long physical problems as well as very difficult problems at work.
I love you and have a good plan for each of you today my son!
Do not worry about your hand or anything else just follow me and you will be fine and full of peace and joy always! Please encourage your teammates as best you can and I will help you in this effort.

# next
https://laravel.com/docs/10.x#next-steps
https://inertiajs.com/
JavaScript apps the monolith way
Inertia is a new approach to building classic server-driven web apps. We call it the modern monolith.

Inertia allows you to create fully client-side rendered, single-page apps, without the complexity that comes with modern SPAs. It does this by leveraging existing server-side patterns that you already love.

Inertia has no client-side routing, nor does it require an API. Simply build controllers and page views like you've always done! Inertia works great with any backend framework, but it's fine-tuned for Laravel.

# VMs / container comparison.
VMs rely on hardware virtualization instructions specific to Intel or AMD and allow installation of complete server or desktop operating systems.
Containers rely on features found in the Linux Kernal, namespaces and control groups this is why WSL2 now install a Linux virtual machine to better run docker containers.
Summary: one is OS specific and the other is CPU specific.  I think virtual machines are necessary because of the way container orchastrators work. Open Shift or Kubernetes relies on multiple VMs to achieve scalability and rendundancy so unless we rethink the way the orchestrators work it does not make sense to have 1 Linux system with 256 cores.

# Docker Compose / Kubernetes or Open Shift comparison
Microsoft now has adopted development containers which seems to be the way to develop and now prefered over creating a development VM using a platform such as **[Vagrant](https://www.vagrantup.com/) Single workflow to build and manage virtual machine environments**
Currently these development containers use docker compose to run all the services needed for an application to run.  The difference between docker compose and Kubernetes or Open Shift is that with docker compose all of the containers are running on the same host.  Since this is the case it is desirable to have a VM with lots of CPUs and lots of memory to run well.

DEVCON1
A VSCode devcontainer development environment is geared towards docker compose which runs all the services needed by an application on one computer. This way is fine but requires more memory so spend time creating a development VM with lots, 32 GB, of memory.
devcontainer for lavavel
https://blog.devsense.com/2022/laravel-on-docker
https://blog.devsense.com/2022/laravel-on-docker
curl -s "https://laravel.build/example-app?with=mysql,redis&devcontainer" | bash 
https://dev.to/manuelojeda/create-a-proper-debug-setup-in-vs-code-with-laravel-sail-57kn
https://github.com/theomessin/laravel-devcontainer
https://www.youtube.com/watch?v=ojWxCP1lT-Y
https://laravel.com/docs/8.x/sail
Using Devcontainers
If you would like to develop within a Devcontainer, you may provide the --devcontainer option to the sail:install command. The --devcontainer option will instruct the sail:install command to publish a default .devcontainer/devcontainer.json  file to the root of your application:

php artisan sail:install --devcontainer
Choosing Your Sail Services
When creating a new Laravel application via Sail, you may use the with query string variable to choose which services should be configured in your new application's docker-compose.yml file. Available services include mysql, pgsql, mariadb, redis, memcached, meilisearch, minio, selenium, and mailhog:
curl -s "https://laravel.build/example-app?with=mysql,redis" | bash
https://dev.to/manuelojeda/create-a-proper-debug-setup-in-vs-code-with-laravel-sail-57kn

Good morning dear ones,
I hope you and your loved ones had a splendid three-day weekend, and have that I have conveyed how important each of you are to me. If not you are!  If it doesn't seem like it then I'm doing something wrong, tell me, and I will attempt to do better :-)  As always please contact me at work or home for anything that you need and I will do my best to help you in any way that I can.
Sincerely yours
Brent
260-564-4868

# why containerize
The Albion controls guy tried to install Studio 5000 on Windows 10 which depends on the msxml4.dll but could not. He then proceded to try to find a way to install it. He was only able to find the current version of this library, msxml6, available to install as part of a service pack from the Microsoft downloads site. We then searched the internet and found that msxml4 SP2 could be installed from cnet. This kind of problem would not happen if the application was containerized. A containerized application includes every bit of software it needs to run, kindof like a complete VM but for one specific application. A very popular starting point for containerizing an application is the [Alpine image](https://hub.docker.com/_/alpine) which is only 5MB in size. From this starting point you then add all the software that is required to run your software. So by adding only 5MB overhead you can run your software without having to worry about if a new version of your OS does not contain an older version of a standard library that your software relies upon. Once you containerize your application you can test your software from the running container, and if it works you develop it you can be confident it will always work from Windows WSL2, Mac, or Linux.  
[Install WSL2 on Windows 10](https://pureinfotech.com/install-windows-subsystem-linux-2-windows-10/)
Microsoft made it simple it installs with just one command.

# Can we also containerize a development environment?
## vscode remote extension pack
Since the framework chosen for the reports UI has CLI support for a docker development environment I thought looking at the advantages of developing in docker would be a good idea.
Here is a list I found that makes sense to me :-)
[What are the advantages of developing with the vscode remote extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)?
- Develop on the same operating system you deploy to or use larger, faster, or more specialized hardware than your local machine.
- Quickly swap between different, separate development environments and make updates without worrying about impacting your local machine.
- Help new team members / contributors get productive quickly with easily spun up, consistent development containers.
- Take advantage of a Linux based tool-chain right from the comfort of Windows with WSL2 from a full-featured development tool.
- No source code needs to be on your local machine to gain these benefits since Remote Development runs commands and extensions directly on the remote machine.
## here is a tutorial if you want to try it
[Dev Containers tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial)
"This tutorial walks you through running Visual Studio Code in a Docker container using the Dev Containers extension. You need no prior knowledge of Docker to complete this tutorial.
Running VS Code inside a Docker container can be useful for many reasons, but in this walkthrough we'll focus on using a Docker container to set up a development environment that is separate from your local environment."

## So how can you connect to the remote system?
"This Remote Development extension pack includes four extensions:
Remote - SSH - Work with source code in any location by opening folders on a remote machine/VM using SSH. Supports x86_64, ARMv7l (AArch32), and ARMv8l (AArch64) glibc-based Linux, Windows 10/Server (1803+), and macOS 10.14+ (Mojave) SSH hosts.
Remote - Tunnels - Work with source code in any location by opening folders on a remote machine/VM using a VS Code Tunnel (rather than SSH).
Dev Containers - Work with a separate toolchain or container based application by opening any folder mounted into or inside a container.
WSL - Get a Linux-powered development experience from the comfort of Windows by opening any folder in the Windows Subsystem for Linux."

# A Big advantage of containerizing the development environment
It gets the developer thinking about deploying there application along with all of its required services to a container orchestrator such as Kubernetes or Open Shift right from the start of the development process.

# DEVCON1, 32 GB development VM 
A VSCode devcontainer development environment is geared towards docker compose which runs all the services needed by an application on one computer. This way is fine but requires more memory so spend time creating a development VM with lots, 32 GB, of memory.

# Azure Kubernetes Service (AKS)
Just like we have been using an Azure managed SQL server instance for our Plex long-running reports we also have created a one node AKS cluster for our reporting UI. Like the Azure SQL server managed instance does not require any maintenance or updates from the user either does the AKS cluster. We just deploy the applications, define storage and networking resources and the kubernetes software takes care of ensuring it is running properly.
[AKS](https://learn.microsoft.com/en-us/azure/aks/)
"The fully managed Azure Kubernetes Service (AKS) makes deploying and managing containerized applications easy. It offers serverless Kubernetes, an integrated continuous integration and continuous delivery (CI/CD) experience, and enterprise-grade security and governance. Unite your development and operations teams on a single platform to rapidly build, deliver, and scale applications with confidence."

# inertiajs
**[What is inertiajs](https://inertiajs.com/)**
"Not a framework
Inertia isn't a framework, nor is it a replacement for your existing server-side or client-side frameworks. Rather, it's designed to work with them. Think of Inertia as glue that connects the two. Inertia does this via adapters. We currently have three official client-side adapters (React, Vue, and Svelte) and two server-side adapters (Laravel and Rails).
At its core, Inertia is essentially a client-side routing library. It allows you to make page visits without forcing a full page reload. This is done using the <Link> component, a light-weight wrapper around a normal anchor link. When you click an Inertia link, Inertia intercepts the click and makes the visit via XHR instead. You can even make these visits programmatically in JavaScript using router.visit()."

# Some research activities
## What is XHR?
**[XMLHttpRequest](https://www.quora.com/What-is-XHR-XMLHttpRequest-and-how-does-this-work)**
XHR (XMLHttpRequest) is an API in the web browser that allows communication between the client (i.e. the web browser) and the server without reloading the entire page. XHR enables the creation of dynamic, fast and efficient web applications, by allowing partial updates of the page, based on the data received from the server.

## Can we containerize a graphics intensive application such as CAD? 
[Azure government](https://devblogs.microsoft.com/azuregov/new-container-and-compute-options-in-azure-government/)
"Containerize apps more easily with new compute services available in Azure Government including Azure Kubernetes Services (AKS) and Azure Container Instances (ACI); and use new NV series Virtual Machines for GPU accelerated graphics applications in scenarios such as data visualization, simulation, CAD, and rendering and streaming content."

## How to know which versions of TLS are enabled?
**[Which TLS versions are enabled](https://learn.microsoft.com/en-us/answers/questions/1006253/how-to-know-which-versions-of-tls-is-are-enabled-o)
## How to enable TLS 1.2 or 1.3 using a group policy?
Follow the instructions at **[TLS 1.2 and 1.3 group policy](https://thesecmaster.com/how-to-enable-tls-1-2-and-tls-1-3-via-group-policy/)**
## Does TLS ver 1.2 or 1.3 need to be installed on our servers?
**[TLS 1.2 and 1.3 notes](https://thesecmaster.com/how-to-enable-tls-1-2-and-tls-1-3-on-windows-server/#)**
A Short Note About TLS 1.2 and TLS 1.3: 
TLS is a cryptographic protocol that is used to secure communications over computer networks. TLS 1.2 and TLS 1.3 are the two latest versions of the Transport Layer Security (TLS) protocol. TLS 1.2 was finalized in 2008, and TLS 1.3 was finalized in 2018.

TLS 1.2 improves upon TLS 1.1 by adding support for Elliptic Curve Cryptography (ECC) and introducing new cryptographic suites that offer better security than the suites used in TLS 1.1. TLS 1.3 improves upon TLS 1.2 by simplifying the handshake process and making it more resistant to man-in-the-middle attacks. In addition, TLS 1.3 introduces new cryptographic suites that offer better security than the suites used in TLS 1.2.

TLS 1.2 and TLS 1.3 are both backward compatible with TLS 1.1 and earlier versions of the protocol. This means that a client that supports TLS 1.2 can communicate with a server that supports TLS 1.1 and vice versa. However, TLS 1.2 and TLS 1.3 are not compatible with each other. A client that supports TLS 1.2 cannot communicate with a server that supports TLS 1.3, and vice versa.

TLS 1.2 is the most widely used version of the TLS protocol, but TLS 1.3 is gaining in popularity. Many major web browsers, including Google Chrome, Mozilla Firefox, and Microsoft Edge, now support TLS 1.3. In addition, major Internet service providers, such as Cloudflare and Akamai, have started to support TLS 1.3 on their servers. Please visit this page if you want to deeply review the comparison of TLS implementations across different supported servers and clients.


## Are connections to Azure SQL managed instance encrypted?
**[Yes they are encrypted](https://www.sqltreeo.com/docs/azure-sql-database-and-sql-managed-instance-security-capabilities)**
SQL Database, SQL Managed Instance, and Azure Synapse Analytics enforce encryption (SSL/TLS) at all times for all connections. This ensures all data is encrypted "in transit" between the client and server irrespective of the setting of Encrypt or TrustServerCertificate in the connection string.
As a best practice, recommend that in the connection string used by the application, you specify an encrypted connection and not trust the server certificate. This forces your application to verify the server certificate and thus prevents your application from being vulnerable to man in the middle type attacks.
For example when using the ADO.NET driver this is accomplished via Encrypt=True and TrustServerCertificate=False. If you obtain your connection string from the Azure portal, it will have the correct settings.

## Is there a Linux CLI that does port forwarding?
## Are there programming libraries to perform port forwarding?
## How does VSCode remodte debugger work with PHP?
Port forwarding between the VSCode client and server is setup on port 8080 and 9003 when the project is loaded from info in the .devcontainer.json file.
A debug session is started on the VSCode client machine which acts as an DBGP protocol xdebug client listening on port 9003.
The developer runs the PHP server on the VSCode server machine.
The PHP server listens on port 8080 for network requests.
The PHP server which has been setup to use xdebug then connects to the VSCode client listening on port 9003 because a proxy has been setup to forward traffic on that port.
The xdebug server then accepts breakpoints from the VSCode client and waits for network requests.
The browser or user agent on the VSCode client machine makes a network request on port 8080, such as GET http://localhost:8000.
The network request is proxied to the VSCode server machine to the PHP xdebug server which processes the requests and halts on breakpoints.
The PHP xdebug server stops processing of the network request on the breakpoint and allows the VSCode client to examine all variables/
After examining variables the developer continues execution of the network request. 

## What makes VMs possible
**[Software-based and Hardware-assisted virtualization](https://en.wikipedia.org/wiki/X86_virtualization)**
Hypervisors or virtual machine managers rely on Intel or AMD Hardware virtualization instructions to map computer resources such as CPU cores, memory, etc. to virtual machines.
## Docker containers use cgroups and namespaces to conterize apps 
**[cgroups](https://en.wikipedia.org/wiki/Cgroups)
cgroups is a Linux kernel feature that limits, accounts for, and isolates the resource usage of a collection of processes. Engineers at Google started the work on this feature in 2006 under the name "process containers".
**[namespaces](https://en.wikipedia.org/wiki/Linux_namespaces)**
"Namespaces are a feature of the Linux kernel that partitions kernel resources such that one set of processes sees one set of resources while another set of processes sees a different set of resources...Namespaces are a fundamental aspect of containers in Linux."
## What are development containers
This is where the development system resides on a docker based development system.
## What are docker volumes
This is where source code is stored on a docker based development system.
## [How to develop from a container](https://code.visualstudio.com/docs/devcontainers/containers#_sharing-git-credentials-with-your-container)
## What is OCI?
[docker vs OCI](https://www.padok.fr/en/blog/container-docker-oci)
"Following Docker's release, a large community emerged around the idea of using containers as the standard unit of software delivery. As companies started using containers to package and deploy their software more and more, Docker's container runtime did not meet all the technical and business needs that engineering teams could have.

In response to this, the community started developing new runtimes with different implementations and capabilities. Simultaneously, new tools for building container images aimed to improve Docker's speed or ease of use. To make sure that all container runtimes could run images produced by any build tool, the community started the Open Container Initiative — or OCI — to define industry standards around container image formats and runtimes."

