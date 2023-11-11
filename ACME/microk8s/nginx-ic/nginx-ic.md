https://microk8s.io/docs/addon-ingress
https://benbrougher.tech/posts/microk8s-ingress/

You might ask, however: “What about service load balancers and API gateways?” Historically, API gateways are used (such as Ocelot, or Kong) to consolidate individual APIs into a single interface that our frontend can talk to. Ingress’ provide a way to define in a semi-vendor neutral way, how traffic should flow. You can specify host names, and within those hosts you can specify sub routes and have the Ingress route traffic to different services via the same host name. For example, you may have:

www.mystore.com => Container hosting a static site
api.mystore.com
    /cart => Cart Managment Service
    /orders => Order Management Service
    /products => Product Management Service


All these different routes can be served by a single IP address via an Ingress rule. You can have any depth or format to the routes specified. In reality though, an Ingress is just a rule that lives in Kubernetes to define what the traffic should do. It doesn’t actually handle routing the traffic, that is left to the Ingress Controller.

Ingress Controllers
An Ingress Controller is a type of resource in Kubernetes that actually does the heavy lifting in regards to routing traffic. These controllers are often built out of already existing server applications like NGINX, Traefik, or HAProxy. There are even Ingress Controllers that will handle advanced use cases like Istio, which allows running serverless functions and facilitates scaling your pods to zero when there are no requests being made. In this post, we will be using microk8s as a base cluster. We’ll extend the cluster with the MetalLB and NGINX Ingress addons.

How to Set Up an Ingress
Prerequisites:

A fully working microk8s instance. You can use the documentation here to set up and configure the cluster. Any size will do, even a single node cluster for testing.
Knowlege of the IP subnet the cluster is running on. This will be important for defining the address range for MetalLB to use for our Ingress. For example, my cluster runs on my homelab network on the 192.168.1.x subnet.


Enabling MetalLB
Enabling MetalLB on microk8s is extremely easy. The microk8s stack has a concept of addons that can be enabled to easily give your cluster common functionality. The first step is to identify a range of IP addresses that will be allocatable by MetalLB. For this example, I’ll use 192.168.1.200-192.168.1.220. These IP adresses must be on the same subnet where the cluster is located. After you have the IP range, log into one of your nodes, and enable the load balancer like this:

ssh brent@reports1
microk8s status
microk8s enable metallb 10.1.0.110-10.1.0.112
microk8s status
scc.sh reports1.yaml microk8s
kubectl get all -n metallb-system
# custom address pool range looks interesting but I did not use it yet
pushd ~/src/linux-utils/microk8s/nginx-ic/reports1
kubectl apply -f addresspool.yaml


ssh brent@reports3
microk8s status
microk8s enable metallb 172.20.88.61-172.20.88.63
microk8s status
scc.sh reports3.yaml microk8s
kubectl get all -n metallb-system

ssh brent@reports5
microk8s status
microk8s enable metallb 172.20.88.65-172.20.88.68
microk8s status
scc.sh reports5.yaml microk8s
kubectl get all -n metallb-system


You can read more about the microk8s addon here and more about MetalLB here.

https://microk8s.io/docs/addon-metallb
https://metallb.universe.tf/

https://microk8s.io/docs/addon-ingress
https://benbrougher.tech/posts/microk8s-ingress/
Enabling the Ingress
Adding the ingress addon is similar to adding MetalLB. It can be enabled with the following:

microk8s enable ingress
You can read more about the Ingress Controller addon here.
https://microk8s.io/docs/addon-ingress

Infer repository core for addon ingress
Enabling Ingress
ingressclass.networking.k8s.io/public created
ingressclass.networking.k8s.io/nginx created
namespace/ingress created
serviceaccount/nginx-ingress-microk8s-serviceaccount created
clusterrole.rbac.authorization.k8s.io/nginx-ingress-microk8s-clusterrole created
role.rbac.authorization.k8s.io/nginx-ingress-microk8s-role created
clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
rolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
configmap/nginx-load-balancer-microk8s-conf created
configmap/nginx-ingress-tcp-microk8s-conf created
configmap/nginx-ingress-udp-microk8s-conf created
daemonset.apps/nginx-ingress-microk8s-controller created
Ingress is enabled
scc.sh reports[1,3,or 4].yaml microk8s
kubectl get all -n ingress


