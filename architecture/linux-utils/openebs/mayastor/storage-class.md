<https://mayastor.gitbook.io/introduction/quickstart/configure-mayastor#create-mayastor-storageclass-s>

Mayastor dynamically provisions PersistentVolumes (PVs) based on StorageClass definitions created by the user. Parameters of the definition are used to set the characteristics and behaviour of its associated PVs. For a detailed description of these parameters see storage class parameter description. Most importantly StorageClass definition is used to control the level of data protection afforded to it (that is, the number of synchronous data replicas which are maintained, for purposes of redundancy). It is possible to create any number of StorageClass definitions, spanning all permitted parameter permutations.

Both the example YAMLs given below have thin provisioning enabled. You can modify these as required to match your own desired test cases, within the limitations of the cluster under test.

cat <<EOF | kubectl create -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: mayastor-1
parameters:
  ioTimeout: "30"
  protocol: nvmf
  repl: "1"
provisioner: io.openebs.csi-mayastor
EOF

cat <<EOF | kubectl create -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: mayastor-3
parameters:
  ioTimeout: "30"
  protocol: nvmf
  repl: "3"
provisioner: io.openebs.csi-mayastor
EOF

<https://mayastor.gitbook.io/introduction/quickstart/configure-mayastor/storage-class-parameters>

Storage Class Parameters
Storage class resource in Kubernetes is used to supply parameters to volumes when they are created. It is a convenient way of grouping volumes with common characteristics. All parameters take a string value. Brief explanation of each supported Mayastor parameter follows.
The storage class parameter local has been deprecated and is a breaking change in Mayastor version 2.0. Ensure that this parameter is not used.

"fsType"
File system that will be used when mounting the volume. The default file system when not specified is 'ext4'. We recommend to use 'xfs' that is considered to be more advanced and performant. Though make sure that XFS is installed on all nodes in the cluster before using it.

"ioTimeout"
Expressed in seconds and it sets the io_timeout parameter in the linux block device driver for Mayastor volume

"protocol"
The parameter 'protocol' takes the value nvmf(NVMe over TCP protocol). It is used to mount the volume (target) on the application node.

"repl"
The string value should be a number and the number should be greater than zero. Mayastor control plane will try to keep always this many copies of the data if possible. If set to one then the volume does not tolerate any node failure. If set to two, then it tolerates one node failure. If set to three, then two node failures, etc.

"thin"
The volumes can either be thick or thin provisioned. Adding the thin parameter to the StorageClass YAML allows the volume to be thinly provisioned. To do so, add thin: true under the parameters spec, in the StorageClass YAML. Sample YAML When the volumes are thinly provisioned, the user needs to monitor the pools, and if these pools start to run out of space, then either new pools must be added or volumes deleted to prevent thinly provisioned volumes from getting degraded or faulted. This is because when a pool with more than one replica runs out of space, Mayastor moves the largest out-of-space replica to another pool and then executes a rebuild. It then checks if all the replicas have sufficient space; if not, it moves the next largest replica to another pool, and this process continues till all the replicas have sufficient space.

The capacity usage on a pool can be monitored using exporter metrics.

Note:
By default, the volumes are provisioned as thick.
For a pool of a particular size, say 10 Gigabytes, a volume > 10 Gigabytes cannot be created, as Mayastor currently does not support pool expansion.
The replicas for a given volume can be either all thick or all thin. Same volume cannot have a combination of thick and thin replicas

"stsAffinityGroup"
stsAffinityGroup represents a collection of volumes that belong to instances of Kubernetes StatefulSet. When a StatefulSet is deployed, each instance within the StatefulSet creates its own individual volume, which collectively forms the stsAffinityGroup. Each volume within the stsAffinityGroup corresponds to a pod of the StatefulSet.

The High Availability feature ensures that there is no single point of failure for the targets. The stsAffinityGroup ensures that in such cases, the targets are distributed optimally for the stsAffinityGroup volumes.
By default, the stsAffinityGroup feature is disabled. To enable it, modify the storage class YAML by setting the parameters.stsAffinityGroup parameter to true.

"cloneFsIdAsVolumeId"
cloneFsIdAsVolumeId is a setting for volume clones/restores with two options: true and false. By default, it is set to false.
When set to true, the created clone/restore's filesystem uuid will be set to the restore volume's uuid. This is important because some file systems, like XFS, do not allow duplicate filesystem uuid on the same machine by default.
When set to false, the created clone/restore's filesystem uuid will be same as the orignal volume uuid, but it will be mounted using the nouuid flag to bypass duplicate uuid validation.
