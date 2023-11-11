https://www.reddit.com/r/kubernetes/comments/larfrm/stateful_set_vs_replicaset_vs_deployment/
Kubernetes manages all workloads as Pods. But you should almost never create and manage Pods yourself.

Instead you create Deployments and StatefulSets where a controller takes care of that.

The Deployment controller creates ReplicaSets which means a bunch of the same pods, same everything, just scheduled individually. If the deployment changes the Deployment controller creates a new ReplicaSet to replace the old one and takes care of a rolling deployment, meaning scaling one down and the other up as long as the PodDisruptionBudget is not violated. A Deployment works great for stateless applications where you can treat the pods as cattle.

StatefulSets are for stateful applications, where the identity of a Pod matters. The StatefulSet controller creates a number of Pods in order and actually numbers them. If it replaces them because the configuration changes, it keeps the names the same. A StatefulSet can also contain a volumeClaimTemplate; the controller will create PVCs for each Pod. The relation of Pod and PVC stays the same always, so they keep the same data, even when they're replaced. This makes them viable for applications where you have to treat your instances (or at least their identity) with more care.