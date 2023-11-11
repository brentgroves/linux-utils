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

I have tried all sorts of things to get OpenEBS Mayastor clustered storage to work on microk8s without much success. So rather than give up completely I thought I would detail one of my failed attempts and see if anyone could figure out what I am doing wrong. Thanks in advance for any help you can give me :-)  

**Failed Attempt**  
Here is the results of following the steps posted on at https://microk8s.io/docs/addon-mayastor.  

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
sudo snap install microk8s --classic --channel=1.26/edge
sudo usermod -a -G microk8s $USER  
sudo chown -f -R $USER ~/.kube  
newgrp microk8s  
sudo reboot  
--env-context=--iova-mode=pa  // i don't do this
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

**Followed the directions at https://microk8s.io/docs/addon-mayastor**  
**step 1:**  
```
sudo sysctl vm.nr_hugepages=1024  
echo 'vm.nr_hugepages=1024' | sudo tee -a /etc/sysctl.conf  
sudo nvim /etc/sysctl.conf  
```
**step 2:**  
```
sudo apt install linux-modules-extra-$(uname -r)  
sudo modprobe nvme_tcp  
echo 'nvme-tcp' | sudo tee -a /etc/modules-load.d/microk8s-mayastor.conf  
sudo nvim /etc/modules-load.d/microk8s-mayastor.conf  
```
**step 3:**  
```
microk8s enable dns  
microk8s enable helm3  
thought we might need rbac so I enabled that also.  
microk8s enable rbac  
```
**Created 3 node cluster.**  
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
**Install mayastor prerequisites**  
```
HugePages must be enabled. Mayastor requires at least 1024 4MB HugePages.
This can be achieved by running the following commands on each host:
sudo sysctl vm.nr_hugepages=1024
echo 'vm.nr_hugepages=1024' | sudo tee -a /etc/sysctl.conf
cat /etc/sysctl.conf
The nvme_fabrics and nvme_tcp modules are required on all hosts. Install the modules with:
sudo apt install linux-modules-extra-$(uname -r)
sudo modprobe nvme_tcp
echo 'nvme-tcp' | sudo tee -a /etc/modules-load.d/microk8s-mayastor.conf
cat /etc/modules-load.d/microk8s-mayastor.conf

```
**enable the mayastor add-on:**
```  
from any node.  
Enable the Mayastor addon:
sudo microk8s enable core/mayastor --default-pool-size 20G
Mayastor will run for all nodes in your MicroK8s cluster by default. Use the
'microk8s.io/mayastor=disable' label to disable any node. For example:

    microk8s.kubectl label node reports31 microk8s.io/mayastor=disable
```
**Wait for the mayastor control plane and data plane pods to come up:**  
```
sudo microk8s.kubectl get pod -n mayastor

```

**Verify that all mayastorpools are up and running with:**  
```
The mayastor addon will automatically create on MayastorPool per node in the MicroK8s cluster. This pool is backed by a sparse image file. Refer to the Mayastor documentation for information on using existing block devices.

sudo microk8s.kubectl get mayastorpool -n mayastor
```
**Went to the trouble-shooting section at https://microk8s.io/docs/addon-mayastor**  
```
microk8s.kubectl logs -n mayastor daemonset/mayastor
kubectl -n mayastor logs pod/mayastor-rjvkx
output was:
Found 3 pods, using pod/mayastor-8pcc4
Defaulted container "mayastor" out of: mayastor, registration-probe (init), etcd-probe (init), initialize-pool (init)
Error from server (BadRequest): container "mayastor" in pod "mayastor-8pcc4" is waiting to start: PodInitializing
```
