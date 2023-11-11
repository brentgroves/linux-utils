# Reboot K8s nodes

## Why and How Should You Reboot Kubernetes Nodes?

**[Rebooting K8s Nodes](https://elastisys.com/why-and-how-should-you-reboot-kubernetes-nodes)**

"
Let’s start with what Kubernetes administrators control least: the hypervisor and the firmware. Cloud providers move VMs away from a server – a.k.a., they “drain” the server – patch the server, and finally reboot it. So how do cloud providers drain servers? There are two ways: either by live-migrating VMs, force-rebooting VMs or waiting for a voluntary VM reboot. Live-migration entails a non-negligible performance impact, and may actually never complete. Force-rebooting a VM allows it to be restarted on another server, but may anger Kubernetes administrators, since essentially looks like involuntary disruption, so it is rather frowned upon. Hence, the preferred method is to wait – or ask – for a voluntary VM reboot, which at the Kubernetes cluster’s level corresponds to a Node reboot.

What about the stack that Kubernetes administrators do control, like the container runtime, Kubernetes components, and VM Linux kernel? Details differ a bit on how the Kubernetes cluster is set up. If the underlying Linux distribution is Ubuntu, one simply needs to install the unattended-updates package, and security patches are automatically applied. If rebooting the Nodes is required, e.g., as is the case with a Linux kernel security patch, a file called /var/run/reboot-required is created.

The only thing left to do is … you guessed it … reboot the Node when the package manager asks.

"

## How to reboot Kubernetes Nodes?

"
Testing
You can test your configuration by provoking a reboot on a node:

sudo touch /var/run/reboot-required
Disabling Reboots
If you need to temporarily stop kured from rebooting any nodes, you can take the lock manually:

kubectl -n kube-system annotate ds kured weave.works/kured-node-lock='{"nodeID":"manual"}'
Don’t forget to release it afterwards!

Manual Unlock
In exceptional circumstances, such as a node experiencing a permanent failure whilst rebooting, manual intervention may be required to remove the cluster lock:

kubectl -n kube-system annotate ds kured weave.works/kured-node-lock-
NB the - at the end of the command is important - it instructs kubectl to remove that annotation entirely.

Now that I convince you that you need to regularly reboot Kubernetes Nodes, let’s discuss how to do this, automatedly and without angering application developers.

Kubernetes distinguishes between voluntary and involuntary disruptions. A planned Node reboot for security patching is a voluntary disruption. In order to act nicely to the application on top, the process is as follows:

Cordon the Node, so that no new containers are started on the to-be-rebooted Node.

Drain the Node, so that containers running on the Node are terminated. This is performed so as to respect terminationGracePeriodSeconds and PodDisruptionBudgets.

Reboot the Node.

Uncordon the Node.

This process needs to be done for each Node and – quite frankly – is tedious and unrewarding. Instead, you can install the Kubernetes Reboot Daemon (kured) to do that for you. Kured watches the famous “reboot-required” file and does the operations above on behalf of the Kubernetes administrator. It uses a special lock to make sure that only one Node is ever rebooted at a time. Kured can also be configured to only perform reboots during “off hours” or during maintenance windows, say Wed 6-8, to minimise disruptions to the application.

"

## Kubernetes Reboot Daemon

**[Kubernetes Reboot Daemon](https://kured.dev/)**
"
Watches for the presence of a reboot sentinel file e.g. /var/run/reboot-required or the successful run of a sentinel command.
Cordons & drains worker nodes before reboot, uncordoning them after.
Utilises a lock in the API server to ensure only one node reboots at a time.
Optionally defers reboots in the presence of active Prometheus alerts or selected pods.
"
