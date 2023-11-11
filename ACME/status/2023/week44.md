# Father's direction

I love you my son and am enjoying our time together.  Do not be anxious about the plan I have for you today. Please trust me because I am in control of every situation and am helping you to believe in the things I have taught you through the troubles I am allowing you to go through.

## Current State

- k8s training cluster with report team users created.
- Operators for MySQL InnoDB Cluster with backup working.
- Zolando Postgres Operator working backup to S3 storage in progress.
- Single node Ceph Storage Cluster linked Reports5 K8s dev cluster.
- Minio S3 compatible storage running on K8s dev cluster using host-path storage.
Next:
- Test Minio with Ceph-XFS storage class.
- Attempt to use Ceph rather than Host-path storage as default storage class on K8s dev cluster.

## What is Ceph Storage

**[What is Ceph Storage](https://en.wikipedia.org/wiki/Ceph_(software))**

Ceph is a free and open-source software-defined storage platform that provides object storage, block storage, and file storage built on a common distributed cluster foundation.

**[Manage vast amounts of data](https://docs.ceph.com/en/reef/))**

Ceph is highly reliable, easy to manage, and free. The power of Ceph can transform your company’s IT infrastructure and your ability to manage vast amounts of data. To try Ceph, see our Getting Started guides. To learn more about Ceph, see our Architecture section.

Why do we need it? To install Minio S3 compatible Cloud Object Storage which will be used to store report excel files.

CEPH OBJECT STORE
RESTful Interface
S3- and Swift-compliant APIs
S3-style subdomains
Unified S3/Swift namespace
User management
Usage tracking
Striped objects
Cloud solution integration
Multi-site deployment
Multi-site replication

## How to create a virtual disk?

Add virtual disks
The following loop creates three files under /mnt that will back respective loop devices. Each Virtual disk is then added as an OSD to Ceph:

```bash
pushd ~/src/linux-utils/ceph-storage
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
  # the block-devices plug doesn't allow accessing /dev/loopX devices so we make those same devices available under alternate names (/dev/sdiY)
  minor="${loop_dev##/dev/loop}"
  # The system call mknod() creates a filesystem node (file, device special file, or named pipe) named pathname, with attributes specified by mode and dev.
  # The mknod command makes a directory entry and corresponding i-node for a special file. The first parameter is the name of the entry device. The b flag indicates that the special file. The last two parameters of the first form are numbers that specify the Major device and the Minor device. The Major device number helps the operating system find the device driver code. Major device number 7 is for loop devices. The Minor device number is the unit drive or line number that might be either decimal or octal.  

  sudo mknod -m 0660 "/dev/sdi${l}" b 7 "${minor}"
  sudo microceph disk add --wipe "/dev/sdi${l}"
done

chmod +x add3vd.sh
./add3vd.sh
```

## What is a **[loop device](https://en.wikipedia.org/wiki/Loop_device)**?

In Unix-like operating systems, a loop device, vnd (virtual node disk), or lofi (loop file interface) is a pseudo-device that makes a computer file accessible as a block device. Before use, a loop device must be connected to an extent file in the file system.

Why is it important?  Ceph storage uses a loop device for creating virtual disks.

## What is an **[extent file system](https://www.easytechjunkie.com/what-is-an-extent-file-system.htm)**?

An extent file system (EFS) is a method of managing files and memory on a computer hard drive or other physical storage device that uses a series of contiguous areas of memory to store information instead of using smaller, more scattered units known as blocks.

An extent file system groups blocks together on a disk if they are contiguous, meaning they are all physically next to one another on a disk. This collection of blocks is known as an extent.

The advantage of using extents instead of blocks is that large files require less overhead to create and maintain, and the risk of fragmentation is reduced greatly, though not necessarily eliminated.

**[More about extent file system](../../../linux-utils/ceph-storage/microk8s-ceph-storage.md)**

## S3 Coud Object Storage

**[S3](https://aws.amazon.com/s3/)**

Amazon S3 or Amazon Simple Storage Service is a service offered by Amazon Web Services that provides object storage through a web service interface.

What ca we use it for? Backing up postgres databases.
Can we have in-house S3 storage? Yes.
What is Minio?
**[Minio](https://en.wikipedia.org/wiki/MinIO)**
"
MinIO is a High-Performance Object Storage released under GNU Affero General Public License v3.0. It is API compatible with the Amazon S3 cloud storage service. It can handle unstructured data such as photos, videos, log files, backups, and container images with a current maximum supported object size of 50TB.
"
How to setup Minio?
**[Minio Setup](https://thedatabaseme.de/2022/03/20/i-do-it-on-my-own-then-self-hosted-s3-object-storage-with-minio-and-docker/)**
"
"
How to backup Postgres database to S3 bucket?
**[Postgres S3 clone](https://thedatabaseme.de/2022/03/26/backup-to-s3-configure-zalando-postgres-operator-backup-with-wal-g/)**

**[HCI software hypervisor](https://www.youtube.com/watch?v=tVsMen_e6OI)**
Rancher released a next generation open source HCI software hypervisor built on Kubernetes that helps you run virtual machines.

**[HCI for Kubernetes](https://www.suse.com/c/rancher_blog/using-hyperconverged-infrastructure-for-kubernetes/)**

"
Additionally, Harvester provides a comprehensive set of features and capabilities that make it the ideal solution for deploying and managing enterprise applications and services. Among these characteristics, the following stand out:

Built on top of Kubernetes.
Full VM lifecycle management, thanks to KubeVirt.
Support for VM cloud-init templates.
VM live migration support.
VM backup, snapshot and restore capabilities.
Distributed block storage and storage tiering, thanks to Longhorn.
Powerful monitoring and logging since Harvester uses Grafana and Prometheus as its observability backend.
Seamless integration with Rancher, facilitating multicluster deployments as well as deploying and managing VMs and Kubernetes workloads from a centralized dashboard.
"
