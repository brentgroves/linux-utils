https://docs.nginx.com/nginx-ingress-controller/
https://www.nginx.com/blog/inside-nginx-how-we-designed-for-performance-scale/
ingress-controller:
Need one of these to map different services to the reports FQDN using different paths such as:
reports.mobexglobal.com/reports-runner
reports.mobexglobal.com/reports-cron
reports.mobexglobal.com/reports-admin
https://docs.nginx.com/nginx-ingress-controller/


Overview
Overview of the NGINX Ingress Controller

The NGINX Ingress Controller an implementation of a Kubernetes Ingress Controller for NGINX and NGINX Plus.

What is the Ingress?
The Ingress is a Kubernetes resource that lets you configure an HTTP load balancer for applications running on Kubernetes, represented by one or more Services. Such a load balancer is necessary to deliver those applications to clients outside of the Kubernetes cluster.

The Ingress resource supports the following features:

Content-based routing:
Host-based routing. For example, routing requests with the host header foo.example.com to one group of services and the host header bar.example.com to another group.
Path-based routing. For example, routing requests with the URI that starts with /serviceA to service A and requests with the URI that starts with /serviceB to service B.
TLS/SSL termination for each hostname, such as foo.example.com.

What is the Ingress Controller?
The Ingress Controller is an application that runs in a cluster and configures an HTTP load balancer according to Ingress resources. The load balancer can be a software load balancer running in the cluster or a hardware or cloud load balancer running externally. Different load balancers require different Ingress Controller implementations.

In the case of NGINX, the Ingress Controller is deployed in a pod along with the load balancer.

NGINX Ingress Controller
NGINX Ingress Controller works with both NGINX and NGINX Plus and supports the standard Ingress features - content-based routing and TLS/SSL termination.

Additionally, several NGINX and NGINX Plus features are available as extensions to the Ingress resource via annotations and the ConfigMap resource. In addition to HTTP, NGINX Ingress Controller supports load balancing Websocket, gRPC, TCP and UDP applications. See ConfigMap and Annotations docs to learn more about the supported features and customization options.

How NGINX Ingress Controller Works
This document explains how NGINX Ingress Controller works.

This document explains how NGINX Ingress Controller works. The target audience includes the following two main groups:

Operators who would like to know how the software works and also better understand how it can fail.
Developers who would like to contribute to the project.

We assume that the reader is familiar with core Kubernetes concepts, such as Pod, Deployment, Service, and Endpoints. Additionally, we recommend reading this blog post for an overview of the NGINX architecture.

TLS secrets
Kubernetes provides a builtin Secret type kubernetes.io/tls for storing a certificate and its associated key that are typically used for TLS.

One common use for TLS secrets is to configure encryption in transit for an Ingress, but you can also use it with other resources or directly in your workload. When using this type of Secret, the tls.key and the tls.crt key must be provided in the data (or stringData) field of the Secret configuration, although the API server doesn't actually validate the values for each key.

The following YAML contains an example config for a TLS Secret:

apiVersion: v1
kind: Secret
metadata:
  name: secret-tls
type: kubernetes.io/tls
data:
  # the data is abbreviated in this example
  tls.crt: |
        MIIC2DCCAcCgAwIBAgIBATANBgkqh ...
  tls.key: |
        MIIEpgIBAAKCAQEA7yn3bRHQ5FHMQ ...

        The TLS Secret type is provided for user's convenience. You can create an Opaque for credentials used for TLS server and/or client. However, using the builtin Secret type helps ensure the consistency of Secret format in your project; the API server does verify if the required keys are provided in a Secret configuration.

When creating a TLS Secret using kubectl, you can use the tls subcommand as shown in the following example:

