sudo chmod 777 /etc/iptables/rules.v4
sudo iptables -P FORWARD ACCEPT
sudo /sbin/iptables-save > /etc/iptables/rules.v4
https://microk8s.io/docs/nfs

10.1.0.117/22
10.1.0.0/22
sudo mkdir -p /srv/nfs
sudo chmod 0777 /srv/nfs
echo '/srv/nfs 10.1.0.0/22(rw,sync,no_subtree_check)' | sudo tee /etc/exports
kubectl get pod -n kube-system


sudo snap install microk8s --classic --channel latest/edge

https://ubuntu.com/blog/kubernetes-storage-microk8s-mayastor

https://github.com/balchua/do-microk8s/blob/master/docs/openebs.md
https://computingforgeeks.com/deploy-and-use-openebs-container-storage-on-kubernetes/

microk8s helm3 -n openebs install openebs openebs/openebs \
    --set varDirectoryPath.baseDir="/var/snap/microk8s/common/var/openebs/" \
    --set jiva.defaultStoragePath="/var/snap/microk8s/common/var/openebs/"

microk8s helm3 -n openebs uninstall openebs openebs/openebs
kubectl describe pod openebs-ndm-operator-7ddccf59c4-r7pfq -n openebs

https://itnext.io/whats-new-in-microk8s-v1-24-cf9180bc6a82

sudo snap install microk8s --classic --channel=1.24/stable
sudo microk8s enable mayastor
https://mayastor.gitbook.io/introduction/quickstart/troubleshooting
kubectl -n mayastor get pods -o wide
kubectl -n mayastor logs mayastor-wk4q2

https://www.tsunati.com/blog/microk8s-and-openebs

https://openebs.io/docs
https://microk8s.io/docs/addon-mayastor

https://www.youtube.com/watch?v=n1npnB37lN8
https://www.youtube.com/watch?v=xLPRh-jJyQI
https://github.com/openebs/mayastor/issues/1133
sudo snap install microk8s --classic --channel=1.24/stable
sudo snap install microk8s --classic --channel=1.26/stable

Requirements
Note: These requirements apply to ALL the nodes in a MicroK8s cluster. Please run the commands on each node.

HugePages must be enabled. Mayastor requires at least 1024 4MB HugePages.

This can be achieved by running the following commands on each host:
https://github.com/balchua/do-microk8s/blob/master/docs/openebs.md
Pre-requisites:

iscsi-client must be installed on every node.

Verify if the client is installed.
More information from OpenEBS site

sudo cat /etc/iscsi/initiatorname.iscsi | grep InitiatorName
sudo systemctl is-enabled iscsid | grep enabled

microk8s enable rbac
microk8s enable dns
microk8s enable helm3

https://microk8s.io/docs/addon-openebs
microk8s enable openebs
took about 15 minutes to start.

on each pod microk8s inspect:
sudo iptables -P FORWARD ACCEPT
sudo apt-get install iptables-persistent

https://github.com/balchua/do-microk8s/blob/master/docs/openebs.md
kubectl apply -f csi.yaml
https://gist.github.com/l-ra/2ea09a3e3e11d67772f4506cdf31c6a2
kubectl apply -f deploy.yaml
microk8s kubectl get pod
kubectl exec -it busybox-b4ff57999-v7v7v -- sh
You should see the /my-data directory.

Write a file into the /my-data.

echo "hello" > /my-data/test.txt
/ # ls -l /my-data/test.txt 
-rw-r--r--    1 root     root             6 Mar  6 02:36 /my-data/test.txt
/ # cat /my-data/test.txt 
hello

What I did so far.
https://microk8s.io/docs/addon-mayastor
followed the instructions below on a microk8s cluster
consisting of 3 Ubuntus 22.04 nodes running microk8s from channel=1.26/stable.

sudo sysctl vm.nr_hugepages=1024
echo 'vm.nr_hugepages=1024' | sudo tee -a /etc/sysctl.conf

sudo apt install linux-modules-extra-$(uname -r)

sudo modprobe nvme_tcp
echo 'nvme-tcp' | sudo tee -a /etc/modules-load.d/microk8s-mayastor.conf

sudo microk8s enable core/mayastor --default-pool-size 20G
microk8s.kubectl logs -n mayastor daemonset/mayastor

kubectl get pod -n mayastor

results:
mayastor-wsd4t                           0/1     Init:0/3   0          16h
mayastor-bb4qh                           0/1     Init:0/3   0          16h
mayastor-csi-shvb4                       2/2     Running    0          16h
rest-77d69fb479-8c89k                    0/1     Init:0/2   0          16h
mayastor-csi-dr7xq                       2/2     Running    0          16h
mayastor-j4jsz                           0/1     Init:0/3   0          16h
csi-controller-54ccfcfbcc-cxvn9          0/3     Init:0/1   0          16h
core-agents-55d76bb877-hr6s2             0/1     Init:0/1   0          16h
mayastor-csi-jjz5t                       2/2     Running    0          16h
etcd-operator-mayastor-65f9967f5-8ljjj   1/1     Running    0          16h
msp-operator-74ff9cf5d5-8gk8g            0/1     Init:0/2   0          16h
etcd-6lgd6n8hkk                          0/1     Init:0/1   0          16h

https://github.com/canonical/microk8s-core-addons/issues/25

https://ubuntu.com/blog/kubernetes-storage-microk8s-mayastor
Enable nvme_tcp and HugePages:
sudo apt-get install linux-modules-extra-$(uname -r) 
sudo modprobe nvme_tcp 
sudo sysctl vm.nr_hugepages=1024

Install MicroK8s from latest/edge:sudo snap install microk8s --classic --channel latest/edge
Enable Mayastor:sudo microk8s enable core/mayastor

https://www.youtube.com/watch?v=n1npnB37lN8
https://www.youtube.com/watch?v=xLPRh-jJyQI
https://github.com/openebs/mayastor/issues/1133
sudo snap install microk8s --classic --channel=1.24/stable
sudo snap install microk8s --classic --channel=1.26/stable
To Reproduce

find a node supports multiple hugepage pools
snap install microk8s from edge channel
microk8s enable core/mayastor
kubectl -n mayastor get pods <--- id the failing mayastor-$ID pod
get logs
https://mayastor.gitbook.io/introduction/quickstart/troubleshooting
microk8s enable mayastor