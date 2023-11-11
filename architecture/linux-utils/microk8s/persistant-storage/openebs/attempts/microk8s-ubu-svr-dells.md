**How can I get OpenEBS openebs-jiva-csi-default storage class pvc working on 3 node microk8s ubuntu 22.04 server using the OpenEBS community add-on?**  

**Setup**
- 2 dell optiplex 9020 and 1 dell optiplex 7040 with ubuntu 22.04 server installed.
- microk8s 3 node cluster version
snap info microk8s
sudo snap install microk8s --classic --channel=1.26/stable

**The issue**  
I think the reason openebs-jiva is not working is .  

view all logs
```
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
```

**Test openebs-hostpath**  
create a deployment using the openebs-hostpath claim.
```
kubectl apply -f  busybox-hostpath-deployment.yaml

kubectl describe deployment busybox-hostpath
microk8s kubectl exec -it busybox-hostpath-77df4698b7-5jqvq -- sh
df -h
echo "hello world" >/my-data/test.txt
cat /my-data/test.txt 
hello world
exit

kubectl delete pod busybox-hostpath-77df4698b7-5jqvq 
kubectl describe pvc busybox-hostpath-pvc  

microk8s kubectl exec -it busybox-hostpath-77df4698b7-5jqvq -- sh
df -h
cat /my-data/test.txt 
hello world
exit

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


**Test openebs-jiva**  
create a deployment using the openebs-jiva claim.
```
kubectl apply -f busybox-jiva-pvc.yaml
kubectl describe pvc busybox-jiva-pvc

kubectl get jivavolume pvc-0abb6bc3-6c07-4314-be3d-7bcc0b9bf6e7 -n openebs
NAME                                       REPLICACOUNT   PHASE   STATUS
pvc-0abb6bc3-6c07-4314-be3d-7bcc0b9bf6e7   3              Ready   RW

kubectl apply -f  busybox-jiva-deployment.yaml
kubectl describe deployment busybox-jiva

kubectl describe pvc busybox-jiva-pvc

microk8s kubectl exec -it busybox-jiva-5989fdc4d9-rljqk -- sh
df -h
echo "hello world" >/my-data/test.txt
cat /my-data/test.txt 
hello world
exit

kubectl delete pod busybox-jiva-5989fdc4d9-rljqk
kubectl describe pvc busybox-jiva-pvc  

microk8s kubectl exec -it busybox-jiva-5989fdc4d9-9hmrv -- sh
df -h
cat /my-data/test.txt 
hello world
exit

tree /var/snap/microk8s/common/var/openebs 
/var/snap/microk8s/common/var/openebs
├── local
│   └── pvc-8b626630-962f-46d4-914a-ec13d816f434
│       ├── log.info
│       ├── replica.log
│       ├── revision.counter
│       ├── volume-head-002.img
│       ├── volume-head-002.img.meta
│       ├── volume.meta
│       ├── volume-snap-429cf041-a55c-4118-ae5a-a4b4fe1a723f.img
│       ├── volume-snap-429cf041-a55c-4118-ae5a-a4b4fe1a723f.img.meta
│       ├── volume-snap-8075a4cc-7fb8-48cd-9a46-d22f20266188.img
│       └── volume-snap-8075a4cc-7fb8-48cd-9a46-d22f20266188.img.meta
├── ndm
└── sparse

4 directories, 10 files



