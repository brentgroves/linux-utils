https://microk8s.io/docs/addon-openebs
https://github.com/balchua/do-microk8s/blob/master/docs/openebs.md

kubectl get all -n openebs
kubectl logs -n openebs daemonset.apps/openebs-ndm
kubectl logs -n openebs daemonset.apps/openebs-jiva-csi-node


pushd ~/src/linux-utils/microk8s/openebs/usage/jiva
kubectl apply -f busybox-jiva-pvc.yaml 
kubectl describe pvc busybox-jiva-pvc

Name:          busybox-jiva-pvc
Namespace:     default
StorageClass:  openebs-jiva-csi-default
Status:        Bound
Volume:        pvc-134b4ccc-1ec1-498f-88c7-3f7be70b7057
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
  Type     Reason                 Age                   From                                                                                    Message
  ----     ------                 ----                  ----                                                                                    -------
  Normal   ExternalProvisioning   42s (x10 over 2m40s)  persistentvolume-controller                                                             waiting for a volume to be created, either by external provisioner "jiva.csi.openebs.io" or manually created by system administrator
  Warning  ProvisioningFailed     40s (x4 over 2m10s)   jiva.csi.openebs.io_openebs-jiva-csi-controller-0_5f6d8cd0-6077-4d98-90eb-e933fd0359dc  failed to provision volume with StorageClass "openebs-jiva-csi-default": rpc error: code = Internal desc = DeleteVolume: failed to set client, err: {Get "https://10.152.183.1:443/api?timeout=32s": dial tcp 10.152.183.1:443: i/o timeout}
  Normal   Provisioning           40s (x5 over 2m40s)   jiva.csi.openebs.io_openebs-jiva-csi-controller-0_5f6d8cd0-6077-4d98-90eb-e933fd0359dc  External provisioner is provisioning volume for claim "default/busybox-jiva-pvc"
  Normal   ProvisioningSucceeded  40s                   jiva.csi.openebs.io_openebs-jiva-csi-controller-0_5f6d8cd0-6077-4d98-90eb-e933fd0359dc  Successfully provisioned volume pvc-134b4ccc-1ec1-498f-88c7-3f7be70b7057

kubectl get jivavolume pvc-56db0aac-6740-4eda-b00a-8e20c8f73109 -n openebs
https://openebs.io/docs/user-guides/jiva/jiva-launch
kubectl apply -f busybox-jiva-deployment.yaml
NAME                                       REPLICACOUNT   PHASE     STATUS
pvc-134b4ccc-1ec1-498f-88c7-3f7be70b7057                  Syncing   RO

https://www.lakshminp.com/openebs-jiva-quickstart/

https://github.com/openebs/openebs/issues/3046#issuecomment-892412691
kubectl describe deployment busybox-jiva
kubectl get pod
Max retry count exceeded
kubectl describe pod busybox-7c9fb8f969-wfm22
kubectl logs -n openebs -l openebs.io/component-name=openebs-localpv-provisioner
Warning  FailedMount  100s (x4 over 6m51s)  kubelet  MountVolume.MountDevice failed for volume "pvc-c632075e-6897-465d-b8b9-ca8cbe99cb7c" : rpc error: code = FailedPrecondition desc = Max retry count exceeded, volume: {pvc-c632075e-6897-465d-b8b9-ca8cbe99cb7c} is not ready
(base)  brent@reports01  ~/src/linux-utils/microk8s/openebs/usage/jiva 

kubectl describe pv pvc-c632075e-6897-465d-b8b9-ca8cbe99cb7c
says its bound
kubectl delete pod busybox-7c9fb8f969-2bqfd
iscsiadm -m node session

microk8s kubectl exec -it busybox-64f947784d-d9ltf -- sh

df -h

You should see the /my-data directory.

Write a file into the /my-data.

echo "hello" > /my-data/test.txt
/ # ls -l /my-data/test.txt 
-rw-r--r--    1 root     root             6 Mar  6 02:36 /my-data/test.txt
/ # cat /my-data/test.txt 
hello

Verify that it survives a pod deletion.

microk8s kubectl delete po busybox-64f947784d-d9ltf 
pod "busybox-64f947784d-bwmt6" deleted
kubectl get po 
busybox-64f947784d-thg8t
microk8s kubectl exec -it busybox-64f947784d-vgwl8 -- sh
/ # cat /my-data/
lost+found/  test.txt
/ # cat /my-data/
lost+found/  test.txt
/ # cat /my-data/test.txt 
hello
/ # 
kubectl get pv