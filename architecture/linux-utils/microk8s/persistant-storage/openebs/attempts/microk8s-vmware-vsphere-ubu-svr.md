https://github.com/openebs/openebs/discussions/3609
https://askubuntu.com/questions/1451537/only-1-of-3-openebs-ndm-and-csi-pods-being-created-on-install


While Stack Overflow does permit certain questions about Kubernetes, we require that they (like all questions asked here) be specifically related to programming. This question does not appear to be specifically related to programming, which makes it off-topic here. You might be able to ask questions like this one on Server Fault or DevOps. – 
https://serverfault.com/
https://devops.stackexchange.com/

Turing85
 Jan 14 at 20:38
10.1.0.9
administrator@vsphere.local
Bu$ch3@dm!n
reports01
reports02
reports03

Hypervisor:	VMware ESXi, 6.7.0, 15160138
Model:	PowerEdge R710
Processor Type:	Intel(R) Xeon(R) CPU E5620 @ 2.40GHz
Logical Processors:	16
NICs:	6
Virtual Machines:	10
State:	Connected
Uptime:	62 days

**Only 1 of 3 OpenEBS ndm and csi pods being created on install**  

**Setup**
- The nodes are 3 ubuntu 22.04 server VM installed on VMware ESXi, 6.7.0 PowerEdge R710 server.
- microk8s channel 1.26/stable
- OpenEBS community add-on


**The issue**  
I think the reason openebs-jiva is not working is only 1 ndm,cstor-csi, and jiva-csi pod expected 3 of each.
(base)  brent@reports41  ~  kubectl get all -n openebs                                  
NAME                                                 READY   STATUS    RESTARTS   AGE
pod/openebs-ndm-lfr9m                                1/1     Running   0          103m
pod/openebs-jiva-operator-594fdd69b9-6gtck           1/1     Running   0          103m
pod/openebs-cstor-cvc-operator-7946b467f5-jdkpx      1/1     Running   0          103m
pod/openebs-cstor-admission-server-f5d57f788-qsmzs   1/1     Running   0          103m
pod/openebs-ndm-operator-74fc47c6cc-c5b74            1/1     Running   0          103m
pod/openebs-localpv-provisioner-99449bb55-zqn7r      1/1     Running   0          103m
pod/openebs-cstor-cspc-operator-7dd775b4b8-26kh7     1/1     Running   0          103m
pod/openebs-cstor-csi-node-t9n2l                     2/2     Running   0          103m
pod/openebs-jiva-csi-node-hl268                      3/3     Running   0          103m
pod/openebs-cstor-csi-controller-0                   6/6     Running   0          103m
pod/openebs-jiva-csi-controller-0                    5/5     Running   0          103m


view all logs
```
no problems that I could see in any of the logs
kubectl logs -f deployment.apps/pvc-f8d287df-0a77-4958-8e57-da5f81921c9d-jiva-ctrl -n openebs
kubectl logs deployment.apps/openebs-localpv-provisioner -n openebs
kubectl logs deployment.apps/openebs-ndm-operator -n openebs
kubectl logs deployment.apps/openebs-jiva-operator -n openebs
kubectl logs daemonset.apps/openebs-ndm -n openebs
kubectl logs daemonset.apps/openebs-jiva-csi-node -n openebs
kubectl logs pod/openebs-localpv-provisioner-99449bb55-zqn7 -n openebs
```




```

**Followed the directions at https://openebs.io/docs/user-guides/jiva/jiva-prerequisites**  
Did the following on all 3 nodes:
```
sudo apt install open-iscsi
sudo systemctl enable --now iscsid
sudo modprobe iscsi_tcp
sudo touch /etc/modules-load.d/iscsi-tcp.conf
sudo chmod 777 /etc/modules-load.d/iscsi-tcp.conf
echo iscsi_tcp >/etc/modules-load.d/iscsi-tcp.conf
cat /etc/modules-load.d/iscsi-tcp.conf
sudo reboot
sudo systemctl status iscsid.service
```
**Followed the directions at https://microk8s.io/docs/addon-openebs**  
```
microk8s enable community
microk8s enable openebs
```
