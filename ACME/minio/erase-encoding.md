# What is **[Erasure Coding](https://www.dremio.com/wiki/erasure-coding/#:~:text=Erasure%20Coding%20works%20by%20dividing,or%20nodes%20in%20the%20system.)**?

Erasure Coding is a method used to protect data in distributed storage systems. It involves breaking data into smaller units, adding redundant pieces, and distributing them across multiple storage devices or nodes.

Unlike traditional replication techniques that make exact copies of data, erasure coding uses mathematical algorithms to create redundancy in a more efficient manner. This allows for a reduction in storage overhead while still providing fault tolerance and data reliability.

How does Erasure Coding work?
Erasure Coding works by dividing the data into smaller pieces, known as data shards. These shards are then transformed using mathematical operations to generate additional pieces called parity shards.

The parity shards are distributed across different storage devices or nodes in the system. In the event of a storage device failure, the missing data can be reconstructed using the remaining shards and parity information.

Why is Erasure Coding important?
Erasure Coding offers several advantages over traditional replication techniques:

Reduced storage overhead: Erasure Coding requires less storage space compared to replication because it stores only the necessary additional parity shards.
Improved fault tolerance: Erasure Coding can protect data even when multiple storage devices or nodes fail simultaneously. The data can be reconstructed using the available shards and parity information.
Enhanced data durability: By distributing data across multiple nodes, erasure coding provides higher resilience against data loss due to hardware failures or disasters.
Efficient data processing: Erasure Coding allows for parallel read and write operations, enabling faster data access and improved performance.

<https://min.io/docs/minio/linux/operations/concepts/erasure-coding.html#minio-erasure-coding>

Erasure Coding
MinIO implements Erasure Coding as a core component in providing data redundancy and availability. This page provides an introduction to MinIO Erasure Coding.

See Availability and Resiliency and Deployment Architecture for more information on how MinIO uses erasure coding in production deployments.

MinIO groups drives in each server pool into one or more Erasure Sets of the same size.

**![Erasure coding](https://min.io/docs/minio/linux/_images/erasure-coding-erasure-set.svg)**

For each write operation, MinIO partitions the object into data and parity shards.
Erasure set stripe size dictates the maximum possible parity of the deployment. The formula for determining the number of data and parity shards to generate is:

N (ERASURE SET SIZE) = K (DATA) + M (PARITY)

**![Erasure set](https://min.io/docs/minio/linux/_images/erasure-coding-possible-parity.svg)**

You can set the parity value between 0 and 1/2 the Erasure Set size.
**![Erasure set with different parity](https://min.io/docs/minio/linux/_images/erasure-coding-erasure-set-shard-distribution.svg)**
