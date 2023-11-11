I am with you always.  Trust me to watch over you and trust in my plan for you.  I will help you endure all things in order for your faith to grow stronger with each trial.  Without trials you will not grow to trust me but when you see that no matter how tough the situation is you can have peace and joy by looking to me then your faith shall be complete.

My boss has made some suggestions Father and you have been directing me on this project.  I will be listening to your voice as to the specifics in what you would have me to do. I do believe you have all of our best interests in mind. I trust you and will obey the best that I can Father.

I hope you had a pleasant weekend and I look forward to spending time with all of you this week.  Also, I appreciate being a part of a great group of guys working together to make it through the week and maybe having a little fun on the way :-) As always please feel free to ask my help about anything at home or at work.
-Sincerely yours
Brent
260-564-4868

Good morning dear ones,
I hope you had a swell weekend and wanted to let you know I enjoy working with each of you very much! As always please feel free to interrupt me any time with whatever it is you need at home or at work!  
-Sincerely yours
Brent
260-564-4868

# Next
- Add devcon2 workspace file and MySQL DW backup to repo.
- Add MySQL image to dev container.
- Run TB scripts for dev container.
- Create TB validation script in dev container.

# Roles
1. Kubernetes technician
2. Data warehouse administrator
3. Reporting system architect
4. Database consultant

# Responsibilites
- Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases. This includes validating our result sets to ensure they match what Plex shows on its reports and screens.  
- Examine Plex reporting data for inconsistencies and cordinate efforts to remove them to help improve reporting accuracy.
- Identify and communicate helpful ways to resolve data inconsistencies in Plex that would lead to reporting issues.
- Create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
- Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-synchronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.
- Provide secure communications to our web services by setting up a public key infrastructure for managing our root, intermediate, and end-entity certificates.  This involves monitoring the expiration dates of all certificates and automate the process of to request, sign, and distribute new certificates.
- Program database ETL scripts and reporting system software.  

