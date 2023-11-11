https://sniansfblog.org/comparing-iscsi-iser-and-nvme-over-fabrics-nvme-of-ecosystem-interoperability-performance-and-use-cases/
https://mayastor.gitbook.io/introduction/


What is Mayastor?
Mayastor is a performance optimised "Container Attached Storage" (CAS) solution of the CNCF project . The goal of OpenEBS is to extend Kubernetes with a declarative data plane, providing flexible persistent storage for stateful applications.
Design goals for Mayastor include:
Highly available, durable persistence of data
To be readily deployable and easily managed by autonomous SRE or development teams
To be a low-overhead abstraction for NVMe-based storage devices
Mayastor incorporates Intel's https://spdk.io/ Storage Performance Development Kit. It has been designed from the ground up to leverage the protocol and compute efficiency of NVMe-oF semantics, and the performance capabilities of the latest generation of solid-state storage devices, in order to deliver a storage abstraction with performance overhead measured to be within the range of single-digit percentages.
By comparison, most "shared everything" storage systems are widely thought to impart an overhead of at least 40% (and sometimes as much as 80% or more) as compared to the capabilities of the underlying devices or cloud volumes; additionally traditional shared storage scales in an unpredictale manner as I/O from many workloads interact and compete for resources.
While Mayastor utilizes NVMe-oF it does not require NVMe devices or cloud volumes to operate and can work well with other device types