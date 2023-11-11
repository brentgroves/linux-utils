https://cert-manager.io/docs/tutorials/acme/nginx-ingress/
Step 2 - Deploy the NGINX Ingress Controller
A kubernetes ingress controller is designed to be the access point for HTTP and HTTPS traffic to the software running within your cluster. The ingress-nginx-controller does this by providing an HTTP proxy service supported by your cloud provider's load balancer.

https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli

Use TLS with an ingress controller on Azure Kubernetes Service (AKS)

These directions are for https://github.com/kubernetes/ingress-nginx


# login to azure
az login

# set the kubectl context
scc.sh reports-aks-mobex.yaml ingress-nginx

# set enviromental variables
pushd ~/src/linux-utils/nginx-ic
source ./env.sh
./penv.sh

# login to ACR
az acr login --name $ACRNAME

# combination of https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli and https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli
These instruction are a combo of the 2 sets of instructions on microsofts web site because there is a problem with adding our ACR to helm3 that prevents us from following the basic ingress install procedure found at https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli 

# switch to https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli instructions.

I'm going to skip around because the instructions at the above URL assume you have already installed the nginx ingress controller which I have not done at this point in the instructions.

# setup static ip
go to https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#create-a-static-or-dynamic-public-ip-address
Create a public IP address with the static allocation method using the az network public-ip create command.

# Get the node resource group, microsoft's resource group associated with your aks, name of the AKS cluster with the az aks show command.
az aks show --resource-group $RESOURCEGROUP --name $AKSCLUSTER --query nodeResourceGroup -o tsv
add the $NODERESOURCEGROUP variable to env.sh
pushd ~/src/linux-utils/nginx-ic/
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

az network public-ip show --resource-group $NODERESOURCEGROUP --name "ingressAKSPublicIP" --output json --query "{IP:ipAddress,ID:id,Name:name}"

# add the STATIC_IP variable to env.sh
pushd ~/src/linux-utils/nginx-ic/
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


https://cert-manager.io/docs/tutorials/acme/nginx-ingress/

note: helm uses the kube config file to know which k8s to access and can access mobexcr if you are logged in: az acr login --name $ACRNAME 

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

https://kubernetes.github.io/ingress-nginx/deploy/#webhook-network-access

The controller uses an admission webhook to validate Ingress definitions. Make sure that you don't have Network policies or additional firewalls preventing connections from the API server to the ingress-nginx-controller-admission service.
cert-manager adds certificates and certificate issuers as resource types in Kubernetes clusters, and simplifies the process of obtaining, renewing and using those certificates.

# install cert manager
Go to the https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#use-tls-with-lets-encrypt-certificates

Install cert-manager
The NGINX ingress controller supports TLS termination. There are several ways to retrieve and configure certificates for HTTPS. This article uses cert-manager, which provides automatic Lets Encrypt certificate generation and management functionality.

To install the cert-manager controller, use the following commands.


Copy
# Set variable for ACR location to use for pulling images
ACR_URL=<REGISTRY_URL>

# Label the ingress-basic namespace to disable resource validation
kubectl label namespace ingress-basic cert-manager.io/disable-validation=true

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

./penv
I don't believe we can use $ACR_URL with mobexcr
https://stackoverflow.com/questions/65993187/whats-the-index-url-for-helm-charts-added-to-acr
https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#import-the-cert-manager-images-used-by-the-helm-chart-into-your-acr


https://learn.microsoft.com/en-us/azure/container-registry/container-registry-helm-repos

mobexcr.azurecr.io/samples/nginx

export REGISTRY_NAME=mobexcr
export CERT_MANAGER_REGISTRY=quay.io
export CERT_MANAGER_TAG=v1.8.0
export CERT_MANAGER_IMAGE_CONTROLLER=jetstack/cert-manager-controller
export CERT_MANAGER_IMAGE_WEBHOOK=jetstack/cert-manager-webhook
export CERT_MANAGER_IMAGE_CAINJECTOR=jetstack/cert-manager-cainjector

az acr import --name $REGISTRY_NAME --source $CERT_MANAGER_REGISTRY/$CERT_MANAGER_IMAGE_CONTROLLER:$CERT_MANAGER_TAG --image $CERT_MANAGER_IMAGE_CONTROLLER:$CERT_MANAGER_TAG
az acr import --name $REGISTRY_NAME --source $CERT_MANAGER_REGISTRY/$CERT_MANAGER_IMAGE_WEBHOOK:$CERT_MANAGER_TAG --image $CERT_MANAGER_IMAGE_WEBHOOK:$CERT_MANAGER_TAG
az acr import --name $REGISTRY_NAME --source $CERT_MANAGER_REGISTRY/$CERT_MANAGER_IMAGE_CAINJECTOR:$CERT_MANAGER_TAG --image $CERT_MANAGER_IMAGE_CAINJECTOR:$CERT_MANAGER_TAG

