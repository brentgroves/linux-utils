https://www.tutorialspoint.com/unix_sockets/index.htm

Sockets are communication points on the same or different computers to exchange data. Sockets are supported by Unix, Windows, Mac, and many other operating systems. The tutorial provides a strong foundation by covering basic topics such as network addresses, host names, architecture, ports and services before moving into network address functions and explaining how to write client/server codes using sockets.

Sockets allow communication between two different processes on the same or different machines. To be more precise, it's a way to talk to other computers using standard Unix file descriptors. In Unix, every I/O action is done by writing or reading a file descriptor. A file descriptor is just an integer associated with an open file and it can be a network connection, a text file, a terminal, or something else.

To a programmer, a socket looks and behaves much like a low-level file descriptor. This is because commands such as read() and write() work with sockets in the same way they do with files and pipes.

Sockets were first introduced in 2.1BSD and subsequently refined into their current form with 4.2BSD. The sockets feature is now available with most current UNIX system releases.

Where is Socket Used?
A Unix Socket is used in a client-server application framework. A server is a process that performs some functions on request from a client. Most of the application-level protocols like FTP, SMTP, and POP3 make use of sockets to establish connection between client and server and then for exchanging data.

Socket Types
There are four types of sockets available to the users. The first two are most commonly used and the last two are rarely used.

Processes are presumed to communicate only between sockets of the same type but there is no restriction that prevents communication between sockets of different types.

Stream Sockets − Delivery in a networked environment is guaranteed. If you send through the stream socket three items "A, B, C", they will arrive in the same order − "A, B, C". These sockets use TCP (Transmission Control Protocol) for data transmission. If delivery is impossible, the sender receives an error indicator. Data records do not have any boundaries.

Datagram Sockets − Delivery in a networked environment is not guaranteed. They're connectionless because you don't need to have an open connection as in Stream Sockets − you build a packet with the destination information and send it out. They use UDP (User Datagram Protocol).

(N/A) To start NGINX, the IC runs the nginx command, which launches the NGINX master.
(Signal) To reload NGINX, the IC runs the nginx -s reload command, which validates the configuration and sends the reload signal to the NGINX master.

(Signal) To shutdown NGINX, the IC executes nginx -s quit command, which sends the graceful shutdown signal to the NGINX master.
(File I/O) The NGINX master sends logs to its stdout and stderr, which are collected by the container runtime.
(File I/O) The NGINX master reads the TLS cert and keys referenced in the configuration when it starts or reloads.

(File I/O) The NGINX master reads configuration files when it starts or during a reload.
(Signal) The NGINX master controls the lifecycle of NGINX workers it creates workers with the new configuration and shutdowns workers with the old configuration.
(File I/O) An NGINX worker writes logs to its stdout and stderr, which are collected by the container runtime.


(UDP) An NGINX worker sends the HTTP upstream server response latency logs via the Syslog protocol over the UNIX socket /var/lib/nginx/nginx-syslog.sock to the IC. In turn, the IC analyzes and transforms the logs into Prometheus metrics.

(HTTP,HTTPS,TCP,UDP) A client sends traffic to and receives traffic from any of the NGINX workers on ports 80 and 443 and any additional ports exposed by the GlobalConfiguration resource.
(HTTP,HTTPS,TCP,UDP) An NGINX worker sends traffic to and receives traffic from the backends.
(HTTP) Admin can connect to the NGINX stub_status using port 8080 via an NGINX worker. Note: By default, NGINX only allows connections from localhost.

The Ingress Controller Process
This section covers the architecture of the IC process, including:

How the IC processes a new Ingress resource created by a user.
The summary of how the IC works and how it relates to Kubernetes Controllers.
The different components of the IC process.

Processing a New Ingress Resource
The following diagram depicts how the IC processes a new Ingress resource. We represent the NGINX master and worker processes as a single rectangle NGINX for simplicity. Also, note that VirtualServer and VirtualServerRoute resources are processed similarly.

IC process
Processing a new Ingress resource involves the following steps, where each step corresponds to the arrow on the diagram with the same number:

User creates a new Ingress resource.
The IC process has a Cache of the resources in the cluster. The Cache includes only the resources the IC is interested in, such as Ingresses. The Cache stays in sync with the Kubernetes API by watching for changes to the resources.

Once the Cache has the new Ingress resource, it notifies the Control loop about the changed resource.
The Control loop gets the latest version of the Ingress resource from the Cache. Because the Ingress resource references other resources, such as TLS Secrets, the Control loop gets the latest versions of any referenced resources as well.
The Control loop generates TLS certificates and keys from the TLS Secrets and writes them to the filesystem.

The Control loop generates and writes the NGINX configuration files, which correspond to the Ingress resource, and writes them to the filesystem.
The Control loop reloads NGINX and waits for NGINX to successfully reload. As part of the reload:
NGINX reads the TLS certs and keys.
NGINX reads the configuration files.

The Control loop emits an event for the Ingress resource and updates its status. If the reload fails, the event includes the error message.

The Ingress Controller is a Kubernetes Controller
Based on the example from the previous section, we can generalize how the IC works:

The IC constantly processes both new resources and changes to the existing resources in the cluster. As a result, the NGINX configuration stays up-to-date with the resources in the cluster.

The IC is an example of a Kubernetes controller: the IC runs a control loop that ensures NGINX is configured according to the desired state (Ingresses and other resources).

The desired state is concentrated in the following built-in Kubernetes resources and Custom Resources (CRs):

Layer 7 Load balancing configuration:
Ingresses
VirtualServers (CR)
VirtualServerRoutes (CR)

Layer 7 policies:
Policies (CR)

Layer 4 load balancing configuration:
TransportServers (CR)

Service discovery:
Services
Endpoints
Pods

Secret configuration:
Secrets
Global Configuration:
ConfigMap (only one resource)
GlobalConfiguration (CR, only one resource)

The IC can watch additional Custom Resources, which are less common and not enabled by default:

NGINX App Protect resources (APPolicies, APLogConfs, APUserSigs)
IngressLink resource (only one resource)
In the next section, we examine the different components of the IC process.

Ingress Controller Process Components
In this section, we describe the components of the IC process and how they interact, including:

How the IC watches for resources changes.
The main components of the IC control loop.
How those components process a resource change.
A few additional components, which are crucial for processing changes.

The IC is written in go and relies heavily on the Go client for Kubernetes. In the sections next, we include links to the code on GitHub when necessary.