kubectl create secret tls my-tls-secret \
  --cert=path/to/cert/file \
  --key=path/to/key/file

  The public/private key pair must exist before hand. The public key certificate for --cert must be DER format as per Section 5.1 of RFC 7468, and must match the given private key for --key (PKCS #8 in DER format; Section 11 of RFC 7468).

Note:
A kubernetes.io/tls Secret stores the Base64-encoded DER data for keys and certificates. If you're familiar with PEM format for private keys and for certificates, the base64 data are the same as that format except that you omit the initial and the last lines that are used in PEM.

For example, for a certificate, you do not include --------BEGIN CERTIFICATE----- and -------END CERTIFICATE----.

https://docs.nginx.com/nginx-ingress-controller/intro/how-nginx-ingress-controller-works/

The IC pod consists of a single container, which in turn includes the following:

IC process, which configures NGINX according to Ingress and other resources created in the cluster.
NGINX master process, which controls NGINX worker processes.
NGINX worker processes, which handle the client traffic and load balance the traffic to the backend applications.
For brevity, we’ve omitted the suffix process from the description of the processes.

The numbered list that follows describes each connection with its type in curly brackets:

(HTTP) Prometheus fetches the IC and NGINX metrics via an HTTP endpoint that the IC exposes. The default is :9113/metrics. Note: Prometheus is not required by the IC, the endpoint can be turned off.
(HTTPS) The IC reads the Kubernetes API to get the latest versions of the resources in the cluster and writes to the API to update the handled resources' statuses and emit events.
(HTTP) Kubelet probes the IC readiness probe (the default is :8081/nginx-ready) to consider the IC pod ready.
(File I/O) When the IC starts, it reads the configuration templates necessary for config generation from the filesystem. The templates are located in the / directory of the container and have the .tmpl extension.
(File I/O) The IC writes logs to its stdout and stderr, which are collected by the container runtime.
(File I/O) The IC generates NGINX configuration based on the resources created in the cluster (refer to The Ingress Controller is a Kubernetes Controller section for the list of resources) and writes it on the filesystem in the /etc/nginx folder. The configuration files have a .conf extension.

(File I/O) The IC writes TLS certificates and keys from any TLS Secrets referenced in the Ingress and other resources to the filesystem.
(HTTP) The IC fetches the NGINX metrics via the unix:/var/lib/nginx/nginx-status.sock UNIX socket and converts it to Prometheus format used in #1.
(HTTP) To consider a configuration reload a success, the IC ensures that at least one NGINX worker has the new configuration. To do that, the IC checks a particular endpoint via the unix:/var/lib/nginx/nginx-config-version.sock UNIX socket.
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

https://github.com/kubernetes/client-go

Resource Caches
In the section Processing a New Ingress Resource, we mentioned that the IC has a cache of the resources in the cluster that stays in sync with the Kubernetes API by watching for changes to the resources. We also mentioned that once cache is updated, it notifies the control loop about the changed resource.

The cache is actually a collection of informers. The following diagram shows how changes to resources are processed by the IC

IC process components
For every resource type the IC monitors, it creates an Informer. The Informer includes a Store that holds the resources of that type. To keep the Store in sync with the latest versions of the resources in the cluster, the Informer calls the Watch and List Kubernetes APIs for that resource type (see the arrow 1. Watch and List on the diagram).

When a change happens in the cluster (for example, a new resource is created), the Informer updates its Store and invokes Handlers (see the arrow 2. Invoke) for that Informer.

The IC registers handlers for every Informer. Most of the time, a Handler creates an entry for the affected resource in the Workqueue where a workqueue element includes the type of the resource and its namespace and name. (See the arrow 3. Put.)

The Workqueue always tries to drain itself: if there is an element at the front, the queue will remove the element and send it to the Controller by calling a callback function. (See the arrow 4. Send.)

The Controller is the primary component in the IC, which represents the control loop. We explain the components in The Control Loop section. For now, it suffices to know that to process a workqueue element, the Controller component gets the latest version of the resource from the Store (see the arrow 5. Get), reconfigures NGINX according to the resource (see the arrow 6. Reconfigure), updates the resource status, and emits an event via the Kubernetes API (see the arrow 7. Update status and emit event).

The Control Loop
This section discusses the main components of the IC, which comprise the control loop:

Controller
Runs the IC control loop.
Instantiates Informers, Handlers, the Workqueue and additional helper components.
Includes the sync method (see the next section), which is called by the Workqueue to process a changed resource.
Passes changed resources to Configurator to re-configure NGINX.

Configurator
Generates NGINX configuration files, TLS and cert keys, and JWKs based on the Kubernetes resource.
Uses Manager to write the generated files and reload NGINX.

Manager
Controls the lifecycle of NGINX (starting, reloading, quitting). See Reloading NGINX for more details about reloading.
Manages the configuration files, TLS keys and certs, and JWKs.

Control Loop
The Controller Sync Method
The Controller sync method is called by the Workqueue to process a change of a resource. The method determines the kind of the resource and calls the appropriate sync method (for example, syncIngress for Ingresses).

Controller sync
The Workqueue calls the sync method and passes a workqueue element to it that includes the changed resource kind and key (the key is the resource namespace/name like “default/cafe-ingress”).
Using the kind, the sync method calls the appropriate sync method and passes the resource key. For Ingresses, that method is syncIngress.
syncIngress gets the Ingress resource from the Ingress Store using the key. The Store is controlled by the Ingress Informer, as mentioned in the section Resource Caches. Note: In the code, we use the helper storeToIngressLister type that wraps the Store.
syncIngress calls AddOrUpdateIngress of the Configuration, passing the Ingress along. The Configuration is a component that represents a valid collection of load balancing configuration resources (Ingresses, VirtualServers, VirtualServerRoutes, TransportServers), ready to be converted to the NGINX configuration (see the Configuration section for more details). AddOrUpdateIngress returns a list of ResourceChanges, which must be reflected in the NGINX config. Typically, for a new Ingress resource, the Configuration returns only a single ResourceChange.
syncIngress calls processChanges, which processes the single Ingress ResourceChange.
processChanges creates an extended Ingress resource (IngressEx) that includes the original Ingress resource and its dependencies, such as Endpoints and Secrets, to generate the NGINX configuration. For simplicity, we don’t show this step on the diagram.
processChanges calls AddOrUpdateIngress of the Configurator and passes the extended Ingress resource.
Configurator generates an NGINX configuration file based on the extended Ingress resource and then:
Calls Manager’s CreateConfig() to update the config for the Ingress resource.
Calls Manager’s Reload() to reload NGINX.
The reload status is propagated from Manager to processChanges. The status is either a success or a failure with an error message.
processChanges calls updateRegularIngressStatusAndEvent to update the status of the Ingress resource and emit an event with the status of the reload. Both involve making an API call to the Kubernetes API.
Notes:

Some details weren’t discussed for simplicity. You can view the source code if you want a fuller picture.
The syncVirtualServer, syncVirtualServerRoute, and syncTransportServer methods are similar to syncIngress. The other sync methods are different. However, those methods typically involve finding the affected Ingress, VirtualServer, and TransportServer resources and regenerating a configuration for them.
The Workqueue has only a single worker thread that calls the sync method synchronously. This means that the control loop processes only one change at a time.

Configuration
Configuration holds the latest valid state of the IC load balancing configuration resources: Ingresses, VirtualServers, VirtualServerRoutes, TransportServers, and GlobalConfiguration.

The Configuration supports add (for add/update) and delete operations on the resources. When you add/update/delete a resource in the Configuration, it performs the following:

Validates the object (for add/update)
Calculates the changes to the affected resources that are necessary to propagate to the NGINX config, returning the changes to the caller.
For example, when you add a new Ingress resource, the Configuration returns a change requiring the IC to add the configuration for that Ingress to the NGINX config files. Another example: if you make an existing Ingress resource invalid, the Configuration returns a change requiring the IC to remove the configuration for that Ingress from the NGINX config files.

Additionally, the Configuration ensures that only one Ingress/VirtualServer/TransportServer (TLS Passthrough) holds a particular host (for example, cafe.example.com) and only one TransportServer (TCP/UDP) holds a particular listener (for example, port 53 for UDP). This ensures that no host or listener collisions happen in the NGINX config.

Ultimately, the IC ensures the NGINX config on the filesystem reflects the state of the objects in the Configuration at any point in time.


LocalSecretStore
LocalSecretStore (of the SecretStore interface) holds the valid Secret resources and keeps the corresponding files on the filesystem in sync with them. Secrets are used to hold TLS certificates and keys (type kubernetes.io/tls), CAs (nginx.org/ca), JWKs (nginx.org/jwk), and client secrets for an OIDC provider (nginx.org/oidc).

When Controller processes a change to a configuration resource like Ingress, it creates an extended version of a resource that includes the dependencies – such as Secrets – necessary to generate the NGINX configuration. LocalSecretStore allows Controller to get a reference on the filesystem for a secret by the secret key (namespace/name).

Reloading NGINX
The following section covers reloading NGINX in general and specifically how the Ingress Controller implements it.

Reloading in General
Reloading NGINX is necessary to apply the new configuration and involves the following actions:

The administrator sends a HUP (hangup) signal to the NGINX master process to trigger a reload.
The master process brings down the worker processes with the old configuration and starts worker processes with the new configuration.
The administrator verifies the reload has successfully finished.
Refer to the NGINX documentation for more details about reloading. See also this blog post for an overview of the NGINX architecture.

How to Reload
The NGINX binary (nginx) supports the reload operation with the -s reload option. When you run this option:

It validates the new NGINX configuration and exits if it is invalid printing the error messages to the stderr.
It sends a HUP signal to the NGINX master process and exits.
Alternatively, you can send a HUP signal to the NGINX master process directly.

How to Confirm Reloading Success
nginx -s reload doesn’t wait for NGINX to finish reloading. As a result, it is the responsibility of the administrator to confirm it. There are a few options:

Check if the master process created new worker processes. For example, by running ps or reading the /proc file system.
Send an HTTP request to NGINX, and if a new worker process responds, you’ll know the NGINX reloaded successfully. Note: this requires additional NGINX config, see the Reloading in the Ingress Controller section.

Reloading takes time, usually at least 200ms. The time depends on the configuration size, the number of TLS certificates/keys, enabled modules, configuration details, and the available CPU resources.

Potential Problems
Most of the time, if nginx -s reload succeeds, the reload will also succeed. In rare cases the reload fails, the NGINX master will print the error message to the error log. For example:

2022/07/09 00:56:42 [emerg] 1353#1353: limit_req "one" uses the "$remote_addr" key while previously it used the "$binary_remote_addr" key
The operation is graceful; reloading doesn’t lead to any traffic loss by NGINX. However, frequent reloads can lead to high memory utilization and potentially NGINX stopping with an OOM (Out-Of-Memory) error, resulting in traffic loss. This can happen if you (1) proxy traffic that utilizes long-lived connections (ex: Websockets, gRPC) and (2) reload frequently. In this case, you can end up with multiple generations of NGINX worker processes that are shutting down (old NGINX workers will not shut down until all connections are terminated either by clients or backends, unless you configure worker_shutdown_timeout which will force old workers to shut down after the timeout). Eventually, all those worker processes can exhaust the system’s available memory.

Since both the old and new NGINX worker processes coexist during a reload, reloading can lead to a spike in memory utilization up to two times. Because of the lack of available memory, the NGINX master process can fail to create new worker processes.

Reloading in the IC
The Ingress Controller reloads NGINX to apply configuration changes.

To facilitate reloading, the Ingress Controller configures a server listening on the Unix socket unix:/var/lib/nginx/nginx-config-version.sock that responds with the config version for /configVersion URI. The Ingress Controller writes the config to /etc/nginx/config-version.conf.

A reload involves multiple steps:

The Ingress Controller updates generated configuration files, including any secrets.
The Ingress Controller updates the config version in /etc/nginx/config-version.conf.
The Ingress Controller runs nginx -s reload. If the command fails, the Ingress Controller logs the error and considers the reload failed.
Assuming the command succeeds, the Ingress Controller periodically checks for the config version by sending an HTTP request to the config version server on unix:/var/lib/nginx/nginx-config-version.sock.
Once the Ingress Controller sees the correct config version returned by NGINX, it considers the reload successful. If it doesn’t see the correct config version after the configurable timeout (see -nginx-reload-timeout cli argument, the Ingress Controller considers the reload failed.

The Ingress Controller Control Loop stops during a reload so that it cannot change any configuration files or reload NGINX until the current reload succeeds or fails.

When the Ingress Controller Reloads NGINX
The Ingress Controller reloads NGINX every time the Control Loop processes a change that affects the generated NGINX configuration. In general, every time a resource is changed, the Ingress Controller will regenerate the configuration and reload NGINX. A resource could be of any type the Ingress Controller monitors – see The Ingress Controller is a Kubernetes Controller section.

There are three special cases:

Start. When the Ingress Controller starts, it processes all resources in the cluster and only then reloads NGINX. This avoids creating a “reload storm” by reloading only once.
Batch updates. When the Ingress Controller receives a number of concurrent requests from the Kubernetes API, it will pause NGINX reloads until the task queue is empty. This reduces the number of reloads to minimize the impact of batch updates and reduce the risk of OOM (Out of Memory) errors.
NGINX Plus. If the Ingress Controller uses NGINX Plus, it will not reload NGINX Plus for changes to the Endpoints resources. In this case, the Ingress Controller will use the NGINX Plus API to update the corresponding upstreams and skip reloading.