https://learn.microsoft.com/en-us/cli/azure/acr/repository?view=azure-cli-latest#az-acr-repository-show-tags

az acr repository show-tags -n mobexcr --repository "jetstack/cert-manager-cainjector"

az acr repository show-tags -n mobexcr --repository "jetstack/cert-manager-cainjector" --detail

export ACR_URL=mobexcr.azurecr.io
$ACR_URL/$CERT_MANAGER_IMAGE_CONTROLLER = mobexcr.azurecr.io/jetstack/cert-manager-controller
image.tag=v1.8.0 
az acr repository list --name mobexcr      
[
  "jetstack/cert-manager-cainjector",
  "jetstack/cert-manager-controller",
  "jetstack/cert-manager-webhook"
]

az acr repository show -n mobexcr --image jetstack/cert-manager-controller:v1.8.0
docker pull mobexcr.azurecr.io/jetstack/cert-manager-controller:v1.8.0 
docker pull $ACR_URL/$CERT_MANAGER_IMAGE_CONTROLLER:$CERT_MANAGER_TAG 
docker pull $ACR_URL/$CERT_MANAGER_IMAGE_WEBHOOK:$CERT_MANAGER_TAG 
docker pull $ACR_URL/$CERT_MANAGER_IMAGE_CAINJECTOR:$CERT_MANAGER_TAG 
az acr login --name $ACRNAME
then i can pull from docker
but can i pull from helm? or should I change the ACR_URL to quay.io?
or just take those parameters off all together?
https://learn.microsoft.com/en-us/answers/questions/724656/login-failure-into-acr-with-helm-3-7-3-8

https://learn.microsoft.com/en-us/azure/container-registry/container-registry-concepts#addressing-an-artifact

https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#install-cert-manager
# Install the cert-manager Helm chart

# Set variable for ACR location to use for pulling images
ACR_URL=<REGISTRY_URL>

# Label the ingress-nginx namespace to disable resource validation
kubectl label namespace ingress-nginx cert-manager.io/disable-validation=true

namespace/ingress-nginx labeled

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

helm install cert-manager jetstack/cert-manager \
  --namespace ingress-nginx \
  --version $CERT_MANAGER_TAG \
  --set installCRDs=true \
  --set nodeSelector."kubernetes\.io/os"=linux \
  --set image.repository=$ACR_URL/$CERT_MANAGER_IMAGE_CONTROLLER \
  --set image.tag=$CERT_MANAGER_TAG \
  --set webhook.image.repository=$ACR_URL/$CERT_MANAGER_IMAGE_WEBHOOK \
  --set webhook.image.tag=$CERT_MANAGER_TAG \
  --set cainjector.image.repository=$ACR_URL/$CERT_MANAGER_IMAGE_CAINJECTOR \
  --set cainjector.image.tag=$CERT_MANAGER_TAG
NAME: cert-manager
LAST DEPLOYED: Wed Mar 29 16:30:05 2023
NAMESPACE: ingress-nginx
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
cert-manager v1.8.0 has been deployed successfully!

In order to begin issuing certificates, you will need to set up a ClusterIssuer
or Issuer resource (for example, by creating a 'letsencrypt-staging' issuer).

More information on the different types of issuers and how to configure them
can be found in our documentation:


https://cert-manager.io/docs/tutorials/acme/nginx-ingress/#step-6---configure-a-lets-encrypt-issuer
https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#create-a-ca-cluster-issuer
Uninstalling with Helm
Uninstalling cert-manager from a helm installation is a case of running the installation process, in reverse, using the delete command on both kubectl and helm.


helm --namespace cert-manager delete cert-manager

https://cert-manager.io/docs/configuration/

For information on how to configure cert-manager to automatically provision
Certificates for Ingress resources, take a look at the `ingress-shim`
documentation:

https://cert-manager.io/docs/usage/ingress/
 
https://cert-manager.io/docs/

It can issue certificates from a variety of supported sources, including Let's Encrypt, HashiCorp Vault, and Venafi as well as private PKI.

https://cert-manager.io/docs/tutorials/acme/nginx-ingress/#step-5---deploy-cert-manager



# Use TLS with Let's Encrypt certificates
To use TLS with Let's Encrypt certificates, you'll deploy cert-manager, which automatically generates and configures Let's Encrypt certificates.




https://kubernetes.github.io/ingress-nginx/deploy/#certificate-generation
The first time the ingress controller starts, two Jobs create the SSL Certificate used by the admission webhook.

kubectl get secrets                                                               
NAME                                  TYPE                 DATA   AGE
ingress-nginx-admission               Opaque               3      14d
sh.helm.release.v1.ingress-nginx.v1   helm.sh/release.v1   1      14d
kubectl get csr