https://microk8s.io/docs/addon-cert-manager

ssh brent@reports1
microk8s status
microk8s enable cert-manager
https://cert-manager.io/v1.6-docs/installation/verify/
microk8s status
scc.sh reports[1,3,5].yaml microk8s
kubectl get pods --namespace cert-manager
https://cert-manager.io/v1.6-docs/usage/cmctl/#installation
cmctl
cmctl is a CLI tool that can help you to manage cert-manager resources inside your cluster.
While also available as a kubectl plugin, it is recommended to use as a stand alone binary as this allows the use of command auto-completion.

https://cert-manager.io/v1.6-docs/installation/verify/#manual-verification
OS=$(go env GOOS); ARCH=$(go env GOARCH); curl -L -o cmctl.tar.gz https://github.com/cert-manager/cert-manager/releases/download/v1.6.3/cmctl-$OS-$ARCH.tar.gz
tar xzf cmctl.tar.gz
sudo mv cmctl /usr/local/bin
cmctl check api

$ cat <<EOF > test-resources.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: cert-manager-test
---
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: test-selfsigned
  namespace: cert-manager-test
spec:
  selfSigned: {}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: selfsigned-cert
  namespace: cert-manager-test
spec:
  dnsNames:
    - example.com
  secretName: selfsigned-cert-tls
  issuerRef:
    name: test-selfsigned
EOF

pushd /home/brent/src/linux-utils/microk8s/nginx-ic/cert-manager-test
Create the test resources.
scc.sh reports[1,3,5].yaml microk8s
kubectl apply -f test-resources.yaml
namespace/cert-manager-test created
issuer.cert-manager.io/test-selfsigned created
certificate.cert-manager.io/selfsigned-cert created

kubectl get issuer.cert-manager.io/test-selfsigned -n cert-manager-test

Check the status of the newly created certificate. You may need to wait a few seconds before cert-manager processes the certificate request.
kubectl describe certificate -n cert-manager-test

...
Spec:
  Common Name:  example.com
  Issuer Ref:
    Name:       test-selfsigned
  Secret Name:  selfsigned-cert-tls
Status:
  Conditions:
    Last Transition Time:  2019-01-29T17:34:30Z
    Message:               Certificate is up to date and has not expired
    Reason:                Ready
    Status:                True
    Type:                  Ready
  Not After:               2019-04-29T17:34:29Z
Events:
  Type    Reason      Age   From          Message
  ----    ------      ----  ----          -------
  Normal  CertIssued  4s    cert-manager  Certificate issued successfully

Clean up the test resources.
$ kubectl delete -f test-resources.yaml




Cert-manager is installed. As a next step, try creating a ClusterIssuer
for Let's Encrypt by creating the following resource:

$ microk8s kubectl apply -f - <<EOF
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    # You must replace this email address with your own.
    # Let's Encrypt will use this to contact you about expiring
    # certificates, and issues related to your account.
    email: me@example.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: letsencrypt-account-key
    # Add a single challenge solver, HTTP01 using nginx
    solvers:
    - http01:
        ingress:
          class: public
EOF

Then, you can create an ingress to expose 'my-service:80' on 'https://my-service.example.com' with:

$ microk8s enable ingress
$ microk8s kubectl create ingress my-ingress     --annotation cert-manager.io/cluster-issuer=letsencrypt     --rule 'my-service.example.com/*=my-service:80,tls=my-service-tls'


microk8s enable cert-manager

https://medium.com/@michal.bock/deploy-certificate-authority-service-on-kubernetes-21853c152ade

k8s cert-manager cfssl
https://cert-manager.io/v1.6-docs/configuration/external/
https://gerrit.wikimedia.org/r/plugins/gitiles/operations/software/cfssl-issuer/
https://wikitech.wikimedia.org/wiki/Kubernetes/cert-manager
https://github.com/OpenSource-THG/cfssl-issuer
