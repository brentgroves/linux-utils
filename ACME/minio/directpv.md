# What is DirectPV

DirectPV is a CSI driver that will discover and manage drives all across your network.

## references

<https://stackoverflow.com/questions/72432643/minio-k8s-operator-disk-placement>

## Architecture

<https://min.io/directpv>
Architecture
DirectPV is designed to be lightweight and scalable to tens of thousands of drives. It is made up of three components - Controller, Node Driver, UI.

It is useful to discover, format, mount, schedule and monitor drives across servers. Since Kubernetes hostPath and local PVs are statically provisioned and limited in functionality, DirectPV was created to address this limitation.

Distributed data stores such as object storage, databases and message queues are designed for direct attached storage, and they handle high availability and data durability by themselves. Running them on traditional SAN or NAS based CSI drivers (Network PV) adds yet another layer of replication/erasure coding and extra network hops in the data path. This additional layer of disaggregation results in increased-complexity and poor performance.

<https://min.io/directpv>

<https://github.com/minio/directpv>

DirectPV is a CSI driver for Direct Attached Storage. In a simpler sense, it is a distributed persistent volume manager, and not a storage system like SAN or NAS. It is useful to discover, format, mount, schedule and monitor drives across servers.

Distributed data stores such as object storage, databases and message queues are designed for direct attached storage, and they handle high availability and data durability by themselves. Running them on traditional SAN or NAS based CSI drivers (Network PV) adds yet another layer of replication/erasure coding and extra network hops in the data path. This additional layer of disaggregation results in increased-complexity and poor performance.
