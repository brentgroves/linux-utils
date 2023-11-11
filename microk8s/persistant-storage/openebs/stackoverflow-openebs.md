# questions that are close
https://stackoverflow.com/questions/67814339/how-do-you-install-mayastor-for-openebs-with-microk8s-to-use-as-pv-sc
https://discuss.kubernetes.io/t/addon-openebs-mayastor-clustered-storage/19451/5
https://openebs.io/blog/repeatable-openebs-mayastor-deployments-and-benchmarks
https://microk8s.io/docs/addon-openebs
https://github.com/balchua/do-microk8s/blob/master/docs/openebs.md
sudo cat /etc/iscsi/initiatorname.iscsi
sudo cat /etc/iscsi/initiatorname.iscsi | grep InitiatorName
sudo systemctl is-enabled iscsid | grep enabled

# remove microk8s
microk8s stop
sudo snap remove microk8s --purge
snap saved
snap forget 1
sudo reboot

I have tried all sorts of things to get OpenEBS to work on microk8s without much success. So rather than give up completely I thought I would detail one of my failed attempts and see if anyone could figure out what I am doing wrong. Thanks in advance for any help you can give me :-)  

**Successful Attempt**  
Here is the results of following the steps posted on at https://microk8s.io/docs/addon-openebs

**VM Setup:**  
3 VM running Ubuntu 22.04 with 16GB ram on a vSphere hypervisor. I have used these same VM to create a 3 node microk8s cluster with good success in the past.  
**Microk8s removal:**  
removed microk8s on all 3 nodes.  
```
microk8s stop  
`sudo snap remove microk8s --purge`  
sudo reboot
```
**Microk8s fresh install:**  
https://microk8s.io/docs/setting-snap-channel  
snap info microk8s  
latest/stable:         v1.26.0  2022-12-17 (4390) 176MB classic  
**On all 3 nodes:**  
```
sudo snap install microk8s --classic --channel=1.26/stable  
sudo usermod -a -G microk8s $USER  
sudo chown -f -R $USER ~/.kube  
newgrp microk8s  
sudo reboot  
```
**verify everything is ok**  
```
microk8s status  
microk8s inspect  
**Do what inspect tells you to do:**  
WARNING:  IPtables FORWARD policy is DROP. Consider enabling traffic forwarding with: sudo iptables -P FORWARD ACCEPT 
The change can be made persistent with: sudo apt-get install iptables-persistent  
sudo iptables -S  
sudo iptables-legacy -S  
sudo iptables -P FORWARD ACCEPT  
sudo apt-get install iptables-persistent  
sudo systemctl is-enabled netfilter-persistent.service  
sudo reboot  
microk8s inspect  
```
still get the IPtable FORWARD warning on 2 of the 3 nodes.  
hopefully it is not that important.  
ping all the ip addresses in cluster from every node.  

**Followed the directions at https://openebs.io/docs/user-guides/jiva/jiva-prerequisites**  
```
sudo apt install open-iscsi
sudo systemctl enable --now iscsid
modprobe iscsi_tcp
echo iscsi_tcp >/etc/modules-load.d/iscsi-tcp.conf
sudo systemctl status iscsid.service
cat /var/snap/microk8s/common/addons/community/addons/openebs/enable

```

