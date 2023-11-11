# HA dynamic storage with OpenEBS

**[Good example of HA dynamic storage](https://www.youtube.com/watch?v=n1npnB37lN8)**

## Features

Mayastor pool can have access to whatever storage is attached to your node.

## replicate database

If you use Hostpath and the node gets messed up you have lost your data.

Using EBS if the node crashes the workload will just use one of the other nodes.

## High Availability

**[HA](https://mayastor.gitbook.io/introduction/advanced-operations/ha)**

High Availability
Mayastor 2.0 enhances High Availability (HA) of the volume target with the nexus switch-over feature. In the event of the target failure, the switch-over feature quickly detects the failure and spawns a new nexus to ensure I/O continuity. The HA feature consists of two components: the HA node agent (which runs in each csi- node) and the cluster agent (which runs alongside the agent-core). The HA node agent looks for io-path failures from applications to their corresponding targets. If any such broken path is encountered, the HA node agent informs the cluster agent. The cluster-agent then creates a new target on a different (live) node. Once the target is created, the node-agent establishes a new path between the application and its corresponding target. The HA feature restores the broken path within seconds, ensuring negligible downtime.

## Replica Rebuilds

**[Rebuilds](https://mayastor.gitbook.io/introduction/advanced-operations/replica-rebuild)**
With the previous versions, the control plane ensured replica redundancy by monitoring all volume targets and checking for any volume targets that were in Degraded state, indicating that one or more replicas of that volume targets were faulty. When a matching volume targets is found, the faulty replica is removed. Then, a new replica is created and added to the volume targets object. As part of adding the new child data-plane, a full rebuild was initiated from one of the existing Online replicas. However, the drawback to the above approach was that even if a replica was inaccessible for a short period (e.g., due to a node restart), a full rebuild was triggered. This may not have a significant impact on replicas with small sizes, but it is not desirable for large replicas.

## Volume Snapshot

**[Snapshot](https://mayastor.gitbook.io/introduction/advanced-operations/snapshot)**
