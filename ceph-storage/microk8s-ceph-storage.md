<https://microk8s.io/docs/how-to-ceph>
<https://github.com/canonical/microceph>
<https://canonical-microceph.readthedocs-hosted.com/en/latest/>

HowTo setup MicroK8s with (Micro)Ceph storage
On this page
Install MicroCeph
Add virtual disks
Connect MicroCeph to MicroK8s
Further reading
With the 1.28 release, we introduced a new rook-ceph addon that allows users to easily setup, import, and manage Ceph deployments via rook.

In this guide we show how to setup a Ceph cluster with MicroCeph, give it three virtual disks backed up by local files, and import the Ceph cluster in MicroK8s using the rook-ceph addon.

## Install MicroCeph

MicroCeph is a lightweight way of deploying a Ceph cluster with a focus on reduced ops. It is distributed as a snap and thus it gets deployed with:

ssh brent@reports53
sudo snap install microceph --channel=latest/edge

What is a loop device?
In Unix-like operating systems, a loop device, vnd, or lofi is a pseudo-device that makes a computer file accessible as a block device. Before use, a loop device must be connected to an extant file in the file system.

## First, we need to bootstrap the Ceph cluster

```bash
sudo microceph cluster bootstrap
In this guide, we do not cluster multiple nodes. The interested reader can look into the official docs on how to form a multinode Ceph cluster with MicroCeph.

At this point we can check the status of the cluster and query the list of available disks that should be empty. The disk status is queried with:

sudo microceph.ceph status
  cluster:
    id:     cbc60080-71d6-450b-b660-a72313d89084
    health: HEALTH_WARN
            OSD count 0 < osd_pool_default_size 3

# About this warning
https://forum.proxmox.com/threads/ceph-health_warn-osd-count-0.102614/
Welcome,
when you have installed the CEPH-Modules but not asigned any Disks as OSD, then this is the normal warning.
You created a Storage-Cluster but have no disk assigned to it. Are you configuring a multi-node-hyper-converged Setup?
If not, leave CEPH alone and don't even install it. Its just for distributed highly available storage in Proxmox....

  services:
    mon: 1 daemons, quorum reports53 (age 33s)
    mgr: reports53(active, since 24s)
    osd: 0 osds: 0 up, 0 in

  data:
    pools:   0 pools, 0 pgs
    objects: 0 objects, 0 B
    usage:   0 B used, 0 B / 0 B avail
    pgs:
```

## What is an ceph osd

ceph-osd is the object storage daemon for the Ceph distributed file system. It is responsible for storing objects on a local file system and providing access to them over the network. The datapath argument should be a directory on a xfs file system where the object data resides.

## What is an **[xfs file system](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/storage_administration_guide/ch-xfs)**

XFS features:

- XFS supports metadata journaling, which facilitates quicker crash recovery.
- The XFS file system can be defragmented and enlarged while mounted and active.
- Extent-based allocation
- Journaling file system

## What is a **[xfs vs ext4 journaling files system](https://www.partitionwizard.com/partitionmanager/xfs-vs-ext4.html)**?

What is journaling file system? A journaling file system has a log which records information about changes made in file system. If file system failures (such as a kernel crash or a sudden power failure) occur, the system can recover data easily according to the log.

In terms of XFS vs Ext4, XFS is superior to Ext4 in the following aspects:

- Larger Partition Size and File Size
- Dynamically Allocated Inodes (Inodes save the attributes and location of the data. It is used to index the file.)
- More Xattr (Extended Attributes) Space (Extended file attributes are file system features that enable users to associate computer files with metadata)
- Allocation Groups: XFS file systems are internally partitioned into allocation groups to manage inodes and free space separately, providing scalability and parallelism, so multiple threads and processes can perform I/O operations on the same file system simultaneously.
- In-Built Dump and Restore Tool: XFS has xfsdump and xfsrestore utilities, which can back up and restore contents.

