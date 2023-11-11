# questions that are close
https://stackoverflow.com/questions/67814339/how-do-you-install-mayastor-for-openebs-with-microk8s-to-use-as-pv-sc
https://discuss.kubernetes.io/t/addon-openebs-mayastor-clustered-storage/19451/5
https://openebs.io/blog/repeatable-openebs-mayastor-deployments-and-benchmarks
https://microk8s.io/docs/addon-openebs
https://github.com/balchua/do-microk8s/blob/master/docs/openebs.md
# added question here
https://github.com/openebs/openebs/discussions/3603
https://discuss.kubernetes.io/t/how-can-i-get-openebs-jiva-working-in-a-multi-node-microk8s-cluster-using-the-openebs-community-add-on/22696

**tags**
```
openebs,jiva
```
**How can I get OpenEBS jiva working in a multi-node microk8s cluster using the OpenEBS community add-on?**  
I have tried all sorts of things to get OpenEBS jiva to work on microk8s without much success. So rather than give up completely I thought I would detail one of my failed attempts and see if anyone could figure out what I am doing wrong. Thanks in advance for any help you can give me :-)  

**The issue**  
I think the reason openebs-jiva is not working is because the registered replica are less than 3.  

view the cas controller log
```
kubectl logs -f deployment.apps/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl -n openebs

time="2023-01-14T18:11:00Z" level=info msg="Register Replica, Address: 10.1.216.73 UUID: 98af9e7ae85fe048409f434d06fa42c311e74800 Uptime: 18h57m15.023468826s State: closed Type: Backend RevisionCount: 1"
time="2023-01-14T18:11:00Z" level=warning msg="No of yet to be registered replicas are less than 3 , No of registered replicas: 1"
...
```

**Attempt**  
Here is the results of following the steps posted on at https://microk8s.io/docs/addon-openebs as well as the prerequisites found at https://openebs.io/docs/user-guides/installation  
**VM Setup:**  
3 VM running Ubuntu 22.04 with 16GB ram using VMware's vSphere. I have used these same VM to create a 3 node microk8s cluster with good success in the past.  
**Microk8s removal:**  
removed microk8s on all 3 nodes.  
```
microk8s stop  
sudo snap remove microk8s --purge  
sudo reboot
```
**Microk8s fresh install:**  
In this attempt I would like to try the edge channel to see if there is any recent bug fixes that would help jiva to work on microk8s.  
https://microk8s.io/docs/setting-snap-channel  
snap info microk8s  
**On all 3 nodes:**  
```
sudo snap install microk8s --classic --channel=1.26/edge 
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
iptables-legacy -S says FORWARD ACCEPT but iptables -S always reverts back to DROP.  Hopefully it is not that important.  
ping all the ip addresses in cluster from every node.  
The reason I ping all the ip addresses is because of a warning I got about having more than 3 DNS servers configured.  
```
cat /run/systemd/resolve/resolv.conf
nameserver 10.1.2.69
nameserver 10.1.2.70
nameserver 172.10.0.39
# Too many DNS servers configured, the following entries may be ignored.
nameserver 10.30.1.27
search .
```

**Followed the directions at https://openebs.io/docs/user-guides/jiva/jiva-prerequisites**  
Did the following on all 3 nodes:
```

sudo apt install open-iscsi
sudo systemctl enable --now iscsid
sudo modprobe iscsi_tcp
sudo touch /etc/modules-load.d/iscsi-tcp.conf
sudo chmod 666 /etc/modules-load.d/iscsi-tcp.conf
echo iscsi_tcp >/etc/modules-load.d/iscsi-tcp.conf
cat /etc/modules-load.d/iscsi-tcp.conf
sudo reboot
sudo systemctl status iscsid.service

