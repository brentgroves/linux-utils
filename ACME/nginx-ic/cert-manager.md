https://cert-manager.io/docs/installation/helm/
https://cert-manager.io/docs/installation/best-practice/
https://cert-manager.io/docs/configuration/acme/

https://github.com/cert-manager/cert-manager/issues/4871

ACME
The ACME Issuer type represents a single account registered with the Automated Certificate Management Environment (ACME) Certificate Authority server. When you create a new ACME Issuer, cert-manager will generate a private key which is used to identify you with the ACME server.

Certificates issued by public ACME servers are typically trusted by client's computers by default. This means that, for example, visiting a website that is backed by an ACME certificate issued for that URL, will be trusted by default by most client's web browsers. ACME certificates are typically free.

Solving Challenges
In order for the ACME CA server to verify that a client owns the domain, or domains, a certificate is being requested for, the client must complete "challenges". This is to ensure clients are unable to request certificates for domains they do not own and as a result, fraudulently impersonate another's site. As detailed in the RFC8555, cert-manager offers two challenge validations - HTTP01 and DNS01 challenges.

HTTP01 challenges are completed by presenting a computed key, that should be present at a HTTP URL endpoint and is routable over the internet. This URL will use the domain name requested for the certificate. Once the ACME server is able to get this key from this URL over the internet, the ACME server can validate you are the owner of this domain. When a HTTP01 challenge is created, cert-manager will automatically configure your cluster ingress to route traffic for this URL to a small web server that presents this key.

DNS01 challenges are completed by providing a computed key that is present at a DNS TXT record. Once this TXT record has been propagated across the internet, the ACME server can successfully retrieve this key via a DNS lookup and can validate that the client owns the domain for the requested certificate. With the correct permissions, cert-manager will automatically present this TXT record for your given DNS provider.

Creating a Basic ACME Issuer
All ACME Issuers follow a similar configuration structure - a clients email, a server URL, a privateKeySecretRef, and one or more solvers. Below is an example of a simple ACME issuer:


apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    # You must replace this email address with your own.
    # Let's Encrypt will use this to contact you about expiring
    # certificates, and issues related to your account.
    email: user@example.com
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: example-issuer-account-key
    # Add a single challenge solver, HTTP01 using nginx
    solvers:
    - http01:
        ingress:
          class: nginx

          


Installing with Helm
cert-manager provides Helm charts as a first-class method of installation on both Kubernetes and OpenShift.

Be sure never to embed cert-manager as a sub-chart of other Helm charts; cert-manager manages non-namespaced resources in your cluster and care must be taken to ensure that it is installed exactly once.

Add the Helm repository
This repository is the only supported source of cert-manager charts. There are some other mirrors and copies across the internet, but those are entirely unofficial and could present a security risk.

Notably, the "Helm stable repository" version of cert-manager is deprecated and should not be used.


helm repo add jetstack https://charts.jetstack.io

Update your local Helm chart repository cache:

helm repo update
3. Install CustomResourceDefinitions
cert-manager requires a number of CRD resources, which can be installed manually using kubectl, or using the installCRDs option when installing the Helm chart.

Option 1: installing CRDs with kubectl

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml


Option 2: install CRDs as part of the Helm release
To automatically install and manage the CRDs as part of your Helm release, you must add the --set installCRDs=true flag to your Helm installation command.

Uncomment the relevant line in the next steps to enable this.

Note that if you're using a helm version based on Kubernetes v1.18 or below (Helm v3.2), installCRDs will not work with cert-manager v0.16. See the v0.16 upgrade notes for more details.

4. Install cert-manager
To install the cert-manager Helm chart, use the Helm install command as described below.


helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.11.0 \
  # --set installCRDs=true

  A full list of available Helm values is on cert-manager's ArtifactHub page.
  https://artifacthub.io/packages/helm/cert-manager/cert-manager

The example below shows how to tune the cert-manager installation by overwriting the default Helm values:


helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.11.0 \
  # --set installCRDs=true
  --set prometheus.enabled=false \  # Example: disabling prometheus using a Helm parameter
  --set webhook.timeoutSeconds=4   # Example: changing the webhook timeout using a Helm parameter
Once you have deployed cert-manager, you can verify the installation.



https://cert-manager.io/docs/tutorials/acme/nginx-ingress/
https://cert-manager.io/docs/tutorials/acme/nginx-ingress/
Step 2 - Deploy the NGINX Ingress Controller
A kubernetes ingress controller is designed to be the access point for HTTP and HTTPS traffic to the software running within your cluster. The ingress-nginx-controller does this by providing an HTTP proxy service supported by your cloud provider's load balancer.


You can get more details about ingress-nginx and how it works from the documentation for ingress-nginx.

Add the latest helm repository for the ingress-nginx


helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx



https://github.com/cert-manager/cert-manager

cert-manager adds certificates and certificate issuers as resource types in Kubernetes clusters, and simplifies the process of obtaining, renewing and using those certificates.

It supports issuing certificates from a variety of sources, including Let's Encrypt (ACME), HashiCorp Vault, and Venafi TPP / TLS Protect Cloud, as well as local in-cluster issuance.

cert-manager also ensures certificates remain valid and up to date, attempting to renew certificates at an appropriate time before expiry to reduce the risk of outages and remove toil.

https://cert-manager.io/docs/

It can issue certificates from a variety of supported sources, including Let's Encrypt, HashiCorp Vault, and Venafi as well as private PKI.

It will ensure certificates are valid and up to date, and attempt to renew certificates at a configured time before expiry.

It is loosely based upon the work of kube-lego and has borrowed some wisdom from other similar projects such as kube-cert-manager.




