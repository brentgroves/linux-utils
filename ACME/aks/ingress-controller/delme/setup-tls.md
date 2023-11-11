https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli

I don't have this yet:
This article assumes you have an existing AKS cluster with an integrated Azure Container Registry (ACR). For more information on creating an AKS cluster with an integrated ACR, see Authenticate with ACR from AKS.

Use TLS with Let's Encrypt certificates
To use TLS with Let's Encrypt certificates, you'll deploy cert-manager, which automatically generates and configures Let's Encrypt certificates.

https://github.com/cert-manager/cert-manager
https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli

# Attach using acr-name 
export ACRNAME=mobexcr
export AKSCLUSTER=reports-aks
export RESOURCEGROUP=reports-aks

az aks update -n $AKSCLUSTER -g $RESOURCEGROUP --attach-acr $ACRNAME

Waiting for AAD role to propagate[################################    ]  90.0000%Could not create a role assignment for ACR. Are you an Owner on this subscription?
# Import the cert-manager images used by the Helm chart into your ACR
Use az acr import to import the following images into your ACR.
pushd ~/src/linux-utils/aks/ingress-controller/lets-encrypt
export REGISTRY_NAME=mobexcr
export CERT_MANAGER_REGISTRY=quay.io
export CERT_MANAGER_TAG=v1.8.0
export CERT_MANAGER_IMAGE_CONTROLLER=jetstack/cert-manager-controller
export CERT_MANAGER_IMAGE_WEBHOOK=jetstack/cert-manager-webhook
export CERT_MANAGER_IMAGE_CAINJECTOR=jetstack/cert-manager-cainjector

az acr import --name $REGISTRY_NAME --source $CERT_MANAGER_REGISTRY/$CERT_MANAGER_IMAGE_CONTROLLER:$CERT_MANAGER_TAG --image $CERT_MANAGER_IMAGE_CONTROLLER:$CERT_MANAGER_TAG
az acr import --name $REGISTRY_NAME --source $CERT_MANAGER_REGISTRY/$CERT_MANAGER_IMAGE_WEBHOOK:$CERT_MANAGER_TAG --image $CERT_MANAGER_IMAGE_WEBHOOK:$CERT_MANAGER_TAG
az acr import --name $REGISTRY_NAME --source $CERT_MANAGER_REGISTRY/$CERT_MANAGER_IMAGE_CAINJECTOR:$CERT_MANAGER_TAG --image $CERT_MANAGER_IMAGE_CAINJECTOR:$CERT_MANAGER_TAG
az acr repository list --name mobexcr

Ingress controller configuration options
You can configure your NGINX ingress controller using either a static public IP address or a dynamic public IP address. If you're using a custom domain, you need to add an A record to your DNS zone. If you're not using a custom domain, you can configure a fully qualified domain name (FQDN) for the ingress controller IP address.

Create a static or dynamic public IP address
Use a static public IP address
You can configure your ingress controller with a static public IP address. The static public IP address remains if you delete your ingress controller. The IP address doesn't remain if you delete your AKS cluster.

When you upgrade your ingress controller, you must pass a parameter to the Helm release to ensure the ingress controller service is made aware of the load balancer that will be allocated to it. For the HTTPS certificates to work correctly, you use a DNS label to configure an FQDN for the ingress controller IP address.

# Get the resource group name of the AKS cluster with the az aks show command.
pushd ~/src/linux-utils/aks/
./env.sh
./penv.sh
az aks show --resource-group $RESOURCEGROUP --name $AKSCLUSTER --query nodeResourceGroup -o tsv

Create a public IP address with the static allocation method using the az network public-ip create command. The following example creates a public IP address named myAKSPublicIP in the AKS cluster resource group obtained in the previous step.

export ACRNAME=mobexcr
export AKSCLUSTER=reports-aks
export RESOURCEGROUP=reports-aks
export NODERESOURCEGROUP=MC_reports-aks_reports-aks_centralus

export STATIC_IP =$(az network public-ip create --resource-group $NODERESOURCEGROUP --name ingressAKSPublicIP --sku Standard --allocation-method static --query publicIp.ipAddress -o tsv)
az network public-ip show --resource-group $NODERESOURCEGROUP --name "ingressAKSPublicIP"
  {
    "ddosSettings": {
      "protectionMode": "VirtualNetworkInherited"
    },
    "dnsSettings": {
      "domainNameLabel": "reports-ingress",
      "fqdn": "reports-ingress.centralus.cloudapp.azure.com"
    },
    "etag": "W/\"eccfd569-a921-405b-a46f-5715ff8ab484\"",
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Network/publicIPAddresses/ingressAKSPublicIP",
    "idleTimeoutInMinutes": 4,
    "ipAddress": "23.101.116.170",
    "ipConfiguration": {
      "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Network/loadBalancers/kubernetes/frontendIPConfigurations/afd13a33715f240baa3518cf69ca2512",
      "resourceGroup": "mc_reports-aks_reports-aks_centralus"
    },
    "ipTags": [],
    "location": "centralus",
    "name": "ingressAKSPublicIP",
    "provisioningState": "Succeeded",
    "publicIPAddressVersion": "IPv4",
    "publicIPAllocationMethod": "Static",
    "resourceGroup": "mc_reports-aks_reports-aks_centralus",
    "resourceGuid": "b1ce26fb-9f16-431e-baa3-e9da80a0b2b4",
    "sku": {
      "name": "Standard",
      "tier": "Regional"
    },
    "tags": {
      "k8s-azure-dns-label-service": "ingress-nginx/ingress-nginx-controller"
    },
    "type": "Microsoft.Network/publicIPAddresses"
  }

Add the --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"="<DNS_LABEL>" parameter. The DNS label can be set either when the ingress controller is first deployed, or it can be configured later

Add the --set controller.service.loadBalancerIP="<STATIC_IP>" parameter. Specify your own public IP address that was created in the previous step.

# static ip
pushd ~/src/linux-utils/aks/ingress-controller/lets-encrypt
export DNS_LABEL="reports-ingress"
export NAMESPACE="ingress-nginx"
export STATIC_IP=23.101.116.170

# not using mobexcr since it was not linked to aks when i installed this.
pushd ~/src/linux-utils/aks
source ./env.sh
./penv.sh

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"=$DNS_LABEL \
  --set controller.service.loadBalancerIP=$STATIC_IP

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

# Get the public IP address for your ingress controller
# Name to associate with public IP address
DNSLABEL="reports-ingress"

# Get the resource-id of the public IP
export STATIC_IP=23.101.116.170
export PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].[id]" --output tsv)
/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Network/publicIPAddresses/ingressAKSPublicIP