● iscsid.service - iSCSI initiator daemon (iscsid)
     Loaded: loaded (/lib/systemd/system/iscsid.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2023-01-13 15:27:15 EST; 5min ago
TriggeredBy: ● iscsid.socket
       Docs: man:iscsid(8)
    Process: 1374 ExecStartPre=/lib/open-iscsi/startup-checks.sh (code=exited, status=0/SUCCESS)
    Process: 1379 ExecStart=/sbin/iscsid (code=exited, status=0/SUCCESS)
   Main PID: 1383 (iscsid)
      Tasks: 2 (limit: 19118)
     Memory: 5.5M
        CPU: 363ms
     CGroup: /system.slice/iscsid.service
             ├─1382 /sbin/iscsid
             └─1383 /sbin/iscsid

Jan 13 15:27:14 reports01 systemd[1]: Starting iSCSI initiator daemon (iscsid)...
Jan 13 15:27:15 reports01 iscsid[1379]: iSCSI logger with pid=1382 started!
Jan 13 15:27:15 reports01 iscsid[1382]: iSCSI daemon with pid=1383 started!
Jan 13 15:27:15 reports01 systemd[1]: Started iSCSI initiator daemon (iscsid).
```
**Create 3 node cluster.**  
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
**Followed the directions at https://microk8s.io/docs/addon-openebs**  
**step 1:**  
```
microk8s enable community
cat /var/snap/microk8s/common/addons/community/addons/openebs/enable
Thought I would make the storage directories I found in the above file on each node:
sudo mkdir -p /var/openebs/local
sudo mkdir -p /var/openebs/sparse
sudo mkdir -p /var/openebs/ndm # I thought I saw this was created in one of my other attempts
sudo chmod -R 777 /var/openebs
ls -alh /var/openebs

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
Adding argument --cluster-domain to nodes.
Adding argument --cluster-dns to nodes.
Restarting nodes.
DNS is enabled
Infer repository core for addon helm3
Addon core/helm3 is already enabled
"openebs" already exists with the same configuration, skipping
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "openebs-jiva" chart repository
...Successfully got an update from the "openebs" chart repository
Update Complete. ⎈Happy Helming!⎈
NAME: openebs
LAST DEPLOYED: Fri Jan 13 16:03:08 2023
NAMESPACE: openebs
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Successfully installed OpenEBS.

```
**step 2: check status**
```
kubectl get all -n openebs
NAME                                                 READY   STATUS    RESTARTS      AGE
pod/openebs-ndm-8mllj                                1/1     Running   0             47m
pod/openebs-ndm-zjkfs                                1/1     Running   0             47m
pod/openebs-ndm-qz9s7                                1/1     Running   0             47m
pod/openebs-cstor-admission-server-f5d57f788-s86lf   1/1     Running   0             47m
pod/openebs-cstor-csi-node-t7jf5                     2/2     Running   0             47m
pod/openebs-cstor-cspc-operator-7dd775b4b8-7jjwx     1/1     Running   0             47m
pod/openebs-cstor-csi-node-pjbxw                     2/2     Running   0             47m
pod/openebs-cstor-csi-node-k4l2j                     2/2     Running   0             47m
pod/openebs-jiva-csi-node-g42g6                      3/3     Running   0             47m
pod/openebs-cstor-cvc-operator-7946b467f5-pwkgr      1/1     Running   0             47m
pod/openebs-ndm-operator-74fc47c6cc-c74lb            1/1     Running   1 (44m ago)   47m
pod/openebs-jiva-csi-node-kks56                      3/3     Running   1 (44m ago)   47m
pod/openebs-jiva-operator-594fdd69b9-rj2mb           1/1     Running   0             47m
pod/openebs-jiva-csi-controller-0                    5/5     Running   0             47m
pod/openebs-jiva-csi-node-gtnhw                      3/3     Running   0             47m
pod/openebs-cstor-csi-controller-0                   6/6     Running   0             47m
pod/openebs-localpv-provisioner-99449bb55-56csp      1/1     Running   4 (40m ago)   47m

NAME                                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/openebs-cstor-cvc-operator-svc   ClusterIP   10.152.183.134   <none>        5757/TCP   48m
service/openebs-cstor-admission-server   ClusterIP   10.152.183.47    <none>        443/TCP    45m

NAME                                    DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/openebs-ndm              3         3         3       3            3           <none>          48m
daemonset.apps/openebs-cstor-csi-node   3         3         3       3            3           <none>          48m
daemonset.apps/openebs-jiva-csi-node    3         3         3       3            3           <none>          48m

NAME                                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/openebs-cstor-admission-server   1/1     1            1           48m
deployment.apps/openebs-cstor-cspc-operator      1/1     1            1           48m
deployment.apps/openebs-cstor-cvc-operator       1/1     1            1           48m
deployment.apps/openebs-ndm-operator             1/1     1            1           48m
deployment.apps/openebs-jiva-operator            1/1     1            1           48m
deployment.apps/openebs-localpv-provisioner      1/1     1            1           48m

NAME                                                       DESIRED   CURRENT   READY   AGE
replicaset.apps/openebs-cstor-admission-server-f5d57f788   1         1         1       47m
replicaset.apps/openebs-cstor-cspc-operator-7dd775b4b8     1         1         1       47m
replicaset.apps/openebs-cstor-cvc-operator-7946b467f5      1         1         1       47m
replicaset.apps/openebs-ndm-operator-74fc47c6cc            1         1         1       47m
replicaset.apps/openebs-jiva-operator-594fdd69b9           1         1         1       47m
replicaset.apps/openebs-localpv-provisioner-99449bb55      1         1         1       47m

NAME                                            READY   AGE
statefulset.apps/openebs-jiva-csi-controller    1/1     48m
statefulset.apps/openebs-cstor-csi-controller   1/1     48m
```
**Notice some pods,service,deployments,stateful sets don't exist yet**  
I imagine they will be created after a volume claim is created.
```
pod/init-pvc-d3c51faf-9fec-4033-8087-4c28c3c26e9b
pod/init-pvc-a0fb6ca5-dc6b-4941-bcfc-e5a2f69bb65f
pod/init-pvc-e7534415-c0c0-49c8-ae41-c4a92bd806a5
pod/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-ctrl-77f48b5p4pxj
service/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-ctrl-svc 
deployment.apps/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-ctrl
statefulset.apps/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-rep
```
**step 3: verify storage class was installed**  
```
kubectl get sc
NAME                       PROVISIONER           RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
openebs-device             openebs.io/local      Delete          WaitForFirstConsumer   false                  64m
openebs-jiva-csi-default   jiva.csi.openebs.io   Delete          Immediate              true                   64m
openebs-hostpath           openebs.io/local      Delete          WaitForFirstConsumer   false                  64m
```
**step 4: create an openebs-hostpath persistent volume claim**  
But before I do this I will edit validatingwebhookconfiguration so that I won't get the following error:
```
Error from server (InternalError): error when creating "openebs-hostpath.yaml": Internal error occurred: failed calling webhook "admission-webhook.cstor.openebs.io": failed to call webhook: Post "https://openebs-cstor-admission-server.openebs.svc:443/validate?timeout=5s": context deadline exceeded
```
```
references:
https://github.com/openebs/openebs/issues/3046#issuecomment-892412691
https://github.com/canonical/microk8s/issues/3639
```
```
kubectl edit validatingwebhookconfiguration openebs-cstor-validation-webhook
change: failurePolicy: Fail
to: failurePolicy: Ignore
```
```
kubectl apply -f busybox-hostpath-pvc.yaml  
```
busybox-hostpath-pvc.yaml:  
```
kind: PersistentVolumeClaim 
apiVersion: v1
metadata:
  name: busybox-hostpath-pvc
spec:
  storageClassName: openebs-hostpath
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5G
```
```
kubectl describe pvc busybox-hostpath-pvc  

Name:          busybox-hostpath-pvc
Namespace:     default
StorageClass:  openebs-hostpath
Status:        Pending
Volume:        
Labels:        <none>
Annotations:   <none>
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      
Access Modes:  
VolumeMode:    Filesystem
Used By:       <none>
Events:
  Type    Reason                Age                  From                         Message
  ----    ------                ----                 ----                         -------
  Normal  WaitForFirstConsumer  6s (x16 over 3m49s)  persistentvolume-controller  waiting for first consumer to be created before binding
```
```
sudo find /var -name "*.img"
```
Has any additional pods,service,deployments,stateful sets been created.
```
kubectl get all -n openebs
```
looks the same as before.  
**step 5:**  
create a deployment using the openebs-hostpath claim.
```
apiVersion: apps/v1
kind: Deployment
metadata:
 name: busybox-hostpath
 labels:
   app: busybox-hostpath
spec:
 replicas: 1
 strategy:
   type: RollingUpdate
 selector:
   matchLabels:
     app: busybox-hostpath
 template:
   metadata:
     labels:
       app: busybox-hostpath
   spec:
     containers:
     - resources:
          limits:
           cpu: 0.5
       name: busybox
       image: busybox
       command: ['sh', '-c', 'echo Container 1 is Running ; sleep 3600']
       imagePullPolicy: IfNotPresent
       ports:
        - containerPort: 3306
          name: busybox
       volumeMounts:
       - mountPath: /my-data
         name: busybox-hostpath-vol1
     volumes:
      - name: busybox-hostpath-vol1
        persistentVolumeClaim:
         claimName: busybox-hostpath-pvc
```
```
kubectl apply -f  busybox-hostpath-deployment.yaml

kubectl describe deployment busybox-hostpath
Name:                   busybox-hostpath
Namespace:              default
CreationTimestamp:      Fri, 13 Jan 2023 17:32:01 -0500
Labels:                 app=busybox-hostpath
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=busybox-hostpath
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=busybox-hostpath
  Containers:
   busybox:
    Image:      busybox
    Port:       3306/TCP
    Host Port:  0/TCP
    Command:
      sh
      -c
      echo Container 1 is Running ; sleep 3600
    Limits:
      cpu:        500m
    Environment:  <none>
    Mounts:
      /my-data from busybox-hostpath-vol1 (rw)
  Volumes:
   busybox-hostpath-vol1:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  busybox-hostpath-pvc
    ReadOnly:   false
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   busybox-hostpath-77df4698b7 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  3m3s  deployment-controller  Scaled up replica set busybox-hostpath-77df4698b7 to 1

```
was the volume created?
```
kubectl describe pvc busybox-hostpath-pvc  
Name:          busybox-hostpath-pvc
Namespace:     default
StorageClass:  openebs-hostpath
Status:        Bound
Volume:        pvc-b128aa1e-7ca4-4f4c-987a-0731ba443e28
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: openebs.io/local
               volume.kubernetes.io/selected-node: reports02
               volume.kubernetes.io/storage-provisioner: openebs.io/local
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      5G
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       busybox-hostpath-77df4698b7-xsgr9
Events:        <none>

```
**verify volume is working**  
check for a file on all nodes.  
```
sudo find /var -name "*.img"
```
no files yet.
create a file in the /my-data directory.
```

microk8s kubectl exec -it busybox-hostpath-77df4698b7-5zn6h -- sh
df -h
echo "hello world" >/my-data/test.txt
cat /my-data/test.txt 
hello world
exit
```
check for a file on all nodes.
```
tree /var/snap/microk8s/common/var/openebs 
/var/snap/microk8s/common/var/openebs
├── local
│   ├── pvc-a0759d85-cd2d-48b0-ab41-bad44b8b39b8
│   │   ├── log.info
│   │   ├── replica.log
│   │   ├── revision.counter
│   │   ├── volume-head-000.img
│   │   ├── volume-head-000.img.meta
│   │   └── volume.meta
│   └── pvc-b128aa1e-7ca4-4f4c-987a-0731ba443e28
│       └── test.txt
├── ndm
└── sparse
```
delete the pod  
```
kubectl delete pod busybox-hostpath-77df4698b7-5zn6h
```
that deletion took about 20 seconds.
```
kubectl get pods
kubectl describe pvc busybox-hostpath-pvc 
```
Test the new pod that was created.
``` 
microk8s kubectl exec -it busybox-hostpath-77df4698b7-ltwtk -- sh
cat /my-data/test.txt 
hello world
exit
```
**Now test openebs-jiva volume claim**
```
cat <<EOF | microk8s kubectl apply -f -
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: busybox-jiva-pvc
spec:
  storageClassName: openebs-jiva-csi-default
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5G%
EOF
```      
```
kubectl describe pvc busybox-jiva-pvc
Name:          busybox-jiva-pvc
Namespace:     default
StorageClass:  openebs-jiva-csi-default
Status:        Bound
Volume:        pvc-f8d287df-0a77-4958-8e57-da5f81921c9d
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: jiva.csi.openebs.io
               volume.kubernetes.io/storage-provisioner: jiva.csi.openebs.io
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      5G
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       <none>
Events:
  Type    Reason                 Age                From                                                                                    Message
  ----    ------                 ----               ----                                                                                    -------
  Normal  ExternalProvisioning   73s (x2 over 73s)  persistentvolume-controller                                                             waiting for a volume to be created, either by external provisioner "jiva.csi.openebs.io" or manually created by system administrator
  Normal  Provisioning           73s                jiva.csi.openebs.io_openebs-jiva-csi-controller-0_afd2c95f-03a5-4349-b1bc-0e72dd421068  External provisioner is provisioning volume for claim "default/busybox-jiva-pvc"
  Normal  ProvisioningSucceeded  72s                jiva.csi.openebs.io_openebs-jiva-csi-controller-0_afd2c95f-03a5-4349-b1bc-0e72dd421068  Successfully provisioned volume pvc-f8d287df-0a77-4958-8e57-da5f81921c9d
```
Has any additional pods,service,deployments,stateful sets been created.
```
microk8s kubectl exec -it busybox-jiva-5989fdc4d9-5fgl7 -- sh
df -h
echo "hello world" >/my-data/test.txt
cat /my-data/test.txt 
hello world
exit

microk8s kubectl exec -it busybox-jiva-5989fdc4d9-s2tzj -- sh


kubectl get all -n openebs

NAME                                                                  READY   STATUS             RESTARTS        AGE
pod/openebs-ndm-8mllj                                                 1/1     Running            0               133m
pod/openebs-ndm-zjkfs                                                 1/1     Running            0               133m
pod/openebs-ndm-qz9s7                                                 1/1     Running            0               133m
pod/openebs-cstor-admission-server-f5d57f788-s86lf                    1/1     Running            0               133m
pod/openebs-cstor-csi-node-t7jf5                                      2/2     Running            0               133m
pod/openebs-cstor-cspc-operator-7dd775b4b8-7jjwx                      1/1     Running            0               133m
pod/openebs-cstor-csi-node-pjbxw                                      2/2     Running            0               133m
pod/openebs-cstor-csi-node-k4l2j                                      2/2     Running            0               133m
pod/openebs-jiva-csi-node-g42g6                                       3/3     Running            0               133m
pod/openebs-cstor-cvc-operator-7946b467f5-pwkgr                       1/1     Running            0               133m
pod/openebs-ndm-operator-74fc47c6cc-c74lb                             1/1     Running            1 (130m ago)    133m
pod/openebs-jiva-csi-node-kks56                                       3/3     Running            1 (130m ago)    133m
pod/openebs-jiva-operator-594fdd69b9-rj2mb                            1/1     Running            0               133m
pod/openebs-jiva-csi-controller-0                                     5/5     Running            0               133m
pod/openebs-jiva-csi-node-gtnhw                                       3/3     Running            0               133m
pod/openebs-cstor-csi-controller-0                                    6/6     Running            0               133m
pod/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl-68547ffnxtf5   2/2     Running            0               8m20s
pod/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep-0               1/1     Running            2 (4m41s ago)   8m18s
pod/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep-1               1/1     Running            3 (4m3s ago)    8m18s
pod/openebs-localpv-provisioner-99449bb55-56csp                       1/1     Running            7 (3m11s ago)   133m
pod/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep-2               0/1     CrashLoopBackOff   3 (45s ago)     8m17s

NAME                                                             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
service/openebs-cstor-cvc-operator-svc                           ClusterIP   10.152.183.134   <none>        5757/TCP                     134m
service/openebs-cstor-admission-server                           ClusterIP   10.152.183.47    <none>        443/TCP                      131m
service/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl-svc   ClusterIP   10.152.183.123   <none>        3260/TCP,9501/TCP,9500/TCP   8m22s

NAME                                    DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/openebs-ndm              3         3         3       3            3           <none>          134m
daemonset.apps/openebs-cstor-csi-node   3         3         3       3            3           <none>          134m
daemonset.apps/openebs-jiva-csi-node    3         3         3       3            3           <none>          134m

NAME                                                                 READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/openebs-cstor-admission-server                       1/1     1            1           134m
deployment.apps/openebs-cstor-cspc-operator                          1/1     1            1           134m
deployment.apps/openebs-cstor-cvc-operator                           1/1     1            1           134m
deployment.apps/openebs-ndm-operator                                 1/1     1            1           134m
deployment.apps/openebs-jiva-operator                                1/1     1            1           134m
deployment.apps/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl   1/1     1            1           8m20s
deployment.apps/openebs-localpv-provisioner                          1/1     1            1           134m

NAME                                                                            DESIRED   CURRENT   READY   AGE
replicaset.apps/openebs-cstor-admission-server-f5d57f788                        1         1         1       133m
replicaset.apps/openebs-cstor-cspc-operator-7dd775b4b8                          1         1         1       133m
replicaset.apps/openebs-cstor-cvc-operator-7946b467f5                           1         1         1       133m
replicaset.apps/openebs-ndm-operator-74fc47c6cc                                 1         1         1       133m
replicaset.apps/openebs-jiva-operator-594fdd69b9                                1         1         1       133m
replicaset.apps/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl-68547ff44c   1         1         1       8m20s
replicaset.apps/openebs-localpv-provisioner-99449bb55                           1         1         1       133m

NAME                                                                 READY   AGE
statefulset.apps/openebs-jiva-csi-controller                         1/1     134m
statefulset.apps/openebs-cstor-csi-controller                        1/1     134m
statefulset.apps/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep   2/3     8m20s

```
yes they have.  
4 out of 5 pvc jiva pods    
```
pod/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl-68547ffnxtf5   2/2     Running            0               8m20s
pod/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep-0               1/1     Running            2 (4m41s ago)   8m18s
pod/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep-1               1/1     Running            3 (4m3s ago)    8m18s
pod/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep-2               0/1     CrashLoopBackOff   3 (45s ago)     8m17s
```
1 pvc jiva service  
```
service/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl-svc   ClusterIP   10.152.183.123   <none>        3260/TCP,9501/TCP,9500/TCP   8m22s
```
1 pvc jiva deployment  
```
deployment.apps/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl   1/1     1            1           8m20s
```
1 pvc jiva replica-set
```
replicaset.apps/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl-68547ff44c   1         1         1       8m20s
```
2 out of 3 pvc jiva stateful-set
```
statefulset.apps/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep   2/3     8m20s
```
Check the logs  
```
These 2 look ok.
kubectl logs -n openebs daemonset.apps/openebs-jiva-csi-node
kubectl logs -n openebs daemonset.apps/openebs-cstor-csi-node
```
```
This looks questionable:
kubectl logs -n openebs daemonset.apps/openebs-ndm | grep error
I hope these errors mean something to someone:
Found 3 pods, using pod/openebs-ndm-8mllj
E0113 21:04:27.273861       6 osdiskexcludefilter.go:92] unable to configure os disk filter for mountpoint: /etc/hosts, error: could not get device mount attributes, Path/MountPoint not present in mounts file
E0113 21:04:27.274836       6 osdiskexcludefilter.go:92] unable to configure os disk filter for mountpoint: /boot, error: could not get device mount attributes, Path/MountPoint not present in mounts file
E0113 21:04:27.275644       6 osdiskexcludefilter.go:104] unable to configure os disk filter for mountpoint: /, error: could not get device mount attributes, Path/MountPoint not present in mounts file
E0113 21:04:27.276899       6 osdiskexcludefilter.go:104] unable to configure os disk filter for mountpoint: /boot, error: could not get device mount attributes, Path/MountPoint not present in mounts file
E0113 21:04:27.549116       6 usedbyprobe.go:160] error reading spdk signature from device: /dev/sda2, error reading from /dev/sda2: unexpected EOF
E0113 21:04:27.569473       6 smartprobe.go:101] map[errorCheckingConditions:the device type is not supported yet, device type: "unknown"]
E0113 21:04:28.472481       6 usedbyprobe.go:160] error reading spdk signature from device: /dev/loop2, error reading from /dev/loop2: unexpected EOF
E0113 21:04:28.473777       6 smartprobe.go:101] map[errorCheckingConditions:the device type is not supported yet, device type: "unknown"]
E0113 21:04:28.831109       6 usedbyprobe.go:160] error reading spdk signature from device: /dev/loop30, error reading from /dev/loop30: EOF
E0113 21:04:28.833587       6 smartprobe.go:101] map[errorCheckingConditions:the device type is not supported yet, device type: "unknown"]
```
Check the IP address of the pods that show a CrashLoopBackOff again.  
```
kubectl get pods -n openebs -o wide
pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl-68547ffnxtf5   2/2     Running            0               33m    10.1.216.71    reports03   <none>           <none>
pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep-0               1/1     Running            2 (29m ago)     33m    10.1.216.73    reports03   <none>           <none>
openebs-localpv-provisioner-99449bb55-56csp                       1/1     Running            7 (28m ago)     158m   10.1.216.69    reports03   <none>           <none>
pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep-2               0/1     CrashLoopBackOff   6 (3m35s ago)   33m    10.1.197.7     reports02   <none>           <none>
pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-rep-1               0/1     CrashLoopBackOff   6 (34s ago)     33m    10.1.120.198   reports01   <none>           <none>
```
noticed the reports03 node seems to be running ok.  
take a look at the pvc
```
kubectl get pvc 
NAME                   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS               AGE
busybox-hostpath-pvc   Bound    pvc-b128aa1e-7ca4-4f4c-987a-0731ba443e28   5G         RWO            openebs-hostpath           88m
busybox-jiva-pvc       Bound    pvc-f8d287df-0a77-4958-8e57-da5f81921c9d   5G         RWO            openebs-jiva-csi-default   38m

