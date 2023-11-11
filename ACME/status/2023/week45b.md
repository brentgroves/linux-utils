# The Father's directions

I love you my son and I enjoy spending time with you each and every day.  Please remember I am in complete control of every situation so there is no need for you to worry about anything.  Through every heart-ache and each trouble I want you to come to believe that I love you and the virtues I am teaching you are for everyones own good and you have nothing to worry about even death itself.  

## next

2 ip for metalb
1 ip for ingress
1 ip for istor
https://www.educative.io/answers/kubernetes-pod-stuck-in-terminating-state

Good morning dear ones,
May you all be of good spirit this day as we start out our week together.  As always please feel free to ask for me for anything at work or at home.  I hope you and your loved ones our doing well :-)

-Sincerely yours,
Brent
260-564-4868

## Observability

Now that the load balancer and ingress controller are working try getting the ingress controller to collect metrics using prometheus and graph data in graphina.

- Install MicroK8s observability stack
- monitor the ingress controller with prometheus
- configure MicroK8s to ship logs and metric data to an external
 Observability stack for logging, monitoring and alerting. 

The Observability stack used in this example consists of:
Prometheus
Elasticsearch
Alertmanager

### references

**[observability with microk8s](https://betterprogramming.pub/observability-with-microk8s-14c1f0ff5183)**
**[](https://microk8s.io/docs/external-lma)**
**[monitoring nginx ingress controller](https://chrisedrego.medium.com/monitoring-nginx-ingress-controller-with-prometheus-grafana-d66d204e61c8)**

## Service Mesh Support using Istio API Gateway

Service Mesh API Gateway Features:

Dynamic service discovery
Load balancing
TLS termination
HTTP/2 and gRPC proxies
Circuit breakers - Like a circuit breaker in an electrical circuit, the software version allows flow to a service to be shut off. The circuit opens in the case where the endpoint is not functioning correctly. The endpoint may have failed or may just be too slow, but it represents the same problem: this container is not working.
Health checks
Staged rollouts with %-based traffic split - A way to have no downtime when releasing a service update.
Fault injection
Rich metrics


**[Istio](../../istio/istio-arch.md)**

## Current State

- k8s training cluster with report team users created.
- Operators for MySQL InnoDB Cluster with backup working.
- Zolando Postgres Operator working backup to S3 storage in progress.
- Single node Ceph Storage Cluster linked Reports5 K8s dev cluster.
- Minio S3 compatible storage running on K8s dev cluster using host-path storage.
Next:
- Test Minio with Ceph-XFS storage class.
- Attempt to use Ceph rather than Host-path storage as default storage class on K8s dev cluster.

## What is **[ARP](https://www.ipxo.com/blog/address-resolution-protocol/#:~:text=An%20ARP%20request%20establishes%20communication,do%20not%20maintain%20this%20table.)**

Why do we need to know this?  ARP requests are used by Nginx Ingress Controller to locate a load balancer on the network.

"An ARP request establishes communication between devices on the network. It is enabled after a source device fails to retrieve necessary data from an ARP cache table.

The ARP table holds records of the IP address and MAC address of the devices connected to the same network. IT administrators do not maintain this table. Instead, the ARP protocol creates additions when it receives an ARP response. All operating systems in a network keep ARP caches.
"

## Service Mesh

Common use cases for a service mesh
A service mesh is useful for any type of microservices architecture from an operations standpoint. This is because it allows you to control traffic, security, permissions, and observability. Here are some of the most common, standardized, and widely accepted use cases for service meshes today:

Improving the observability: Through service-level visibility, tracing, and monitoring, we may improve the observability of distributed services. Some of the service mesh’s primary features boost visibility and your ability to troubleshoot and manage situations dramatically. For example, if one of the architecture’s services becomes a bottleneck, retrying is a frequent option, although this may exacerbate the bottleneck due to timeouts. With a service mesh, you can quickly break the circuit to failing services, disable non-functioning replicas, and maintain the API’s responsiveness.

## What is an **[API Gateway](https://www.nginx.com/learn/api-gateway/#:~:text=An%20API%20gateway%20is%20a%20data%2Dplane%20entry%20point%20for,%2C%20routing%2C%20and%20load%20balancing)

**[Ingress Controller](../../microk8s/nginx-ic/nginx-ic.md)**
You might ask, however: “What about service load balancers and API gateways?” Historically, API gateways are used (such as Ocelot, or Kong) to consolidate individual APIs into a single interface that our frontend can talk to. Ingress’ provide a way to define in a semi-vendor neutral way, how traffic should flow. You can specify host names, and within those hosts you can specify sub routes and have the Ingress route traffic to different services via the same host name. For example, you may have:

```psudocode
www.mystore.com => Container hosting a static site
api.mystore.com
    /cart => Cart Managment Service
    /orders => Order Management Service
    /products => Product Management Service
```

## What is **[Krew](../../kubernetes/krew/what-is-krew.md)**

Krew is the plugin manager for kubectl command-line tool.

Krew helps you:

discover kubectl plugins,
install them on your machine,
and keep the installed plugins up-to-date.

## What is DirectPV

DirectPV is a CSI driver that will discover and manage drives all across your network.

**[DirectPV](https://min.io/directpv)**
Architecture
DirectPV is designed to be lightweight and scalable to tens of thousands of drives. It is made up of three components - Controller, Node Driver, UI.

It is useful to discover, format, mount, schedule and monitor drives across servers. Since Kubernetes hostPath and local PVs are statically provisioned and limited in functionality, DirectPV was created to address this limitation.

Distributed data stores such as object storage, databases and message queues are designed for direct attached storage, and they handle high availability and data durability by themselves. Running them on traditional SAN or NAS based CSI drivers (Network PV) adds yet another layer of replication/erasure coding and extra network hops in the data path. This additional layer of disaggregation results in increased-complexity and poor performance.

## What is **[Erasure Coding](https://www.dremio.com/wiki/erasure-coding/#:~:text=Erasure%20Coding%20works%20by%20dividing,or%20nodes%20in%20the%20system.)**?

Erasure Coding is a method used to protect data in distributed storage systems. It involves breaking data into smaller units, adding redundant pieces, and distributing them across multiple storage devices or nodes.

Unlike traditional replication techniques that make exact copies of data, erasure coding uses mathematical algorithms to create redundancy in a more efficient manner. This allows for a reduction in storage overhead while still providing fault tolerance and data reliability.

## What is MinIO

MinIO is an open-source, high-performance, and cloud-native object storage system. It is designed for large-scale private and public cloud infrastructure.

**![Minio Arch](https://miro.medium.com/v2/resize:fit:720/format:webp/1*cFUCLR4rjfqTd_bK1lSw4Q.png)**

## Erasure Coding and Bitrot Protection

MinIO uses erasure coding for data protection. When you store an object, MinIO shards the data across multiple drives — the number of drives depends on your setup. Even if you lose up to half the drives (N/2) in your setup, you can still reconstruct the data.
Alongside, MinIO uses bitrot protection to safeguard data against corruption at the hardware level. Each data and parity block gets a checksum when written, which is verified during each read.

Consistent, Object-Level Locking
MinIO uses a variant of the Read-Write Locking mechanism for managing access to data. This system ensures that read and write operations on a single object are mutually exclusive. Consequently, this prevents inconsistencies and data corruption that could otherwise result from simultaneous write operations.

S3 Compatible API
MinIO exposes an Amazon S3-compatible API, allowing you to use existing S3 client SDKs, CLI, and other tools to interact with MinIO. The API is not an emulation but a reimplementation of the AWS S3 API, so it behaves exactly as expected, with few differences.

MinIO Client and SDKs
MinIO provides a client — 'mc' for interacting with MinIO and other S3 compatible object storage services. It supports file management operations similar to Linux 'ls', 'diff', 'rm', 'cp', 'mirror', etc.

For developers, MinIO offers SDKs for popular programming languages like JavaScript, Java, Python, .NET, and Go, easing the task of building applications using MinIO.

**![Comparison](https://miro.medium.com/v2/resize:fit:720/format:webp/1*qSfJwiw0LCTqvBKve35iZA.png)**

MinIO on Kubernetes
In the world of container orchestration, Kubernetes reigns supreme. MinIO's compatibility with Kubernetes ensures it can serve as a scalable and reliable storage option within a Kubernetes environment. Businesses can deploy MinIO instances on Kubernetes clusters, enjoying the benefits of both MinIO's powerful object storage and Kubernetes's container orchestration capabilities.

This synergy is facilitated through the MinIO Operator, a tool designed to manage MinIO instances on Kubernetes. The operator automates various tasks such as deploying a MinIO instance, scaling the instance up or down, and managing upgrades, thereby simplifying the management of storage within a Kubernetes environment.

**![MinIO on Kubernetes](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*yDEy_2E5STYyYDX6P6z8ng.png)**

**[MinIO Playground](https://play.min.io:9443/login)**

## [Managing Objects](https://min.io/docs/minio/linux/administration/console/managing-objects.html#minio-console-managing-objects)**

### Creating Buckets

Select create bucket to create a new bucket on the deployment. MinIO validates bucket names. To see the rules for bucket names, select view bucket naming rules.

MinIO does not limit the total number of buckets allowed on a deployment. However, MinIO recommends no more than 500,000 buckets per deployment as a general guideline.

While creating a bucket, you can enable versioning, object locking, bucket size (quota) limits, and retention rules (which require versioning).

Changed in version Console: v0.35.0

If you enable versioning, you can specify prefixes to exclude from versioning.

You must configure replication, locking, and versioning options at the time of bucket creation. You cannot change these settings for the bucket later.

### Managing Buckets

Use the search bar to filter for specific buckets. Select the row for the bucket to display summary information about the bucket.

Form the summary screen, select any of the available tabs to further manage the bucket.

Note

Some management features may not be available if the authenticated user does not have the required administrative permissions.

When managing a bucket, your access settings may allow you to view or change any of the following:

The summary section displays a summary of the bucket’s configuration.

Use this section to view and modify the bucket’s access policy, encryption, quota, and tags.

Configure alerts in the events section to trigger notification events when a user uploads, accesses, or deletes matching objects.

Copy objects to remote locations in the replication section with Server Side Bucket Replication Rules.

Expire or transition objects in the bucket from the lifecycle section by setting up Object Lifecycle Management Rules.

Review security in the access section by listing the policies and users with access to that bucket.

Properly secure unauthenticated access with the anonymous section by managing rules for prefixes that unauthenticated users can use to read or write objects.

## Tiers

The tiers section provides an interface for adding and managing remote tiers to support lifecycle management transition rules. MinIO tiering supports moving objects from the deployment to the remote storage, but does not support automatically restoring them to the deployment.

The tiering tab allows users with the appropriate permissions to:

Review the status and summary information for all configured remote tiers.

Create a tier for a new remote target to storage on another MinIO deployment, Google Cloud Storage, Amazon’s AWS S3, or Azure.

Cycle the access credentials for any of the configured tiers with the tier’s  icon.

## Security and Access

You can use the MinIO Console to perform several of the identity and access management functions available in MinIO, such as:

Create child access keys that inherit the parent’s permissions.

View, manage, and create access policies.

Create and manage user credentials or groups with the built-in MinIO IDP, connect to one or more OIDC provider, or add an AD/LDAP provider for SSO.