```bash
sudo microceph disk list 
Disks configured in MicroCeph:
+-----+----------+------+
| OSD | LOCATION | PATH |
+-----+----------+------+

Available unpartitioned disks on this system:
+--------------+----------+-------+------------------------------------------------+
|    MODEL     | CAPACITY | TYPE  |                      PATH                      |
+--------------+----------+-------+------------------------------------------------+
| QEMU DVD-ROM | 0B       | cdrom | /dev/disk/by-id/scsi-1ATA_QEMU_DVD-ROM_QM00001 |
+--------------+----------+-------+------------------------------------------------+

## How to create a virtual disk?
Add virtual disks
The following loop creates three files under /mnt that will back respective loop devices. Each Virtual disk is then added as an OSD to Ceph:

pushd ~/src/linux-utils/ceph-storage

# losetup is used to associate loop devices with regular files or block devices, to detach loop devices, and to query the status of a loop device. If only the ...

# The system call mknod() creates a filesystem node (file, device special file, or named pipe) named pathname, with attributes specified by mode and dev. The mode argument specifies both the file mode to use and the type of node to be created

vi add3vd.sh

for l in a b c; do
  # Creates a file matching with a random name 4 digits long.
  loop_file="$(sudo mktemp -p /mnt XXXX.img)"
  # Make the file 1G in size.
  sudo truncate -s 1G "${loop_file}"
  # Associate loop device with the file
  # What is a loop device?
  # In Unix-like operating systems, a loop device, vnd (virtual node disk), # or lofi (loop file interface) is a 
  # pseudo-device that makes a computer file accessible as a block device. 
  # Before use, a loop device must be connected to an extant file in the
  # file system.

  loop_dev="$(sudo losetup --show -f "${loop_file}")"
#  the block-devices plug doesn't allow accessing /dev/loopX devices so we make those same devices available under alternate names (/dev/sdiY)
  minor="${loop_dev##/dev/loop}"
  # The system call mknod() creates a filesystem node (file, device
  #      special file, or named pipe) named pathname, with attributes
  #      specified by mode and dev.
  # The mknod command makes a directory entry and corresponding i-node for a special file. The first parameter is the name of the entry device. The b flag indicates that the special file. The last two parameters of the first form are numbers that specify the Major device and the Minor device. The Major device number helps the operating system find the device driver code. Major device number 7 is for loop devices. The Minor device number is the unit drive or line number that might be either decimal or octal.  

  sudo mknod -m 0660 "/dev/sdi${l}" b 7 "${minor}"
  sudo microceph disk add --wipe "/dev/sdi${l}"
done

chmod +x add3vd.sh

./add3vd.sh

ls -al /mnt
total 1301028
drwxr-xr-x  3 root root       4096 Oct 25 21:50 .
drwxr-xr-x 19 root root       4096 Feb  7  2023 ..
-rw-------  1 root root 1073741824 Oct 28 18:13 43wl.img
-rw-------  1 root root 1073741824 Oct 28 18:13 DNBI.img
-rw-------  1 root root 1073741824 Oct 28 14:01 ei1R.img

losetup
/dev/loop13         0      0         0  0 /mnt/DNBI.img                             0     512
/dev/loop14         0      0         0  0 /mnt/ei1R.img                             0     512
/dev/loop12         0      0         0  0 /mnt/43wl.img                             0     512

ls -al /dev/sdi*
brw-rw---- 1 root root 7, 12 Oct 28 18:13 /dev/sdia
brw-rw---- 1 root root 7, 13 Oct 28 18:13 /dev/sdib
brw-rw---- 1 root root 7, 14 Oct 28 14:01 /dev/sdic

sudo microceph disk list 

Disks configured in MicroCeph:
+-----+-----------+-----------+
| OSD | LOCATION  |   PATH    |
+-----+-----------+-----------+
| 0   | reports53 | /dev/sdia |
+-----+-----------+-----------+
| 1   | reports53 | /dev/sdib |
+-----+-----------+-----------+
| 2   | reports53 | /dev/sdic |
+-----+-----------+-----------+

sudo microceph.ceph status
  cluster:
    id:     cbc60080-71d6-450b-b660-a72313d89084
    health: HEALTH_OK
 
  services:
    mon: 1 daemons, quorum reports53 (age 36m)
    mgr: reports53(active, since 36m)
    osd: 3 osds: 3 up (since 58s), 3 in (since 63s)
 
  data:
    pools:   1 pools, 1 pgs
    objects: 2 objects, 577 KiB
    usage:   63 MiB used, 2.9 GiB / 3 GiB avail
    pgs:     1 active+clean

```

It is worth looking into customizing your Ceph setup at this point. Here, as this cluster is a local one and is going to be used by a local MicroK8s deployment we set the replica count to be 2, we disable manager redirects, and we set the bucket type to use for chooseleaf in a CRUSH rule to 0:

```bash
sudo microceph.ceph config set global osd_pool_default_size 2
sudo microceph.ceph config set mgr mgr_standby_modules false
sudo microceph.ceph config set osd osd_crush_chooseleaf_type 0
```

