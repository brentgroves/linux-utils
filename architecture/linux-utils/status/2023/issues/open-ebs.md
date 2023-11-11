Tried mayo-store on microk8s on ubuntu 22.04 and it did not install correctly.
https://stackoverflow.com/questions/68366456/mongodb-community-kubernetes-operator-and-custom-persistent-volumes
https://microk8s.io/docs/addon-openebs
https://computingforgeeks.com/deploy-and-use-openebs-container-storage-on-kubernetes/
OpenEBS utilizes disks attached to the worker nodes, external mount-points and local host paths on the nodes.
https://github.com/balchua/do-microk8s/blob/master/docs/openebs.md

microk8s jiva-volume-claim

Homepage: https://openebs.io/
From MicroK8s version: 1.21+
Supported arch: amd64, arm64 (1.22+)

OpenEBS, is the most widely deployed and easy to use open-source storage solution for Kubernetes. can be enabled with:

microk8s enable openebs

The addon includes the following StorageClass

openebs-hostpath and
openebs-jiva-default
The openebs-hostpath is recommended when using on a laptop or a single node cluster. Use openebs-jiva-default StorageClass for multi-node cluster.

Note: Using openebs-jiva-default requires to have 3 replicas.

Using OpenEBS is as easy as creating a PersistentVolumeClaim.