kubectl describe pvc busybox-jiva-pvc
Name:          busybox-jiva-pvc
Namespace:     default
StorageClass:  openebs-jiva-csi-default
Status:        Bound
Volume:        pvc-f8d287df-0a77-4958-8e57-da5f81921c9d
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: jiva.csi.openebs.io
               volume.kubernetes.io/storage-provisioner: jiva.csi.openebs.io
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      5G
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       <none>
Events:        <none>

kubectl get jivavolume pvc-4c622aec-8790-475e-8526-e225e9c4ae2a -n openebs
NAME                                       REPLICACOUNT   PHASE     STATUS
pvc-f8d287df-0a77-4958-8e57-da5f81921c9d                  Syncing   RO
```
view the cas controller log
```
kubectl logs -f deployment.apps/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl -n openebs

time="2023-01-14T18:11:00Z" level=info msg="Register Replica, Address: 10.1.216.73 UUID: 98af9e7ae85fe048409f434d06fa42c311e74800 Uptime: 18h57m15.023468826s State: closed Type: Backend RevisionCount: 1"
time="2023-01-14T18:11:00Z" level=warning msg="No of yet to be registered replicas are less than 3 , No of registered replicas: 1"
...
```


https://blog.mayadata.io/openebs/tips-for-managing-openebs-jiva-volumes
https://www.lakshminp.com/openebs-jiva-quickstart/
https://openebs.io/docs/deprecated/mayactl#mayactl-version
https://vadosware.io/post/kicking-the-tires-on-openebs-for-cluster-storage/

I know this is alot of stuff to take in, but any insights you may have would be greatly appreciated!

**possible solutions**
ISCSI is the connectivity link between application pod and OpenEBS controller pod. If this connection is broken for some reason, the filesystem on the application turns to ReadOnly (RO) mode and often the application pod can be found in CrashLoopBackOff state.

For the recovery steps, please visit the link below. https://docs.openebs.io/docs/next/readonlyvolumes.html