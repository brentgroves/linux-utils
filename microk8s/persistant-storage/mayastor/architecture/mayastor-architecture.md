<https://github.com/openebs/mayastor>
<https://www.youtube.com/watch?v=n1npnB37lN8>
<https://www.youtube.com/watch?v=Bit4GnANuLc>
Control plane:
A microservices patterned control plane, centered around a core agent which publicly exposes a RESTful API. This is extended by a dedicated operator responsible for managing the life cycle of "Mayastor Pools" (an abstraction for devices supplying the cluster with persistent backing storage) and a CSI compliant external provisioner (controller). Source code for the control plane components is located in its own repository

A per node instance mayastor-csi plugin which implements the identity and node grpc services from CSI protocol.

Data plane:
Each node you wish to use for storage or storage services will have to run a Mayastor daemon set. Mayastor itself has three major components: the Nexus, a local storage component, and the mayastor-csi plugin.

Nexus
The Nexus is responsible for attaching to your storage resources and making it available to the host that is selected to run your k8s workload. We call these from the Nexus' point of view its "children".

The goal we envision the Nexus to provide here, as it sits between the storage systems and PVCs, is loose coupling.

A practical example: Once you are up and running with persistent workloads in a container, you need to move your data because the storage system that stores your PVC goes EOL. You now can control how this impacts your team without getting into storage migration projects, which are always painful and complicated. In reality, the individual storage volumes per team/app are relatively small, but today it is not possible for individual teams to handle their own storage needs. The Nexus provides the abstraction over the resources such that the developer teams stay in control.

The reason we think this can work is because applications have changed, and the way they are built allows us to rethink they way we do things. Moreover, due to hardware changes we in fact are forced to think about it.

Based on storage URIs the Nexus knows how to connect to the resources and will make these resources available as a single device to a protocol standard protocol. These storage URIs are generated automatically by MOAC and it keeps track of what resources belong to what Nexus instance and subsequently to what PVC.
