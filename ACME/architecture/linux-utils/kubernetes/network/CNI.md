<https://www.tkng.io/cni/>

CNI
Main Goals
The official documentation outlines a number of requirements that any CNI plugin implementation should support. Rephrasing it in a slightly different way, a CNI plugin must provide at least the following two things:
Connectivity - making sure that a Pod gets its default eth0 interface with IP reachable from the root network namespace of the hosting Node.
Reachability - making sure that Pods from other Nodes can reach each other directly (without NAT).

Connectivity requirement is the most straight-forward one to understand – every Pod must have a NIC to communicate with anything outside of its own network namespace. Some local processes on the Node (e.g. kubelet) need to reach PodIP from the root network namespace (e.g. to perform health and readiness checks), hence the root NS connectivity requirement.

There are a number of reference CNI plugins that can be used to setup connectivity, most notable examples are:

ptp – creates a veth link in the root namespace and plugs the other end into the Pod’s namespace.
bridge – does the same but also connects the rootNS end of the link to the bridge.
macvlan/ipvlan – use the corresponding drivers to connect containers directly to the NIC of the Node.

Reachability, on the other hand, may require a bit of unpacking:

Every Pod gets a unique IP from a PodCIDR range configured on the Node.
This range is assigned to the Node during kubelet bootstrapping phase.
Nodes are not aware of PodCIDRs assigned to other Nodes, allocations are normally managed by the controller-manager based on the --cluster-cidr configuration flag.
Depending on the type of underlying connectivity, establishing end-to-end reachability between PodCIDRs may require different methods:
If all Nodes are in the same Layer2 domain, the connectivity can be established by configuring a full mesh of static routes on all Nodes with NextHop set to the internal IP of the peer Nodes.
If some Nodes are in different Layer2 domains, the connectivity can be established with either:
Orchestrating the underlay – usually done with BGP for on-prem or some form of dynamically-provisioned static routes for public cloud environments.
Encapsulating in the overlay – VXLAN is still the most popular encap type.
