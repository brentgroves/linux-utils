# Minio

## references

<https://8grams.medium.com/minio-on-microk8s-install-aws-s3-alternative-on-single-node-kubernetes-cluster-2af3e9a45fc6>

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

MinIO Operator and Console for Kubernetes

**![MinIO Operator Kubernetes](https://miro.medium.com/v2/resize:fit:640/format:webp/1*0OXUU4OrMH4OJZojIkyPpw.png)**

MinIO provides an Operator and a Console for Kubernetes to extend its native functionalities. The MinIO Operator brings native support for managing MinIO instances on Kubernetes. Simultaneously, the Console provides a graphical user interface for administering the MinIO deployment.

In conclusion, MinIO's architecture is built around principles of performance, scalability, and data protection. It leverages distributed systems concepts to create an object storage service that's robust, resilient, and compatible with the vast Amazon S3 ecosystem.

MinIO vs AWS S3 vs Ceph
When comparing MinIO with other solutions, we'll focus on Amazon S3, a leading proprietary solution, and Ceph, a popular open-source alternative.

Amazon S3
Renowned for its extensive feature set, durability, and integration with the AWS ecosystem, S3 sets a high standard for cloud storage solutions. However, it comes with a more substantial price tag, especially when data egress costs are considered.

MinIO, on the other hand, allows businesses to capitalize on the S3-compatible API while retaining the ability to host on any hardware or cloud platform. This flexibility reduces costs and eliminates vendor lock-in. Additionally, MinIO's high performance and scalability make it suitable for large-scale data workloads, a capability only available in the more expensive tiers of Amazon S3.

Ceph
Ceph is another robust open-source storage solution that provides object, block, and file storage in a single platform. While this versatility is a strength, it also contributes to Ceph's complexity.

MinIO's advantage lies in its focus on being the best object storage system. Its architecture is leaner and simpler than Ceph's, leading to lower overhead and easier management. In terms of performance, MinIO's design allows it to handle higher throughput and IOPS than Ceph, making it the preferred option for high-performance workloads.

**![Comparison](https://miro.medium.com/v2/resize:fit:720/format:webp/1*qSfJwiw0LCTqvBKve35iZA.png)**

MinIO on Kubernetes
In the world of container orchestration, Kubernetes reigns supreme. MinIO's compatibility with Kubernetes ensures it can serve as a scalable and reliable storage option within a Kubernetes environment. Businesses can deploy MinIO instances on Kubernetes clusters, enjoying the benefits of both MinIO's powerful object storage and Kubernetes's container orchestration capabilities.

This synergy is facilitated through the MinIO Operator, a tool designed to manage MinIO instances on Kubernetes. The operator automates various tasks such as deploying a MinIO instance, scaling the instance up or down, and managing upgrades, thereby simplifying the management of storage within a Kubernetes environment.

**![MinIO on Kubernetes](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*yDEy_2E5STYyYDX6P6z8ng.png)**

Install MinIO on Microk8s
Microk8s offers a convenient MinIO addon that simplifies the process of installing MinIO on Microk8s. This addon takes care of the installation of all required resources and dependencies for MinIO to function efficiently on a Kubernetes cluster. To enable MinIO on Microk8s, proceed as follows:

~$ microk8s enable minio
The aforementioned command will yield a response containing the default key and secret for MinIO, functioning similarly to the AWS Key and Secret. To ensure that the installation process was successful, you can follow these verification steps:

```bash
~$ kubectl get pods -n minio-operator
NAME                 READY   STATUS
console-xxx          1/1     Running
minio-operator-xxx   1/1     Running
microk8s-xxx         1/1     Running
```

By default, the addon sets up two replicas of MinIO, which may not be ideal for a single Kubernetes cluster. Hence, we need to adjust this configuration to utilize just one replica instead.

```bash
kubectl edit statefulset microk8s-ss-0 -n minio-operator
```
