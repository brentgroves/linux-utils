https://www.reddit.com/r/kubernetes/comments/u527km/ha_storage_with_microk8s_made_easy_with_mayastor/

https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
https://discuss.kubernetes.io/t/addon-openebs-mayastor-clustered-storage/19451
kubectl apply -f pv-claim.yaml
kubectl describe pvc task-pv-claim
kubectl get pv task-pv-volume

kubectl describe pod task-pv-pod

