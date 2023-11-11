# My Father's will

I love you my son.  Please don't forget that I am always with you.  Through the tough times I will support you.  Through your work I am there too.  I intend for you and I to have an enjoyable time together as my plan unfolds for you life.  Remember to help and give your all to everyone I place in your life and you will have peace and joy in abundance my beloved son!

## High Availibility

## References

<https://www.reddit.com/r/kubernetes/comments/146aeki/ha_k8s_with_3_combined_controle_worker_nodes/>

## Network Interfaces

You can create as many network interfaces on a host as you desire.  Each interface can be assigned a unique IP addess.  If you ping the IP address associated with the main network interface and you are on another computer in the same subdomain it only takes one hop. Pinging the IP address associated with a secondary network interface takes two hops.

## Should I use 3 Control Plane nodes to achieve HA?

If we add 2 additional control plane nodes to the master control pland node then the k8s cluster show a HA status.

After looking at the following argument I don't care if the cluster says HA anymore and will stick to having just 1 control plane node in addition to the master control plane node.  There will then be more worker nodes having more memory for our applications. Unfortunately having 2 master nodes only is not allowed per the last comment below.

**[Is it benificial to have 3 control plane nodes in a cluster?
](https://www.reddit.com/r/kubernetes/comments/146aeki/ha_k8s_with_3_combined_controle_worker_nodes)**

"Another point in 3 nodes HA - if two of the etcd nodes fail for some reason, the 3rd one (healthy) will think, that actually the issue is with itself, since it's 1 and the supposedly problematic are two and the chances of it being bugged, rather than two out of three nodes being down is less, so in the end it stops working too, so it literally kills the whole thing, even if you have a literally healthy member"

"yeah but this issue affect every 3 node control pane setup, they only solution against a 2 node failure would be 5 nodes I guess"

"This is common knowledge for the raft consensus protocol. Go look it up."

"As far as I read a candidate needs to get the majority of votes which is not possible if 2 nodes out of 3 are down. Therefore it cannot be elected. There could be the lucky case that the nodes which went done just where follower then everything would be fine since leader is still up
"

## How to keep your git directories uptodate with the main branch

```bash
# git@github.com:brentgroves/linux-utils.git
# git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/mobexsql
# git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports
# If you want to change anything in them please create a new branch
# At the start of the day you run this command to get repo updates
~/startday.sh
# If you get error messages from ~/startday.sh that means there were changes made in our repo directories.  In that case you can either stash your changes or undo them.
# To undo any changes inadvertantly made in the repo directories run this command which removes the directies and recreates them.
~/freshstart.sh

```

## K8s Observable Report System on our private cloud

- Added Carl Stangland as sudo user for devcon2 and reports1 k8s cluster.
- Setup Ceph Storage Cluster and Rook-Ceph management operator

## Setup Ceph Storage Cluster and Rook-Ceph management operator

We need Mayastor or Ceph to give use the ability to dynamically increase storage volume size.

Ceph Cluster Info:

- 3 nodes
- 3 20 GB virtual disks per node
- 2 replica sets meaning 3 copies of every object.
- Prometheus Alertmanager alerts
- Metrics collection with Prometheus

## Object based storage device (OSD)

<https://medium.com/@kamal.maiti/object-based-storage-architecture-b841e5842124>

"
Overview
It is fascinating to observe how computing and storage have been separated in recent years to support massive scale at both levels. In terms of storage, the industry has relied on file and block-based storage for a long time. However, managing metadata such as inode or other attributes, or journal information, can be a burden for the compute node that manages the file system.

To alleviate this burden, a new way of storing files on disk has emerged rapidly in recent years: object-based storage. By using an “object ID,” specific files can be tracked, retrieved, and deleted. Essentially, some metadata has been reduced and is maintained by a separate compute node called a “metadata server.”
"

## Crush Maps

<https://docs.ceph.com/en/quincy/rados/operations/crush-map/>

The CRUSH algorithm computes storage locations in order to determine how to store and retrieve data. CRUSH allows Ceph clients to communicate with OSDs directly rather than through a centralized server or broker. By using an algorithmically-determined method of storing and retrieving data, Ceph avoids a single point of failure, a performance bottleneck, and a physical limit to its scalability.

## What is Rook-Ceph

<https://rook.github.io/docs/rook/latest/Getting-Started/intro/>
Rook is an open source cloud-native storage orchestrator, providing the platform, framework, and support for Ceph storage to natively integrate with cloud-native environments. Ceph is a distributed storage system that provides file, block and object storage and is deployed in large scale production clusters.

Note: Before enabling the rook-ceph addon on a strictly confined MicroK8s, make sure the rbd kernel module is loaded with sudo modprobe rbd

## What is Ceph RPD

Ceph RBD (RADOS Block Device) block storage stripes virtual disks over objects within a Ceph storage cluster, distributing data and workload ...

RPD is a utility for manipulating rados block device (RBD) images, used by the Linux rbd driver and the rbd storage driver for QEMU/KVM. RBD images are simple block devices that are striped over objects and stored in a RADOS object store. The size of the objects the image is striped over must be a power of two.
