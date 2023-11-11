https://microk8s.io/docs/addon-openebs
https://github.com/balchua/do-microk8s/blob/master/docs/openebs.md

pushd ~/src/linux-utils/microk8s/openebs/usage/hostpath
kubectl apply -f busybox-hostpath-pvc.yaml

kubectl describe pvc busybox-hostpath-pvc
kubectl apply -f busybox-hostpath-deployment.yaml

microk8s kubectl get pod
microk8s kubectl describe pod busybox-hostpath-77df4698b7-7snm2

microk8s kubectl exec -it busybox-hostpath-77df4698b7-7snm2 -- sh

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