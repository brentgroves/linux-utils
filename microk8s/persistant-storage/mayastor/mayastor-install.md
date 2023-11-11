
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
sudo snap install microk8s --classic --channel=1.26/edge
sudo snap install microk8s --classic --channel=1.26/stable
sudo usermod -a -G microk8s $USER  
sudo chown -f -R $USER ~/.kube  
newgrp microk8s  
sudo reboot  
alias kubectl='microk8s kubectl'

**verify everything is ok**  

```
microk8s status  
microk8s inspect  
```

**update hosts file**
sudo vi /etc/hosts

**if dotfile have not been installed**
alias kubectl='microk8s kubectl'
**Created 3 node cluster.**  

```
@dm1nF0Rm0b3x
from main node.  
sudo microk8s add-node  
microk8s join 10.1.0.116:25000/0c902af525c13fbfb5e7c37cff29b29a/sudo microk8s add-node  
microk8s join 10.1.0.116:25000/36134181872079c649bed48d969a006d/acf13be17a96  
microk8s status  
```

**exit tmux**
ssh brent@reports11

sudo microk8s enable core/mayastor --default-pool-size 20G

sudo microk8s.kubectl get pod -n mayastor

sudo microk8s.kubectl get mayastorpool -n mayastor

NAME               NODE   STATUS   CAPACITY      USED   AVAILABLE
microk8s-m2-pool   m2     Online   21449670656   0      21449670656
microk8s-m1-pool   m1     Online   21449670656   0      21449670656
microk8s-m3-pool   m3     Online   21449670656   0      21449670656

A sparse image is a type of disk image file used on macOS that grows in size as the user adds data to the image, taking up only as much disk space as stored

<https://github.com/canonical/microk8s/issues/3714>
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
microk8s-reports13-pool   reports13   Online   21449670656   0      21449670656
microk8s-reports11-pool   reports11   Online   21449670656   0      21449670656
microk8s-reports12-pool   reports12   Online   21449670656   0      21449670656

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