# Update public IP address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSLABEL


export PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].[id]" --output tsv)

# Display the FQDN
az network public-ip show --ids $PUBLICIPID --query "[dnsSettings.fqdn]" --output tsv


az network public-ip show --ids /subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Network/publicIPAddresses/ingressAKSPublicIP

{
  "ddosSettings": {
    "protectionMode": "VirtualNetworkInherited"
  },
  "dnsSettings": {
    "domainNameLabel": "reports-ingress",
    "fqdn": "reports-ingress.centralus.cloudapp.azure.com"
  },
  "etag": "W/\"eccfd569-a921-405b-a46f-5715ff8ab484\"",
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Network/publicIPAddresses/ingressAKSPublicIP",
  "idleTimeoutInMinutes": 4,
  "ipAddress": "23.101.116.170",
  "ipConfiguration": {
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Network/loadBalancers/kubernetes/frontendIPConfigurations/afd13a33715f240baa3518cf69ca2512",
    "resourceGroup": "mc_reports-aks_reports-aks_centralus"
  },
  "ipTags": [],
  "location": "centralus",
  "name": "ingressAKSPublicIP",
  "provisioningState": "Succeeded",
  "publicIPAddressVersion": "IPv4",
  "publicIPAllocationMethod": "Static",
  "resourceGroup": "mc_reports-aks_reports-aks_centralus",
  "resourceGuid": "b1ce26fb-9f16-431e-baa3-e9da80a0b2b4",
  "sku": {
    "name": "Standard",
    "tier": "Regional"
  },
  "tags": {
    "k8s-azure-dns-label-service": "ingress-nginx/ingress-nginx-controller"
  },
  "type": "Microsoft.Network/publicIPAddresses"
}

kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller
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

watch	w	false	After listing/getting the requested object, watch for changes.

ingress-nginx-controller   LoadBalancer   10.0.135.65   23.101.116.170   80:31260/TCP,443:30197/TCP   10m   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx

START HERE
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"=$DNS_LABEL \
  --set controller.service.loadBalancerIP=$STATIC_IP
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"=$DNS_LABEL \
  --set controller.service.loadBalancerIP=$STATIC_IP

DNS_LABEL="reports-ingress"
NAMESPACE="ingress-nginx"

// helm upgrade ingress-nginx ingress-nginx/ingress-nginx \
helm upgrade ingress-nginx ingress-nginx ingress-nginx \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"=$DNS_LABEL

# Configure an FQDN for your ingress controller
https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli
Optionally, you can configure an FQDN for the ingress controller IP address instead of a custom domain by setting a DNS label. Your FQDN should follow this form: <CUSTOM DNS LABEL>.<AZURE REGION NAME>.cloudapp.azure.com.
mobex.centralus.cloudapp.azure.com.
Important
Your DNS label must be unique within its Azure location.
You can configure your FQDN using one of the following methods:

Set the DNS label using Azure CLI or Azure PowerShell.
Set the DNS label using Helm chart settings.
For more information, see Public IP address DNS name labels.    

# Public IP address of your ingress controller
kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller

export IP="20.9.106.76"

# Name to associate with public IP address
export DNSLABEL="mobex-ingress"
echo $DNSLABEL
# Get the resource-id of the public IP
export PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].[id]" --output tsv)
echo $PUBLICIPID
/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports_reports-aks_centralus/providers/Microsoft.Network/publicIPAddresses/kubernetes-af89c14e108074281a3bcb9eaf1a8d6b

# Update public IP address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNS_LABEL

# Display the FQDN
az network public-ip show --ids $PUBLICIPID --query "[dnsSettings.fqdn]" --output tsv
reports-ingress.centralus.cloudapp.azure.com
az network public-ip show --ids $PUBLICIPID
{
  "ddosSettings": {
    "protectionMode": "VirtualNetworkInherited"
  },
  "dnsSettings": {
    "domainNameLabel": "reports-ingress",
    "fqdn": "reports-ingress.centralus.cloudapp.azure.com"
  },
  "etag": "W/\"eccfd569-a921-405b-a46f-5715ff8ab484\"",
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Network/publicIPAddresses/ingressAKSPublicIP",
  "idleTimeoutInMinutes": 4,
  "ipAddress": "23.101.116.170",
  "ipConfiguration": {
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Network/loadBalancers/kubernetes/frontendIPConfigurations/afd13a33715f240baa3518cf69ca2512",
    "resourceGroup": "mc_reports-aks_reports-aks_centralus"
  },
  "ipTags": [],
  "location": "centralus",
  "name": "ingressAKSPublicIP",
  "provisioningState": "Succeeded",
  "publicIPAddressVersion": "IPv4",
  "publicIPAllocationMethod": "Static",
  "resourceGroup": "mc_reports-aks_reports-aks_centralus",
  "resourceGuid": "b1ce26fb-9f16-431e-baa3-e9da80a0b2b4",
  "sku": {
    "name": "Standard",
    "tier": "Regional"
  },
  "tags": {
    "k8s-azure-dns-label-service": "ingress-nginx/ingress-nginx-controller"
  },
  "type": "Microsoft.Network/publicIPAddresses"
}

Next install cert-manager
I believe I already added the needed repos.
https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#install-cert-manager