**Followed the directions at https://microk8s.io/docs/addon-openebs**  
**step 1:**  
```
microk8s enable community
microk8s enable openebs

Infer repository community for addon openebs
Infer repository core for addon dns
Enabling DNS
Using host configuration from /run/systemd/resolve/resolv.conf
Applying manifest
serviceaccount/coredns created
configmap/coredns created
deployment.apps/coredns created
service/kube-dns created
clusterrole.rbac.authorization.k8s.io/coredns created
clusterrolebinding.rbac.authorization.k8s.io/coredns created
Restarting kubelet
DNS is enabled
Infer repository core for addon helm3
Addon core/helm3 is already enabled
"openebs" already exists with the same configuration, skipping
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "openebs" chart repository
Update Complete. ⎈Happy Helming!⎈
NAME: openebs
LAST DEPLOYED: Thu Jan 12 09:49:29 2023
NAMESPACE: openebs
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Successfully installed OpenEBS.

Check the status by running: kubectl get pods -n openebs

The default values will install NDM and enable OpenEBS hostpath and device
storage engines along with their default StorageClasses. Use `kubectl get sc`
to see the list of installed OpenEBS StorageClasses.

**Note**: If you are upgrading from the older helm chart that was using cStor
and Jiva (non-csi) volumes, you will have to run the following command to include
the older provisioners:

helm upgrade openebs openebs/openebs \
	--namespace openebs \
	--set legacy.enabled=true \
	--reuse-values

For other engines, you will need to perform a few more additional steps to
enable the engine, configure the engines (e.g. creating pools) and create 
StorageClasses. 

For example, cStor can be enabled using commands like:

helm upgrade openebs openebs/openebs \
	--namespace openebs \
	--set cstor.enabled=true \
	--reuse-values

For more information, 
- view the online documentation at https://openebs.io/docs or
- connect with an active community on Kubernetes slack #openebs channel.
OpenEBS is installed


-----------------------

When using OpenEBS with a single node MicroK8s, it is recommended to use the openebs-hostpath StorageClass
An example of creating a PersistentVolumeClaim utilizing the openebs-hostpath StorageClass


kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: local-hostpath-pvc
spec:
  storageClassName: openebs-hostpath
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5G



-----------------------

If you are planning to use OpenEBS with multi nodes, you can use the openebs-jiva-csi-default StorageClass.
An example of creating a PersistentVolumeClaim utilizing the openebs-jiva-csi-default StorageClass


kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: jiva-volume-claim
spec:
  storageClassName: openebs-jiva-csi-default
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5G

```
**step 2:**  
```
check status:
kubectl get pods -n openebs
NAME                                             READY   STATUS    RESTARTS   AGE
openebs-ndm-s5ztf                                1/1     Running   0          8m27s
openebs-jiva-operator-594fdd69b9-j2mw4           1/1     Running   0          8m27s
openebs-ndm-operator-74fc47c6cc-qh799            1/1     Running   0          8m27s
openebs-cstor-admission-server-f5d57f788-zqp4l   1/1     Running   0          8m27s
openebs-cstor-cspc-operator-7dd775b4b8-c7x6w     1/1     Running   0          8m27s
openebs-cstor-cvc-operator-7946b467f5-m965n      1/1     Running   0          8m27s
openebs-localpv-provisioner-99449bb55-kpzmt      1/1     Running   0          8m25s
openebs-cstor-csi-node-f6d2n                     2/2     Running   0          8m21s
openebs-jiva-csi-node-5rv54                      3/3     Running   0          8m26s
openebs-cstor-csi-controller-0                   6/6     Running   0          8m27s
openebs-jiva-csi-controller-0                    5/5     Running   0          8m27s

```
**step 3:**  
```
verify storage class was installed
kubectl get sc
NAME                       PROVISIONER           RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
openebs-hostpath           openebs.io/local      Delete          WaitForFirstConsumer   false                  12m
openebs-jiva-csi-default   jiva.csi.openebs.io   Delete          Immediate              true                   12m
openebs-device             openebs.io/local      Delete          WaitForFirstConsumer   false                  12m
```
**step 3:**  
```
create a persistent volume
kubectl apply -f openebs-hostpath.yaml
kubectl describe pv local-hostpath-pvc
```
microk8s enable dns  
microk8s enable helm3  
thought we might need rbac so I enabled that also.  
microk8s enable rbac  
**Created 3 node cluster.**  
**step 3:**  
```
```
from main node.  
sudo microk8s add-node  
go to 2nd node.  
microk8s join 10.1.0.116:25000/0c902af525c13fbfb5e7c37cff29b29a/acf13be17a96  
from main node.  
sudo microk8s add-node  
go to 3rd node.  
microk8s join 10.1.0.116:25000/36134181872079c649bed48d969a006d/acf13be17a96  
microk8s status  
```
**enable the mayastor add-on:**
```  
from main node.  
sudo microk8s enable core/mayastor --default-pool-size 20G  
go to  2nd node.  
sudo microk8s enable core/mayastor --default-pool-size 20G  
Addon core/mayastor is already enabled  
go to 3rd node.  
sudo microk8s enable core/mayastor --default-pool-size 20G  
Addon core/mayastor is already enabled  
```
**Wait for the mayastor control plane and data plane pods to come up:**  
```
sudo microk8s.kubectl get pod -n mayastor
NAME                                     READY   STATUS              RESTARTS   AGE
mayastor-csi-962jf                       0/2     ContainerCreating   0          2m6s
mayastor-csi-l4zxx                       0/2     ContainerCreating   0          2m5s
mayastor-8pcc4                           0/1     Init:0/3            0          2m6s
msp-operator-74ff9cf5d5-jvxqb            0/1     Init:0/2            0          2m5s
mayastor-lt8qq                           0/1     Init:0/3            0          2m5s
etcd-operator-mayastor-65f9967f5-mpkrw   0/1     ContainerCreating   0          2m5s
mayastor-csi-6wb7x                       0/2     ContainerCreating   0          2m5s
core-agents-55d76bb877-8nffd             0/1     Init:0/1            0          2m5s
csi-controller-54ccfcfbcc-m94b7          0/3     Init:0/1            0          2m5s
mayastor-9q4gl                           0/1     Init:0/3            0          2m5s
rest-77d69fb479-qsvng                    0/1     Init:0/2            0          2m5s

# Still waiting
sudo microk8s.kubectl get pod -n mayastor
NAME                                     READY   STATUS     RESTARTS   AGE
mayastor-8pcc4                           0/1     Init:0/3   0          32m
msp-operator-74ff9cf5d5-jvxqb            0/1     Init:0/2   0          32m
mayastor-lt8qq                           0/1     Init:0/3   0          32m
core-agents-55d76bb877-8nffd             0/1     Init:0/1   0          32m
csi-controller-54ccfcfbcc-m94b7          0/3     Init:0/1   0          32m
mayastor-9q4gl                           0/1     Init:0/3   0          32m
rest-77d69fb479-qsvng                    0/1     Init:0/2   0          32m
mayastor-csi-962jf                       2/2     Running    0          32m
mayastor-csi-l4zxx                       2/2     Running    0          32m
etcd-operator-mayastor-65f9967f5-mpkrw   1/1     Running    1          32m
mayastor-csi-6wb7x                       2/2     Running    0          32m
etcd-6tjf7zb9dh                          0/1     Init:0/1   0          30m
```

**Went to the trouble-shooting section at https://microk8s.io/docs/addon-mayastor**  
```
microk8s.kubectl logs -n mayastor daemonset/mayastor
output was:
Found 3 pods, using pod/mayastor-8pcc4
Defaulted container "mayastor" out of: mayastor, registration-probe (init), etcd-probe (init), initialize-pool (init)
Error from server (BadRequest): container "mayastor" in pod "mayastor-8pcc4" is waiting to start: PodInitializing
```
