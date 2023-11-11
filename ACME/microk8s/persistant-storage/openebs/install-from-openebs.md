https://www.lakshminp.com/a-brief-overview-of-openebs/
https://www.lakshminp.com/openebs-jiva-quickstart/

https://github.com/canonical/microk8s/issues/3639


sudo snap install microk8s --classic --channel=1.25/edge

sudo microk8s add-node

microk8s addons repo add community https://github.com/canonical/microk8s-community-addons --reference main 

microk8s enable community/openebs

kubectl apply -f busybox-jiva-pvc.yaml 
kubectl describe pvc busybox-jiva-pvc

Verify volume is ready to serve IOs.
kubectl get jivavolume pvc-ffc1e885-0122-4b5b-9d36-ae131717a77b -n openebs
NAME                                       REPLICACOUNT   PHASE   STATUS
pvc-ffc1e885-0122-4b5b-9d36-ae131717a77b   1              Ready   RW


