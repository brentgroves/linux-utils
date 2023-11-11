https://microk8s.io/docs/nfs
https://ubuntu.com/server/docs/service-nfs
https://linuxize.com/post/how-to-install-and-configure-an-nfs-server-on-ubuntu-20-04/
https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-20-04


# install nfs server
sudo apt-get install nfs-kernel-server

# Create a directory to be used for NFS:

sudo mkdir -p /srv/nfs
sudo chown nobody:nogroup /srv/nfs
sudo chmod 0777 /srv/nfs

# Edit the /etc/exports file. 
Make sure that the IP addresses of all your MicroK8s nodes are able to mount this share. For example, to allow all IP addresses in the 10.0.0.0/24 subnet:

sudo mv /etc/exports /etc/exports.bak
echo '/srv/nfs 10.1.0.0/22(rw,sync,no_subtree_check)' | sudo tee /etc/exports

# Finally, restart the NFS server:
sudo systemctl restart nfs-kernel-server

# To view the current active exports and their state, use:

sudo exportfs -v

# https://www.thegeeksearch.com/how-to-find-nfs-version/
/usr/sbin/rpcinfo -p

# Install the CSI driver for NFS
We will use the upstream NFS CSI driver. First, we will deploy the NFS provisioner using the official Helm chart.

Enable the Helm3 addon (if not already enabled) and add the repository for the NFS CSI driver:

microk8s enable helm3
microk8s helm3 repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
microk8s helm3 repo update

microk8s helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs \
    --namespace kube-system \
    --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet

# After deploying the Helm chart, wait for the CSI controller and node pods to come up using the following kubectl command …

microk8s kubectl wait pod --selector app.kubernetes.io/name=csi-driver-nfs --for condition=ready --namespace kube-system

# At this point, you should also be able to list the available CSI drivers in your Kubernetes cluster …

microk8s kubectl get csidrivers
… and see nfs.csi.k8s.io in the list:

NAME             ATTACHREQUIRED   PODINFOONMOUNT   STORAGECAPACITY   TOKENREQUESTS   REQUIRESREPUBLISH   MODES        AGE
nfs.csi.k8s.io   false   


# Create a StorageClass for NFS
Next, we will need to create a Kubernetes Storage Class that uses the nfs.csi.k8s.io CSI driver. Assuming you have configured an NFS share /srv/nfs and the address of your NFS server is 10.1.0.118/22, create the following file:

# sc-nfs.yaml
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: nfs-csi
provisioner: nfs.csi.k8s.io
parameters:
  server: 10.0.0.42
  share: /srv/nfs
reclaimPolicy: Delete
volumeBindingMode: Immediate
mountOptions:
  - hard
  - nfsvers=4.1

# Note: 
The last line of the above YAML indicates a specific version of NFS. This should match the version of the NFS server being used - if you are using an existing service please check which version it uses and adjust accordingly.

pushd ~/src/linux-utils/microk8s/nfs
microk8s kubectl apply -f - < sc-nfs.yaml

kubectl get sc

# Create a new PVC
The final step is to create a new PersistentVolumeClaim using the nfs-csi storage class. This is as simple as specifying storageClassName: nfs-csi in the PVC definition, for example:

# pvc-nfs.yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  storageClassName: nfs-csi
  accessModes: [ReadWriteOnce]
  resources:
    requests:
      storage: 5Gi

microk8s kubectl apply -f - < pvc-nfs.yaml

# If everything has been configured correctly, you should be able to check the PVC…

microk8s kubectl describe pvc my-pvc

https://ubuntu.com/server/docs/service-nfs
sudo systemctl status nfs-kernel-server
Use nfsstat -m it will display all the nfs mounted filesystem and theirs properties.

On Ubuntu 20.04, NFS version 2 is disabled. Versions 3 and 4 are enabled. You can verify that by running the following cat command :

sudo cat /proc/fs/nfsd/versions
Copy
-2 +3 +4 +4.1 +4.2
Copy
NFSv2 is pretty old now, and there is no reason to enable it.

NFS server configuration is defined in /etc/default/nfs-kernel-server and /etc/default/nfs-common files. The default settings are sufficient for most situations.

# https://www.thegeeksearch.com/how-to-find-nfs-version/
/usr/sbin/rpcinfo -p