<https://docs.ceph.com/en/reef/>

## Connect MicroCeph to MicroK8s with rook

<https://microk8s.io/docs/addon-rook-ceph>
Rook turns distributed storage systems into self-managing, self-scaling, self-healing storage services.
It automates the tasks of a storage administrator: deployment, bootstrapping, configuration, provisioning, scaling, upgrading, migration, disaster recovery, monitoring, and resource management.

This addon deploys the Rook Kubernetes Operator for Ceph.

The rook-ceph addon first appeared with the 1.28 release, so we should select a MicroK8s deployment channel greater or equal to 1.28:

<https://microk8s.io/docs/how-to-ceph>

<https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/4/html-single/block_device_guide/index#map-and-mount-a-ceph-block-device-on-linux-using-the-command-line_blockAs>
as a storage administrator, you can access Ceph block devices through the rbd kernel module. You can map and unmap a block device, and displaying those mappings. Also, you can get a list of images through the rbd kernel module.
<https://docs.ceph.com/en/latest/rbd/rbd-ko/>

```bash
## Without this mod enabled sudo microk8s connect-external-ceph would not connect to microceph running on reports53
sudo modprobe rbd
## I don't know if this module needs to persist
echo 'rbd' | sudo tee -a /etc/modules-load.d/microk8s-rbd.conf
cat /etc/modules-load.d/microk8s-rbd.conf
rbd device list # permission denied
```

### What is stictly confined?

<https://ubuntu.com/blog/strictly-confined-microk8s>
"
MicroK8s is now available as a strictly confined snap on 1.25!

snap install microk8s --channel=1.25-strict/stable
What is strict confinement?
In summary, it is a snap confinement level that provides complete isolation, up to a minimal access level that’s always deemed safe. Strictly confined snaps can not access files, networks, processes, or any other system resource without requesting specific access. Strict confinement uses security features of the Linux kernel, including AppArmor, seccomp, and namespaces to prevent applications and services from accessing the wider system.
"
note; I didn't include sudo on this command.
The output message of enabling the addon, sudo microk8s enable rook-ceph, describes what the next steps should be to import a Ceph cluster:

```bash
# install addon
microk8s enable rook-ceph
Infer repository core for addon rook-ceph
Add Rook Helm repository https://charts.rook.io/release
"rook-release" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "rook-release" chart repository
Update Complete. ⎈Happy Helming!⎈
Install Rook version v1.11.9
NAME: rook-ceph
LAST DEPLOYED: Wed Oct 25 22:18:12 2023
NAMESPACE: rook-ceph
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Rook Operator has been installed. Check its status by running:
  kubectl --namespace rook-ceph get pods -l "app=rook-ceph-operator"
NAME                                  READY   STATUS    RESTARTS   AGE
rook-ceph-operator-5886b6b65d-t8lcc   1/1     Running   0          2m45s

Visit https://rook.io/docs/rook/latest for instructions on how to create and configure Rook clusters

Important Notes:
- You must customize the 'CephCluster' resource in the sample manifests for your cluster.
- Each CephCluster must be deployed to its own namespace, the samples use `rook-ceph` for the namespace.
- The sample manifests assume you also installed the rook-ceph operator in the `rook-ceph` namespace.
- The helm chart includes all the RBAC required to create a CephCluster CRD in the same namespace.
- Any disk devices you add to the cluster in the 'CephCluster' must be empty (no filesystem and no partitions).
Creating 'microk8s connect-external-ceph' command

=================================================

Rook Ceph operator v1.11.9 is now deployed in your MicroK8s cluster and
will shortly be available for use.

As a next step, you can either deploy Ceph on MicroK8s, or connect MicroK8s with an existing Ceph cluster.

To connect MicroK8s with an existing Ceph cluster, you can use the helper command
'microk8s connect-external-ceph'. If you are running MicroCeph on the same node, then you can use the following command:

## Without the rbd module enabled sudo microk8s connect-external-ceph would not connect to microceph running on reports53
sudo microk8s connect-external-ceph

Alternatively, you can connect MicroK8s with any external Ceph cluster using:

    sudo microk8s connect-external-ceph \
        --ceph-conf /path/to/cluster/ceph.conf \
        --keyring /path/to/cluster/ceph.keyring \
        --rbd-pool microk8s-rbd

For a list of all supported options, use 'microk8s connect-external-ceph --help'.

To deploy Ceph on the MicroK8s cluster using storage from your Kubernetes nodes, refer
to https://rook.io/docs/rook/latest-release/CRDs/Cluster/ceph-cluster-crd/

```

