
<https://github.com/openebs/mayastor>
This is a very active repo the latest version is 2.4.0
<https://microk8s.io/docs/addon-mayastor>
This documentation page describes the Mayastor addon v2.0.0, available in MicroK8s 1.27 or newer

HugePages must be enabled. Mayastor requires at least 1024 4MB HugePages.
sudo sysctl vm.nr_hugepages=1048
echo 'vm.nr_hugepages=1048' | sudo tee -a /etc/sysctl.conf
cat /etc/sysctl.conf
grep HugePages /proc/meminfo
AnonHugePages:     12288 kB
ShmemHugePages:        0 kB
FileHugePages:         0 kB
HugePages_Total:    1048
HugePages_Free:     1048
HugePages_Rsvd:        0
HugePages_Surp:        0

brent@reports32:~$ egrep "MemTotal|MemFree|Cached" /proc/meminfo
MemTotal:        8024644 kB
MemFree:         2834144 kB
Cached:          2090252 kB
SwapCached:            0 kB

sudo apt install linux-modules-extra-$(uname -r)

sudo modprobe nvme_tcp
echo 'nvme-tcp' | sudo tee -a /etc/modules-load.d/microk8s-mayastor.conf
cat /etc/modules-load.d/microk8s-mayastor.conf

**update hosts file**
sudo vi /etc/hosts

**Created 4 node cluster.**  

Enable the Mayastor addon:

sudo microk8s enable core/mayastor --default-pool-size 40G

 brent@reports51  ~  sudo microk8s enable core/mayastor --default-pool-size 40G
[sudo] password for brent:
Checking for HugePages (>= 1024)...
Checking for HugePages (>= 1024)... OK
Checking for nvme_tcp module...
Checking for nvme_tcp module... OK
Checking for addon core/dns...
Checking for addon core/dns... OK
Checking for addon core/helm3...
Checking for addon core/helm3... OK
namespace/mayastor created
Default image size set to 40G
Getting updates for unmanaged Helm repositories...
...Successfully got an update from the "<https://raw.githubusercontent.com/canonical/etcd-operator/master/chart>" chart repository
...Successfully got an update from the "<https://github.com/canonical/mayastor-extensions/releases/download/v2.0.0-microk8s-1b>" chart repository
Saving 2 charts
Downloading etcd-operator from repo <https://raw.githubusercontent.com/canonical/etcd-operator/master/chart>
Downloading mayastor from repo <https://github.com/canonical/mayastor-extensions/releases/download/v2.0.0-microk8s-1b>
Deleting outdated charts
NAME: mayastor
LAST DEPLOYED: Fri Sep 29 23:58:09 2023
NAMESPACE: mayastor
STATUS: deployed
REVISION: 1
TEST SUITE: None

=============================================================

Mayastor has been installed and will be available shortly.

Mayastor will run for all nodes in your MicroK8s cluster by default. Use the
'microk8s.io/mayastor=disable' label to disable any node. For example:

    microk8s.kubectl label node reports51 microk8s.io/mayastor=disable

## Wait for the mayastor control plane and data plane pods to come up

 brent@reports51  ~  microk8s kubectl get pod -n mayastor

NAME                                          READY   STATUS    RESTARTS   AGE
etcd-operator-mayastor-6879d6b7b9-z588h       1/1     Running   0          2m
mayastor-csi-node-k2c4g                       2/2     Running   0          2m
mayastor-csi-node-vbd79                       2/2     Running   0          2m
mayastor-csi-node-8wl58                       2/2     Running   0          2m
mayastor-csi-node-gljcb                       2/2     Running   0          2m
etcd-sjl9fzkcs8                               1/1     Running   0          115s
mayastor-agent-core-7d6c88c8bf-mpmmm          1/1     Running   0          2m
mayastor-api-rest-84d867b977-ppvst            1/1     Running   0          2m
mayastor-operator-diskpool-566bd95944-ktxn4   1/1     Running   0          2m
etcd-ndljd6d4v8                               1/1     Running   0          90s
mayastor-io-engine-q5vgt                      1/1     Running   0          2m
mayastor-io-engine-6hqs8                      1/1     Running   0          2m
mayastor-io-engine-89s9f                      1/1     Running   0          2m
mayastor-io-engine-d6p9v                      1/1     Running   0          2m
mayastor-csi-controller-f8b874bd8-5n7mc       3/3     Running   0          2m
etcd-4rjxnpnskd                               1/1     Running   0          57s

The mayastor addon will automatically create one DiskPool per node in the MicroK8s cluster. This pool is backed by a sparse image file. Refer to the Mayastor documentation for information on using existing block devices.

Verify that all diskpools are up and running with:

 brent@reports51  ~  microk8s kubectl get diskpool -n mayastor

NAME                      NODE        STATUS   CAPACITY      USED   AVAILABLE
microk8s-reports54-pool   reports54   Online   42903535616   0      42903535616
microk8s-reports53-pool   reports53   Online   42903535616   0      42903535616
microk8s-reports51-pool   reports51   Online   42903535616   0      42903535616
microk8s-reports52-pool   reports52   Online   42903535616   0      42903535616

A sparse image is a type of disk image file used on macOS that grows in size as the user adds data to the image, taking up only as much disk space as stored

Mayastor is now deployed!

Deploy a test workload
The mayastor addon creates two storage classes:

mayastor: This can be used in single-node clusters.
mayastor-3: This requires at least 3 cluster nodes, as it replicates volume data across 3 storage pools, ensuring data redundancy.
Let’s create a simple pod that uses the mayastor storage class:

# pod-with-pvc.yaml

---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc
spec:
  storageClassName: mayastor
  accessModes: [ReadWriteOnce]
  resources: { requests: { storage: 5Gi } }
---

apiVersion: v1
kind: Pod
metadata:
  name: test-nginx
spec:
  volumes:
    - name: pvc
      persistentVolumeClaim:
        claimName: test-pvc
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
      volumeMounts:
        - name: pvc
          mountPath: /usr/share/nginx/html

brent@reports51  ~  microk8s kubectl create -f pod-with-pvc.yaml
persistentvolumeclaim/test-pvc created
pod/test-nginx created

# Verify that our PVC and pod have been created with

microk8s kubectl get pod,pvc

NAME             READY   STATUS    RESTARTS   AGE
pod/test-nginx   1/1     Running   0          45s
  ls -alh /var/snap/microk8s/common/mayastor/data
  -rw-r--r-- 1 root root  40G Sep 29 23:59 microk8s.img

## Where is the image file

each node has an image file like this:

ls -alh /var/snap/microk8s/common/mayastor/data
-rw-r--r-- 1 root root  40G Sep 29 23:59 microk8s.img

## Dynamic Storage Summary

Flawless