# July 13-period Trial Balance Report
# login name change from busche-cnc.com to mobexglobal.com
- Can not create new repos in MobexGlobal project in Azure Dev Ops
**[Add to ](https://learn.microsoft.com/en-us/azure/devops/organizations/security/add-remove-manage-user-group-security-group?view=azure-devops&tabs=preview-page)**
## Steps to add member to Mobex Global Dev Ops project with project administrator privileges.
Open the Permissions page for either the project-level or organization-level as described in the previous section, Create a custom security group.
Choose the security group whose members you want to manage, then choose the Members tab, and then choose Add.
For example, choose the Project Administrators group, Members, and then Add.

# Summary
Two weeks ago week I setup up a public key infrastructure, and generated a root, intermediate, and server end-entity certificate.  Then I checked them against the Google x509v3 certificate linter and removed numerous errors. Then this last week I created a docker Apache web server docker image, git repositories for apache htdocs html files and our PKI and added both as submodules to our development container repo. To get the vscode Apache web server remote container to bind to port 80 and 443 in order to map network traffic from the development system the dev container I had to change Linux default setting of not allowing unprivileged users to bind to ports LTE 1024. How to do this is documented below under the Research Activities section.

- Tested VSCode development container at home

# Apache Web Server

Use this web server to test the new x509v3 certificates created with our public key infrastructure, PKI.
Best known feature: It's modularity used to add new features were going to be using the SSL and possibly the PHP modules. It's been one of the best web servers since 1995.

- Built Apache Dockerfile from the latest official Apache image.
- Add the newly created image to our development containers docker compose configuration file.
- Mount the htdocs, x509v3 certificates, and Apache configurations files to the development containers ./volume/htdocs, ./volume/certs directories and to the ./volume/apache2/apache2.conf file.  

# Mobex Public Key Infrastructure, PKI
I am testing our PKI on devcon2 by adding the following images to our docker development container:
- Mobex PKI
- Apache2 
Configure and take notes on using the official HTTPD docker image securely with TLS. 
**[How to use Apache HTTPD](https://www.docker.com/blog/how-to-use-the-apache-httpd-docker-official-image/)**
https://hub.docker.com/_/httpd  
https://hub.docker.com/r/ubuntu/apache2
- Nginx
- Jetty Servlet Server
# Securing Mach2 with TLS connections

# Research Activity
## What is IANA
The Internet Assigned Numbers Authority is a standards organization that oversees global IP address allocation, autonomous system number allocation, root zone management in the Domain Name System, media types, and other Internet Protocol–related symbols and Internet numbers.
## Is there any way to allow vscode to use ports LTE 1024? 
The gist is that if you want an unprivileged user to bind to a socket with a port LTE 1024 a privileged user must change some default system settings.  So if we want to use vscode to be able debug a SSL session with port 80 and 443 instead of some high numbered randomed port.
  
**[Access to Ports ](https://ar.al/2022/08/30/dear-linux-privileged-ports-must-die/)**
sudo sysctl -w net.ipv4.ip_unprivileged_port_start=80
However, that setting does not survive a reboot.
You can also configure the setting in a persistent way using a configuration file. e.g., by creating a file called /etc/sysctl.d/99-reduce-unprivileged-port-start-to-80.conf with the following content:
net.ipv4.ip_unprivileged_port_start=80
sudo touch /etc/sysctl.d/99-reduce-unprivileged-port-start-to-80.conf
echo "net.ipv4.ip_unprivileged_port_start=80" | sudo tee -a /etc/sysctl.d/99-reduce-unprivileged-port-start-to-80.conf >/dev/null
After making any changes, please run "service procps force-reload" (or, from
a Debian package maintainer script "deb-systemd-invoke restart procps.service").

# How to choose a Cloud-Telephone provider?
**[Cloud Telephone Guide](https://loopup.com/us/cloud-telephony-the-essential-guide/#)**
Cost and management benefits
Cost is a major motivator for most cloud migrations, regardless of the service being migrated. Most businesses will find that they save money by moving to cloud telephony rather than maintaining their own phone system. Moving to the cloud means no expensive on-premises hardware to purchase. The provider takes care of the infrastructure and, because it’s their business, they will typically upgrade to newer, faster and more efficient equipment on a regular basis.

Software Integration
Second, just like any other application, cloud systems do not always connect seamlessly to other services. Microsoft Teams Calling requires users to have Teams, for example, so it’s of no use to companies that don’t. This isn’t a reason not to use cloud telephony, but serves as another reminder to do your due diligence before choosing a provider.

Azure Cloud Calling
**[](https://learn.microsoft.com/en-us/azure/communication-services/concepts/telephony/telephony-concept)**
Voice Calling (PSTN)
An easy way of adding PSTN connectivity to your app or service, in such case, Microsoft is your telco provider. You can buy numbers directly from Microsoft. Azure Cloud Calling is an all-in-the-cloud telephony solution for Communication Services. It is the simplest option that connects Communication Services to the Public Switched Telephone Network (PSTN) to enable calls to landlines and mobile phones worldwide. Microsoft acts as your PSTN carrier, as shown in the following diagram:

**[Microsoft Teams](https://loopup.com/resource-center/blog/direct-routing-vs-calling-plan-which-is-best-for-microsoft-teams/)**
To use Teams for business telephony, enterprises will need to connect the Microsoft Phone System (a virtual PBX that’s hosted by Microsoft in the cloud) to the public telephony network. That means either using Microsoft Calling Plans or setting up Direct Routing, which is typically done through a managed service provider.


# What is the SIP?
We use it in our paging system.
**[What is SIP](https://en.wikipedia.org/wiki/Session_Initiation_Protocol)**
The Session Initiation Protocol (SIP) is a signaling protocol used for initiating, maintaining, and terminating communication sessions that include voice, video and messaging applications.[1] SIP is used in Internet telephony, in private IP telephone systems, as well as mobile phone calling over LTE (VoLTE).[2]

The protocol defines the specific format of messages exchanged and the sequence of communications for cooperation of the participants. SIP is a text-based protocol, incorporating many elements of the Hypertext Transfer Protocol (HTTP) and the Simple Mail Transfer Protocol (SMTP).[3] A call established with SIP may consist of multiple media streams, but no separate streams are required for applications, such as text messaging, that exchange data as payload in the SIP message.

SIP works in conjunction with several other protocols that specify and carry the session media. Most commonly, media type and parameter negotiation and media setup are performed with the Session Description Protocol (SDP), which is carried as payload in SIP messages. SIP is designed to be independent of the underlying transport layer protocol and can be used with the User Datagram Protocol (UDP), the Transmission Control Protocol (TCP), and the Stream Control Transmission Protocol (SCTP). For secure transmissions of SIP messages over insecure network links, the protocol may be encrypted with Transport Layer Security (TLS). For the transmission of media streams (voice, video) the SDP payload carried in SIP messages typically employs the Real-time Transport Protocol (RTP) or the Secure Real-time Transport Protocol (SRTP).

# What is SBC and how do we use it with Microsoft Teams?
**[SBC](https://www.techtarget.com/searchnetworking/definition/session-border-controller-SBC
)**
What is a session border controller (SBC)?
A session border controller (SBC) is a dedicated hardware device or software application that governs the manner in which phone calls are initiated, conducted and terminated on a voice over Internet Protocol (VoIP) network. Phone calls are referred to as sessions.

SBC ( Session Borde Controllers ) are basically gateways that provide interconnectivity between the hosted IP-PBX of the enterprise to the outside world endpoints such as telco service provider, PSTN/ TDM , SIP trunking providers or even third party OTT provider apps like skype for business etc.

Sonus SBC Compatibility
Algo IP Endpoints have been tested for compatibility with Sonus SBC VoIP systems. Algo’s Sonus SBC compatible solutions are 3rd party SIP compliant endpoints for voice paging and public address (PA), loud ringing, visual alerting, and secure door entry. Algo IP endpoints are feature-rich PoE/PoE+ powered devices, supporting secure SIP (TLS and SRTP), RTP multicast, and remote network management.  For configuration guides and notes please see the file library below.

**[how does SBC work?](https://loopup.com/us/resource-center/blog/what-is-a-session-border-controller-sbc-how-does-it-work/**)