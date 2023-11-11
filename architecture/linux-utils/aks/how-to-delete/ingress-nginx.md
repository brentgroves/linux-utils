pushd ~/src/linux-utils/kubectl/contexts
scc.sh reports-aks-mobex.yaml ingress-nginx

scc.sh reports-aks-mobex.yaml ingress-nginx

kubectl get ingress
NAME                         CLASS   HOSTS                   ADDRESS       PORTS   AGE
demo                         nginx   *                       20.9.106.76   80      2d21h
hello-world-ingress          nginx   *                       20.9.106.76   80      2d22h
hello-world-ingress-static   nginx   *                       20.9.106.76   80      2d22h
ingress-wildcard-host        nginx   foo.bar.com,*.foo.com   20.9.106.76   80      2d21h

kubectl delete ingress demo
kubectl delete ingress hello-world-ingress
kubectl delete ingress hello-world-ingress-static
kubectl delete ingress ingress-wildcard-host

# deployments
kubectl get deployments               

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
aks-helloworld-one         1/1     1            1           2d22h
aks-helloworld-two         1/1     1            1           2d22h
demo                       1/1     1            1           3d
ingress-nginx-controller   1/1     1            1           3d1h

kubectl delete deployment demo
kubectl delete deployment aks-helloworld-one
kubectl delete deployment aks-helloworld-two
kubectl delete deployment ingress-nginx-controller

kubectl get svc
service/aks-helloworld-one                   ClusterIP      10.0.11.249    <none>        80/TCP                       2d22h
service/aks-helloworld-two                   ClusterIP      10.0.121.238   <none>        80/TCP                       2d22h
service/demo                                 ClusterIP      10.0.28.125    <none>        80/TCP                       2d21h
service/ingress-nginx-controller             LoadBalancer   10.0.210.175   20.9.106.76   80:30875/TCP,443:31883/TCP   3d1h
service/ingress-nginx-controller-admission   ClusterIP      10.0.64.86     <none>        443/TCP                      3d1h

kubectl delete service/aks-helloworld-one
kubectl delete service/aks-helloworld-two
kubectl delete service/demo  


# Helm uninstall
helm uninstall ingress-nginx

kubectl delete service/ingress-nginx-controller

