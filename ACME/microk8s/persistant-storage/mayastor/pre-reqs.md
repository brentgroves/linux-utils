https://mayastor.gitbook.io/introduction/quickstart/prerequisites
https://en.wikipedia.org/wiki/SSE4
Intel SSE4 consists of 54 instructions. A subset consisting of 47 instructions, referred to as SSE4.1 in some Intel documentation, is available in Penryn. Additionally, SSE4.2, a second subset consisting of the 7 remaining instructions, is first available in Nehalem-based Core i7. Intel credits feedback from developers as playing an important role in the development of the instruction set.

All worker nodes must satisfy the following requirements:
x86-64 CPU cores with SSE4.2 instruction support
Linux kernel 5.13 or higher with the following modules loaded:
nvme-tcp
ext4 and optionally xfs

https://stackoverflow.com/questions/4203235/how-to-test-if-your-linux-support-sse2
mayastore requires sse4_2
cat /proc/cpuinfo | grep sse4_2 
each core will have a flags tag that will contain sse4_2 if it has it.

Worker Node Count
As of version 1.0 the minimum supported worker node count is three nodes.
Note also, that when using the synchronous replication feature (N+1 mirroring), the number of worker nodes to which Mayastor pods are deployed should be no less than the desired replication factor. E.g. four-way mirroring of a volume would require Mayastor pods to be deployed to a minimum of four worker nodes within the cluster.

Transport Protocols
As of version 1.0, Mayastor supports the export and mounting of volumes over NVMe-oF TCP only. Worker nodes on which an application pod using Mayastor volume(s) may be scheduled must have the requisite NVMe initiator support installed and configured.