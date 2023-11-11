# outlook
scc.sh reports-aks-admin.yaml ingress-nginx reports-aks-admin
# mobex
scc.sh reports-aks-mobex.yaml mongo

kubectl get ns
kubectl get svc
bi-connector-svc      ClusterIP      None           <none>         3307/TCP          8d    app=bi-connector
reports-mongodb-0     LoadBalancer   10.0.239.125   20.80.66.135   30351:30446/TCP   8d    statefulset.kubernetes.io/pod-name=reports-mongodb-0
reports-mongodb-svc   ClusterIP      None           <none>         27017/TCP         18d   app=reports-mongodb-svc

kubectl delete svc reports-mongodb-0
kubectl delete svc bi-connector-svc 
kubectl delete svc reports-mongodb-svc

https://github.com/mongodb/mongodb-kubernetes-operator


kubectl get deployments               
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
bi-connector                  1/1     1            1           8d
mongodb-kubernetes-operator   1/1     1            1           18d

kubectl delete deployment bi-connector
kubectl delete deployment mongodb-kubernetes-operator
kubectl get pods                      
NAME                                           READY   STATUS    RESTARTS   AGE
mongodb-kubernetes-operator-596c586b7d-g4jtm   1/1     Running   0          18d
reports-mongodb-0                              2/2     Running   0          18d


kubectl delete deployment mongodb-kubernetes-operator

kubectl get statefulset         
NAME                  READY   AGE
reports-mongodb       1/1     18d
reports-mongodb-arb   0/0     18d
kubectl delete statefulset reports-mongodb
kubectl delete statefulset reports-mongodb-arb

kubectl get pods                                     
NAME                                           READY   STATUS        RESTARTS   AGE
reports-mongodb-0                              2/2     Running       0          18d


kubectl delete pod reports-mongodb-0 