At the end of this process you should have a storage class ready to use:

NAME       PROVISIONER                  RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
ceph-rbd   rook-ceph.rbd.csi.ceph.com   Delete          Immediate           true                   3h38m

```bash
kubectl get sc
microk8s-hostpath (default)   microk8s.io/hostpath         Delete          WaitForFirstConsumer   false                  4d22h
ceph-rbd                      rook-ceph.rbd.csi.ceph.com   Delete          Immediate              true                   2d22h

kubectl get svc microk8s-console -n minio-operator -o yaml

```

## START HERE

As we have already setup MicroCeph having it managed by rook is done with just:

microk8s connect-external-ceph
Looking for MicroCeph on the host
Detected existing MicroCeph installation
Attempting to connect to Ceph cluster
Successfully connected to cbc60080-71d6-450b-b660-a72313d89084 (172.20.88.67:0/917798456)
Creating pool microk8s-rbd0 in Ceph cluster
Configuring pool microk8s-rbd0 for RBD
Successfully configured pool microk8s-rbd0 for RBD
Creating namespace rook-ceph-external
namespace/rook-ceph-external created
Configuring Ceph CSI secrets
Successfully configured Ceph CSI secrets
Importing Ceph CSI secrets into MicroK8s
secret/rook-ceph-mon created
configmap/rook-ceph-mon-endpoints created
secret/rook-csi-rbd-node created
secret/rook-csi-rbd-provisioner created
storageclass.storage.k8s.io/ceph-rbd created
Importing external Ceph cluster
NAME: rook-ceph-external
LAST DEPLOYED: Wed Oct 25 22:34:47 2023
NAMESPACE: rook-ceph-external
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Ceph Cluster has been installed. Check its status by running:
  kubectl --namespace rook-ceph-external get cephcluster

NAME                 DATADIRHOSTPATH   MONCOUNT   AGE   PHASE       MESSAGE                          HEALTH      EXTERNAL   FSID
rook-ceph-external   /var/lib/rook     3          98s   Connected   Cluster connected successfully   HEALTH_OK   true       cbc60080-71d6-450b-b660-a72313d89084

Visit <https://rook.io/docs/rook/latest/CRDs/ceph-cluster-crd/> for more information about the Ceph CRD.

Important Notes:

- You can only deploy a single cluster per namespace
- If you wish to delete this cluster and start fresh, you will also have to wipe the OSD disks using `sfdisk`

=================================================

Successfully imported external Ceph cluster. You can now use the following storageclass
to provision PersistentVolumes using Ceph CSI:

NAME                          PROVISIONER                  RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
microk8s-hostpath (default)   microk8s.io/hostpath         Delete          WaitForFirstConsumer   false                  2d
ceph-rbd                      rook-ceph.rbd.csi.ceph.com   Delete          Immediate              true                   2s

<https://microk8s.io/docs/how-to-ceph>

## what is the rbd module for

There are three CSI drivers integrated with Rook that will enable different scenarios: RBD: This block storage driver is optimized for RWO pod access where only one pod may access the storage. More information. CephFS: This file storage driver allows for RWX with one or more pods accessing the same storage.

## ceph storage is enabled then enable minio to use it

<https://microk8s.io/docs/addon-minio>
kubectl get sc  
NAME                          PROVISIONER                  RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
microk8s-hostpath (default)   microk8s.io/hostpath         Delete          WaitForFirstConsumer   false                  2d
ceph-rbd                      rook-ceph.rbd.csi.ceph.com   Delete          Immediate              true                   3m19s

## START HERE

<https://microk8s.io/docs/addon-minio>

Enable
For single-node development clusters, enable the MinIO add-on with a single command:

sudo microk8s enable minio
For a more advanced use-case (see sudo microk8s enable minio:-h for a list of all supported arguments), that deploys a MinIO tenant with 300GB storage capacity using the ceph-xfs storage class:

ssh brent@reports53

sudo microk8s enable minio -c 300Gi -s ceph-xfs

## THEN

<https://thedatabaseme.de/2022/03/20/i-do-it-on-my-own-then-self-hosted-s3-object-storage-with-minio-and-docker/>
<https://thedatabaseme.de/2022/03/26/backup-to-s3-configure-zalando-postgres-operator-backup-with-wal-g/>
