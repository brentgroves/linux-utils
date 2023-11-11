https://github.com/openebs/openebs
sudo mkdir -p /var/openebs
sudo chmod 777 /var/openebs
sudo snap install microk8s --classic --channel=1.26/edge
microk8s enable community
microk8s enable openebs
kubectl get pods -n openebs
kubectl get all -n openebs
kubectl get all -n openebs
kubectl logs -n openebs daemonset.apps/openebs-ndm
kubectl logs -n openebs daemonset.apps/openebs-jiva-csi-node

pushd ~/src/linux-utils/microk8s/openebs/usage/jiva
kubectl apply -f busybox-jiva-pvc.yaml 

Error from server (InternalError): error when creating "openebs-hostpath.yaml": Internal error occurred: failed calling webhook "admission-webhook.cstor.openebs.io": failed to call webhook: Post "https://openebs-cstor-admission-server.openebs.svc:443/validate?timeout=5s": context deadline exceeded
https://github.com/openebs/openebs/issues/3046#issuecomment-892412691
export EDITOR=/usr/local/bin/nvim

kubectl edit validatingwebhookconfiguration openebs-cstor-validation-webhook
failurePolicy: Ignore

kubectl apply -f busybox-jiva-pvc.yaml 

kubectl describe pvc busybox-jiva-pvc

Name:          busybox-jiva-pvc
Namespace:     default
StorageClass:  openebs-jiva-csi-default
Status:        Pending
Volume:        
Labels:        <none>
Annotations:   volume.beta.kubernetes.io/storage-provisioner: jiva.csi.openebs.io
               volume.kubernetes.io/storage-provisioner: jiva.csi.openebs.io
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      
Access Modes:  
VolumeMode:    Filesystem
Used By:       <none>
Events:
  Type    Reason                Age                From                                                                                    Message
  ----    ------                ----               ----                                                                                    -------
  Normal  Provisioning          28s                jiva.csi.openebs.io_openebs-jiva-csi-controller-0_304b85bd-45f4-4025-81db-0b92d40c6921  External provisioner is provisioning volume for claim "default/busybox-jiva-pvc"
  Normal  ExternalProvisioning  14s (x3 over 28s)  persistentvolume-controller                                                             waiting for a volume to be created, either by external provisioner "jiva.csi.openebs.io" or manually created by system administrator


kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                      STORAGECLASS               REASON   AGE
pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0   5G         RWO            Delete           Bound    default/busybox-jiva-pvc   openebs-jiva-csi-default            93s

pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0


kubectl get jivavolume pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0 -n openebs
NAME                                       REPLICACOUNT   PHASE     STATUS
pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0                  Syncing   RO


NAME                                                                  READY   STATUS      RESTARTS        AGE
pod/openebs-ndm-rkgdv                                                 1/1     Running     0               24m
pod/openebs-ndm-48mzz                                                 1/1     Running     1 (22m ago)     24m
pod/openebs-cstor-cvc-operator-7946b467f5-qlggk                       1/1     Running     1               24m
pod/openebs-cstor-cspc-operator-7dd775b4b8-b8fpn                      1/1     Running     0               24m
pod/openebs-ndm-7448r                                                 1/1     Running     0               24m
pod/openebs-jiva-operator-594fdd69b9-jbzpg                            1/1     Running     2 (22m ago)     24m
pod/openebs-cstor-csi-node-xpgmx                                      2/2     Running     0               24m
pod/openebs-cstor-csi-node-54xq2                                      2/2     Running     0               24m
pod/openebs-cstor-csi-node-lrd44                                      2/2     Running     0               24m
pod/openebs-jiva-csi-node-x8g8t                                       3/3     Running     0               24m
pod/openebs-jiva-csi-node-q6vpt                                       3/3     Running     0               24m
pod/openebs-cstor-admission-server-f5d57f788-g7kjw                    1/1     Running     5               24m
pod/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-rep-0               0/1     Pending     0               8m12s
pod/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-rep-1               0/1     Pending     0               8m5s
pod/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-rep-2               0/1     Pending     0               7m59s
pod/openebs-jiva-csi-controller-0                                     5/5     Running     1 (6m50s ago)   24m
pod/openebs-ndm-operator-74fc47c6cc-4kzwr                             1/1     Running     1 (23m ago)     24m
pod/openebs-cstor-csi-controller-0                                    6/6     Running     2               24m
pod/openebs-jiva-csi-node-b2d78                                       3/3     Running     1 (6m36s ago)   24m
pod/init-pvc-d3c51faf-9fec-4033-8087-4c28c3c26e9b                     0/1     Completed   0               7m56s
pod/init-pvc-a0fb6ca5-dc6b-4941-bcfc-e5a2f69bb65f                     0/1     Completed   0               8m3s
pod/init-pvc-e7534415-c0c0-49c8-ae41-c4a92bd806a5                     0/1     Completed   0               8m10s
pod/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-ctrl-77f48b5p4pxj   2/2     Running     0               8m18s
pod/openebs-localpv-provisioner-99449bb55-dnlcq                       1/1     Running     6 (4m19s ago)   24m

NAME                                                             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
service/openebs-cstor-cvc-operator-svc                           ClusterIP   10.152.183.19    <none>        5757/TCP                     25m
service/openebs-cstor-admission-server                           ClusterIP   10.152.183.191   <none>        443/TCP                      19m
service/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-ctrl-svc   ClusterIP   10.152.183.224   <none>        3260/TCP,9501/TCP,9500/TCP   8m22s

NAME                                    DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/openebs-ndm              3         3         3       3            3           <none>          25m
daemonset.apps/openebs-cstor-csi-node   3         3         3       3            3           <none>          25m
daemonset.apps/openebs-jiva-csi-node    3         3         3       3            3           <none>          25m

NAME                                                                 READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/openebs-jiva-operator                                1/1     1            1           25m
deployment.apps/openebs-cstor-cvc-operator                           1/1     1            1           25m
deployment.apps/openebs-ndm-operator                                 1/1     1            1           25m
deployment.apps/openebs-cstor-cspc-operator                          1/1     1            1           25m
deployment.apps/openebs-cstor-admission-server                       1/1     1            1           25m
deployment.apps/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-ctrl   1/1     1            1           8m19s
deployment.apps/openebs-localpv-provisioner                          1/1     1            1           25m

NAME                                                                            DESIRED   CURRENT   READY   AGE
replicaset.apps/openebs-jiva-operator-594fdd69b9                                1         1         1       24m
replicaset.apps/openebs-cstor-cvc-operator-7946b467f5                           1         1         1       24m
replicaset.apps/openebs-ndm-operator-74fc47c6cc                                 1         1         1       24m
replicaset.apps/openebs-cstor-cspc-operator-7dd775b4b8                          1         1         1       24m
replicaset.apps/openebs-cstor-admission-server-f5d57f788                        1         1         1       24m
replicaset.apps/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-ctrl-77f48b56d7   1         1         1       8m19s
replicaset.apps/openebs-localpv-provisioner-99449bb55                           1         1         1       24m

NAME                                                                 READY   AGE
statefulset.apps/openebs-cstor-csi-controller                        1/1     25m
statefulset.apps/openebs-jiva-csi-controller                         1/1     25m
statefulset.apps/pvc-a69fbcad-b3d9-4019-a3a7-9695bdeef7f0-jiva-rep   0/3     8m19s



