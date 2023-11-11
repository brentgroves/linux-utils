https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli
An ingress controller is a piece of software that provides reverse proxy, configurable traffic routing, and TLS termination for Kubernetes services. Kubernetes ingress resources are used to configure the ingress rules and routes for individual Kubernetes services. When you use an ingress controller and ingress rules, a single IP address can be used to route traffic to multiple services in a Kubernetes cluster.

This article shows you how to deploy the NGINX ingress controller in an Azure Kubernetes Service (AKS) cluster. Two applications are then run in the AKS cluster, each of which is accessible over the single IP address.

There are two open source ingress controllers for Kubernetes based on Nginx: one is maintained by the Kubernetes community (kubernetes/ingress-nginx), and one is maintained by NGINX, Inc. (nginxinc/kubernetes-ingress). This article will be using the Kubernetes community ingress controller.

# login to azure
az login

# set the kubectl context
scc.sh reports-aks-mobex.yaml ingress-nginx

# set enviromental variables
pushd ~/src/linux-utils/aks
source ./env.sh
./penv.sh

# combination of https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli and https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli
These instruction are a combo of the 2 sets of instructions on microsofts web site because there is a problem with adding our ACR to helm3 that prevents us from following the basic ingress install procedure found at https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli 

https://github.com/Azure/acr/issues/653
The issue is that we can not add our ACR to the helm3 repo list.

# switch to https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli instructions.

I'm going to skip around because the instructions at the above URL assume you have already installed the nginx ingress controller which I have not done at this point in the instructions.

# setup static ip
go to https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#create-a-static-or-dynamic-public-ip-address
Create a public IP address with the static allocation method using the az network public-ip create command.

# Get the node resource group name of the AKS cluster with the az aks show command.
az aks show --resource-group $RESOURCEGROUP --name $AKSCLUSTER --query nodeResourceGroup -o tsv
add the $NODERESOURCEGROUP variable to env.sh
pushd ~/src/linux-utils/aks/
nvim env.sh
insert
export NODERESOURCEGROUP=$NODERESOURCEGROUP
./env.sh
./penv.sh

# create the public ip for the ingress controller to use
export STATIC_IP =$(az network public-ip create --resource-group $NODERESOURCEGROUP --name ingressAKSPublicIP --sku Standard --allocation-method static --query publicIp.ipAddress -o tsv)
verify it worked.
az network public-ip show --resource-group $NODERESOURCEGROUP --name "ingressAKSPublicIP" --query ipAddress -o tsv
  "ipAddress": "23.101.116.170",

# add the STATIC_IP variable to env.sh
pushd ~/src/linux-utils/aks/
nvim env.sh
insert
export STATIC_IP=23.101.116.170
source ./env.sh
./penv.sh

# associate a dns label with the public ip
Get the resource-id of the public IP:
export PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].[id]" --output tsv)
echo $PUBLICIPID

# Update public IP address with DNS name
nvim env.sh
insert
export PUBLICIPID="/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Network/publicIPAddresses/ingressAKSPublicIP"
source ./env.sh
./penv.sh
export DNS_LABEL="reports-ingress"
az network public-ip update --ids $PUBLICIPID --dns-name $DNS_LABEL

# verify the label was attached
az network public-ip show --ids $PUBLICIPID --query "{Name:name,Label:dnsSettings.domainNameLabel,FQDN:dnsSettings.fqdn}" --output json
{
  "FQDN": "reports-ingress.centralus.cloudapp.azure.com",
  "Label": "reports-ingress",
  "Name": "ingressAKSPublicIP"
}

# Display the FQDN
az network public-ip show --ids $PUBLICIPID --query "dnsSettings.fqdn" --output tsv
reports-ingress.centralus.cloudapp.azure.com

# install the nginx ingress controller
This article shows you how to deploy the NGINX ingress controller in an Azure Kubernetes Service (AKS) cluster. Two applications are then run in the AKS cluster, each of which is accessible over the single IP address.

There are two open source ingress controllers for Kubernetes based on Nginx: one is maintained by the Kubernetes community (kubernetes/ingress-nginx), and one is maintained by NGINX, Inc. (nginxinc/kubernetes-ingress). This article will be using the Kubernetes community ingress controller.

note: had to pass the repo parameter since I did not know how to link helm to the mobexcr.

could have added the repo like this but I did not:
https://cert-manager.io/docs/tutorials/acme/nginx-ingress/
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update
Hang tight while we grab the latest from your chart repositories...
...Skip local chart repository
...Successfully got an update from the "stable" chart repository
...Successfully got an update from the "ingress-nginx" chart repository
...Successfully got an update from the "coreos" chart repository
Update Complete. ⎈ Happy Helming!⎈

helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"=$DNS_LABEL \
  --set controller.service.loadBalancerIP=$STATIC_IP

I probably should have ran the "helm install" instead of "helm upgrade" command but I was following the instructions to add a DNS label and static IP which assumed the ingress controller was installed already. 

# output of helm upgrade command:
Release "ingress-nginx" does not exist. Installing it now.
NAME: ingress-nginx
LAST DEPLOYED: Mon Mar 13 19:26:20 2023
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
charlene.childers@hrblock.com
  apiVersion: v1
  kind: Secret
  metadata:
    name: example-tls
    namespace: foo
  data:
    tls.crt: <base64 encoded cert>
    tls.key: <base64 encoded key>
  type: kubernetes.io/tls

# verify dns label and static ip

kubectl describe service ingress-nginx-controller   
Name:                     ingress-nginx-controller
Namespace:                ingress-nginx
Labels:                   app.kubernetes.io/component=controller
                          app.kubernetes.io/instance=ingress-nginx
                          app.kubernetes.io/managed-by=Helm
                          app.kubernetes.io/name=ingress-nginx
                          app.kubernetes.io/part-of=ingress-nginx
                          app.kubernetes.io/version=1.6.4
                          helm.sh/chart=ingress-nginx-4.5.2
Annotations:              meta.helm.sh/release-name: ingress-nginx
                          meta.helm.sh/release-namespace: ingress-nginx
                          service.beta.kubernetes.io/azure-dns-label-name: reports-ingress
Selector:                 app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
Type:                     LoadBalancer
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.0.135.65
IPs:                      10.0.135.65
IP:                       23.101.116.170
LoadBalancer Ingress:     23.101.116.170
Port:                     http  80/TCP
TargetPort:               http/TCP
NodePort:                 http  31260/TCP
Endpoints:                10.244.0.13:80
Port:                     https  443/TCP
TargetPort:               https/TCP
NodePort:                 https  30197/TCP
Endpoints:                10.244.0.13:443
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>

# install cert manager
Go to the https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#use-tls-with-lets-encrypt-certificates

https://cert-manager.io/docs/

It can issue certificates from a variety of supported sources, including Let's Encrypt, HashiCorp Vault, and Venafi as well as private PKI.

https://cert-manager.io/docs/tutorials/acme/nginx-ingress/#step-5---deploy-cert-manager

# Use TLS with Let's Encrypt certificates
To use TLS with Let's Encrypt certificates, you'll deploy cert-manager, which automatically generates and configures Let's Encrypt certificates.

