# change svc to nodeport

So you don't have to keep running the dashboard-proxy you can change the service from clusterip to nodeport

<https://medium.com/@satyakommula/deploy-kubernetes-dashboard-with-nodeport-382f447d2ff8>
kubectl get svc kubernetes-dashboard -n kube-system
NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
kubernetes-dashboard   ClusterIP   10.152.183.19   <none>        443/TCP   22h

kubectl patch service kubernetes-dashboard -n kube-system -p '{"spec": {"type": "NodePort"} }'
service/kubernetes-dashboard patched

kubeclt get svc kubernetes-dashboard -n kube-system
NAME                   TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)         AGE
kubernetes-dashboard   NodePort   10.152.183.19   <none>        443:30587/TCP   22h

## access dashboard using nodeport svc

<https://172.20.88.65:30587>

kubectl describe svc kubernetes-dashboard -n kube-system
