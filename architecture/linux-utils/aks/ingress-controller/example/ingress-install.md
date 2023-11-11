https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli

pushd ~/src/linux-utils/kubectl/namespaces
kubectl apply -f ingress-nginx.yaml

pushd ~/src/linux-utils/kubectl/contexts
scc.sh reports-aks-mobex.yaml ingress-nginx

pushd ~/src/linux-utils/aks/ingress-controller/example

# Helm install
NAMESPACE=ingress-basic

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --create-namespace \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz

helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace

This command is idempotent:

if the ingress controller is not installed, it will install it,
if the ingress controller is already installed, it will upgrade it.

NAME: ingress-nginx
LAST DEPLOYED: Fri Mar 10 14:05:35 2023
NAMESPACE: ingress-nginx
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The ingress-nginx controller has been installed.
It may take a few minutes for the LoadBalancer IP to be available.
You can watch the status by running 'kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller'

An example Ingress that makes use of the controller:
  apiVersion: networking.k8s.io/v1
  kind: Ingress
  metadata:
    name: example
    namespace: foo
  spec:
    ingressClassName: nginx
    rules:
      - host: www.example.com
        http:
          paths:
            - pathType: Prefix
              backend:
                service:
                  name: exampleService
                  port:
                    number: 80
              path: /
    # This section is only required if TLS is to be enabled for the Ingress
    tls:
      - hosts:
        - www.example.com
        secretName: example-tls

If TLS is enabled for the Ingress, a Secret containing the certificate and key must also be provided:

  apiVersion: v1
  kind: Secret
  metadata:
    name: example-tls
    namespace: foo
  data:
    tls.crt: <base64 encoded cert>
    tls.key: <base64 encoded key>
  type: kubernetes.io/tls

kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller
NAME                       TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE    SELECTOR
ingress-nginx-controller   LoadBalancer   10.0.210.175   20.9.106.76   80:30875/TCP,443:31883/TCP   7m5s   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx


Online testing
If your Kubernetes cluster is a "real" cluster that supports services of type LoadBalancer, it will have allocated an external IP address or FQDN to the ingress controller.
You can see that IP address or FQDN with the following command:
kubectl get service ingress-nginx-controller --namespace=ingress-nginx
kubectl get services --namespace ingress-nginx -o wide -w ingress-nginx-controller
pushd /home/brent/src/linux-utils/aks/ingress-controller/example
kubectl apply -f aks-helloworld-one.yaml --namespace ingress-nginx
kubectl apply -f aks-helloworld-two.yaml --namespace ingress-nginx
kubectl apply -f hello-world-ingress.yaml --namespace ingress-nginx
# Let's create a simple web server and the associated service:
kubectl create deployment demo --image=httpd --port=80
# Expose demo using ClusterIP:
kubectl expose deployment demo
kubectl describe service demo

To access the pods with ClusterIP, you can run a BusyBox curl container, then run nslookup for the internal service. If the service is discoverable, this confirms that the pods are available from inside the cluster:


console@bash:~$ kubectl run curl --image=radial/busyboxplus:curl -i --tty --rm
nslookup demo
Name:      demo
Address 1: 10.0.178.16 demo.ingress-nginx.svc.cluster.local

curl demo.ingress-nginx.svc.cluster.local
Once you have the external IP address (or FQDN), set up a DNS record pointing to it. Then you can create an ingress resource. The following example assumes that you have set up a DNS record for www.demo.io:

kubectl create ingress demo --class=nginx \
  --rule="www.demo.io/*=demo:80"

  kubectl create ingress demo2 --class=nginx \
  --rule="reports-aks/*=demo:80"

kubectl get ingress
NAME   CLASS   HOSTS         ADDRESS       PORTS   AGE
demo   nginx   www.demo.io   20.9.106.76   80      15m

kubectl describe ingress demo
Name:             demo
Labels:           <none>
Namespace:        ingress-nginx
Address:          20.9.106.76
Ingress Class:    nginx
Default backend:  <default>
Rules:
  Host         Path  Backends
  ----         ----  --------
  www.demo.io  
               /   demo:80 (10.244.1.10:80)
Annotations:   <none>
Events:
  Type    Reason  Age                From                      Message
  ----    ------  ----               ----                      -------
  Normal  Sync    15m (x2 over 16m)  nginx-ingress-controller  Scheduled for sync

curl www.demo.io

https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli#create-an-ingress-controller


Host	Host header	Match?
*.foo.com	bar.foo.com	Matches based on shared suffix
*.foo.com	baz.bar.foo.com	No match, wildcard only covers a single DNS label
*.foo.com	foo.com	No match, wildcard only covers a single DNS la
