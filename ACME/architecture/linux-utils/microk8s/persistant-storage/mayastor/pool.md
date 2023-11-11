What is declarative storage?
When an app is deployed to k8s you select the amount of storage that is required and how many replicas is to be maintained.  For the MySQL and MongoDB we have selected 3 replicas for database storage. So the Mayastore control plane takes care of replicating every database write to the Mayastore sparse image file on each node.
What is a Mayastor Pool?
When a Mayastor node allocates storage capacity for a replica of a Persistent Volume it does so from a Mayastor Pool. Each Mayastor node may create and manage zero, one, or more such pools. The ownership of a pool by a node is exclusive. A pool can manage only one block device, which constitutes the entire data persistence layer for that pool and thus defines its maximum storage capacity.

https://mayastor.gitbook.io/introduction/quickstart/configure-mayastor#create-mayastor-pool-s
Configure Pools for Use with this Quickstart
To continue with this quick start exercise, a minimum of one pool is necessary, created and hosted on one of the Mayastor nodes in the cluster. However, the number of pools available limits the extent to which the synchronous n-way mirroring feature ("replication") of Persistent Volumes can be configured for testing and evaluation; the number of pools configured should be no fewer than the desired maximum replication factor of the PVs to be created. Also, while placing data replicas ensure that appropriate redundancy is provided. Mayastor's control plane will avoid locating more than one replica of a volume on the same Mayastor node. Therefore, for example, the minimum viable configuration for a Mayastor deployment which is intended to test 3-way mirrored PVs must have three Mayastor Nodes, each having one Mayastor Pool, with each of those pools having one unique block device allocated to it.

Verify Pool Creation and Status
The status of Mayastor Pools may be determined by reference to their cluster CRs. Available, healthy pools should report their State as online. Verify that the expected number of pools have been created and that they are online.
kubectl -n mayastor get msp
NAME                        NODE        STATUS   CAPACITY      USED         AVAILABLE
microk8s-reports33-pool     reports33   Online   21449670656   0            21449670656
pool-reports32-994175.img   reports32   Online   19977469952   5368709120   14608760832
pool-reports31-cd5afc.img   reports31   Online   19977469952   5368709120   14608760832

https://microk8s.io/docs/addon-mayastor

Configure MayaStor pools
By default, the MayaStor addon will create one pool per node, backed by a local image file. For production use, it is recommended that you instead use designated disks.

For convenience, a helper script is provided to easily create, list and delete mayastor pools from the cluster:

Examples:

# get help
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py --help
'

# create a mayastor pool using `/dev/sdb` on node `uk8s-1`
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node uk8s-1 --device /dev/sdb
'

# create a mayastor pool of 100GB using a sparse image file on node `uk8s-1`. The image file will be placed under `/var/snap/microk8s/common/mayastor/data`.
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node uk8s-1 --size 100GB
'

# list mayastor pools
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py list
'

# delete a mayastor pool. --force removes it even if the pool is in use, --purge removes the backing image file
# the mayastor pool name is required, as it appears in the output of the list command
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py remove microk8s-uk8s-1-pool --force --purge


https://github.com/canonical/microk8s/issues/3714
**Only 1 mayastorpools created**

#### Summary
When I enabled mayastor on a 3 node HA cluster only 1 mayastorpools is created.  
#### What Should Happen Instead?
3 mayastorpools should get created.  
#### Reproduction Steps
1. sudo microk8s enable core/mayastor --default-pool-size 20G
2. sudo microk8s.kubectl get pod -n mayastor 
```
NAME                                     READY   STATUS    RESTARTS      AGE
etcd-operator-mayastor-65f9967f5-s9lrf   1/1     Running   0             42h
mayastor-csi-cb629                       2/2     Running   0             42h
mayastor-csi-jtzr6                       2/2     Running   0             42h
mayastor-csi-htf2t                       2/2     Running   0             42h
etcd-djlr7lvfs8                          1/1     Running   0             42h
core-agents-55d76bb877-87pj5             1/1     Running   1 (42h ago)   42h
etcd-88lphrb7wv                          1/1     Running   0             42h
msp-operator-74ff9cf5d5-w8l4t            1/1     Running   0             42h
rest-77d69fb479-4lp7m                    1/1     Running   0             42h
etcd-ffxccpr8tf                          1/1     Running   0             42h
mayastor-b6nql                           1/1     Running   0             42h
csi-controller-54ccfcfbcc-lgn69          3/3     Running   0             42h
mayastor-lp84p                           1/1     Running   0             42h
mayastor-2tjdb                           1/1     Running   0             42h
```
3. sudo microk8s.kubectl get mayastorpool -n mayastor  
```
NAME                        NODE        STATUS   CAPACITY      USED   AVAILABLE  
microk8s-reports33-pool     reports33   Online   21449670656   0      21449670656  
only 1 pool is created
```
5. The image files get created.  
```
ls -alh /var/snap/microk8s/common/mayastor/data
each node has an image file like this:
-rw-r--r-- 1 root root  20G Jan 29 02:25 microk8s.img
```
7. manually create mayastorpool on other 2 nodes.
```
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node reports31 --size 20GB
'
sudo microk8s.kubectl get mayastorpool -n mayastor
NAME                        NODE        STATUS   CAPACITY      USED   AVAILABLE
microk8s-reports33-pool     reports33   Online   21449670656   0      21449670656
pool-reports32-994175.img   reports32   Online   19977469952   0      19977469952
pool-reports31-cd5afc.img   reports31   Online   19977469952   0      19977469952
```

**Notes**
This mayastor experiment was conduction on a 3 freshly installed Ubuntu 22.04 system running on dell optiplex 9020,7010, and 7020.  
I did notice that there is now a zombie process on the main node.  

