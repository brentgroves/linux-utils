https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/
CertificateSigningRequest
https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/

Certificate Signing Requests
FEATURE STATE: Kubernetes v1.19 [stable]
The Certificates API enables automation of X.509 credential provisioning by providing a programmatic interface for clients of the Kubernetes API to request and obtain X.509 certificates from a Certificate Authority (CA).

A CertificateSigningRequest (CSR) resource is used to request that a certificate be signed by a denoted signer, after which the request may be approved or denied before finally being signed.

Request signing process
The CertificateSigningRequest resource type allows a client to ask for an X.509 certificate be issued, based on a signing request. The CertificateSigningRequest object includes a PEM-encoded PKCS#10 signing request in the spec.request field. The CertificateSigningRequest denotes the signer (the recipient that the request is being made to) using the spec.signerName field. Note that spec.signerName is a required key after API version certificates.k8s.io/v1. In Kubernetes v1.22 and later, clients may optionally set the spec.expirationSeconds field to request a particular lifetime for the issued certificate. The minimum valid value for this field is 600, i.e. ten minutes.

Once created, a CertificateSigningRequest must be approved before it can be signed. Depending on the signer selected, a CertificateSigningRequest may be automatically approved by a controller. Otherwise, a CertificateSigningRequest must be manually approved either via the REST API (or client-go) or by running kubectl certificate approve. Likewise, a CertificateSigningRequest may also be denied, which tells the configured signer that it must not sign the request.

For certificates that have been approved, the next step is signing. The relevant signing controller first validates that the signing conditions are met and then creates a certificate. The signing controller then updates the CertificateSigningRequest, storing the new certificate into the status.certificate field of the existing CertificateSigningRequest object. The status.certificate field is either empty or contains a X.509 certificate, encoded in PEM format. The CertificateSigningRequest status.certificate field is empty until the signer does this.

Once the status.certificate field has been populated, the request has been completed and clients can now fetch the signed certificate PEM data from the CertificateSigningRequest resource. The signers can instead deny certificate signing if the approval conditions are not met.

In order to reduce the number of old CertificateSigningRequest resources left in a cluster, a garbage collection controller runs periodically. The garbage collection removes CertificateSigningRequests that have not changed state for some duration:

Approved requests: automatically deleted after 1 hour
Denied requests: automatically deleted after 1 hour
Failed requests: automatically deleted after 1 hour
Pending requests: automatically deleted after 24 hours
All requests: automatically deleted after the issued certificate has expired


Signers
Custom signerNames can also be specified. All signers should provide information about how they work so that clients can predict what will happen to their CSRs. This includes:

Trust distribution: how trust (CA bundles) are distributed.
Permitted subjects: any restrictions on and behavior when a disallowed subject is requested.
Permitted x509 extensions: including IP subjectAltNames, DNS subjectAltNames, Email subjectAltNames, URI subjectAltNames etc, and behavior when a disallowed extension is requested.
Permitted key usages / extended key usages: any restrictions on and behavior when usages different than the signer-determined usages are specified in the CSR.
Expiration/certificate lifetime: whether it is fixed by the signer, configurable by the admin, determined by the CSR spec.expirationSeconds field, etc and the behavior when the signer-determined expiration is different from the CSR spec.expirationSeconds field.
CA bit allowed/disallowed: and behavior if a CSR contains a request a for a CA certificate when the signer does not permit it.

Kubernetes signers
Kubernetes provides built-in signers that each have a well-known signerName:

kubernetes.io/kube-apiserver-client: signs certificates that will be honored as client certificates by the API server. Never auto-approved by kube-controller-manager.

Trust distribution: signed certificates must be honored as client certificates by the API server. The CA bundle is not distributed by any other means.
Permitted subjects - no subject restrictions, but approvers and signers may choose not to approve or sign. Certain subjects like cluster-admin level users or groups vary between distributions and installations, but deserve additional scrutiny before approval and signing. The CertificateSubjectRestriction admission plugin is enabled by default to restrict system:masters, but it is often not the only cluster-admin subject in a cluster.
Permitted x509 extensions - honors subjectAltName and key usage extensions and discards other extensions.
Permitted key usages - must include ["client auth"]. Must not include key usages beyond ["digital signature", "key encipherment", "client auth"].
Expiration/certificate lifetime - for the kube-controller-manager implementation of this signer, set to the minimum of the --cluster-signing-duration option or, if specified, the spec.expirationSeconds field of the CSR object.
CA bit allowed/disallowed - not allowed.

kubernetes.io/kube-apiserver-client-kubelet: signs client certificates that will be honored as client certificates by the API server. May be auto-approved by kube-controller-manager.

Trust distribution: signed certificates must be honored as client certificates by the API server. The CA bundle is not distributed by any other means.
Permitted subjects - organizations are exactly ["system:nodes"], common name starts with "system:node:".
Permitted x509 extensions - honors key usage extensions, forbids subjectAltName extensions and drops other extensions.
Permitted key usages - exactly ["key encipherment", "digital signature", "client auth"].
Expiration/certificate lifetime - for the kube-controller-manager implementation of this signer, set to the minimum of the --cluster-signing-duration option or, if specified, the spec.expirationSeconds field of the CSR object.
CA bit allowed/disallowed - not allowed.

kubernetes.io/kubelet-serving: signs serving certificates that are honored as a valid kubelet serving certificate by the API server, but has no other guarantees. Never auto-approved by kube-controller-manager.

Trust distribution: signed certificates must be honored by the API server as valid to terminate connections to a kubelet. The CA bundle is not distributed by any other means.
Permitted subjects - organizations are exactly ["system:nodes"], common name starts with "system:node:".
Permitted x509 extensions - honors key usage and DNSName/IPAddress subjectAltName extensions, forbids EmailAddress and URI subjectAltName extensions, drops other extensions. At least one DNS or IP subjectAltName must be present.
Permitted key usages - exactly ["key encipherment", "digital signature", "server auth"].
Expiration/certificate lifetime - for the kube-controller-manager implementation of this signer, set to the minimum of the --cluster-signing-duration option or, if specified, the spec.expirationSeconds field of the CSR object.
CA bit allowed/disallowed - not allowed.
kubernetes.io/legacy-unknown: has no guarantees for trust at all. Some third-party distributions of Kubernetes may honor client certificates signed by it. The stable CertificateSigningRequest API (version certificates.k8s.io/v1 and later) does not allow to set the signerName as kubernetes.io/legacy-unknown. Never auto-approved by kube-controller-manager.

Trust distribution: None. There is no standard trust or distribution for this signer in a Kubernetes cluster.
Permitted subjects - any
Permitted x509 extensions - honors subjectAltName and key usage extensions and discards other extensions.
Permitted key usages - any
Expiration/certificate lifetime - for the kube-controller-manager implementation of this signer, set to the minimum of the --cluster-signing-duration option or, if specified, the spec.expirationSeconds field of the CSR object.
CA bit allowed/disallowed - not allowed.
Note: Failures for all of these are only reported in kube-controller-manager logs.


Authorization
To allow creating a CertificateSigningRequest and retrieving any CertificateSigningRequest:

Verbs: create, get, list, watch, group: certificates.k8s.io, resource: certificatesigningrequests
For example:

access/certificate-signing-request/clusterrole-create.yaml Copy access/certificate-signing-request/clusterrole-create.yaml to clipboard
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: csr-creator
rules:
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests
  verbs:
  - create
  - get
  - list
  - watch
To allow approving a CertificateSigningRequest:

Verbs: get, list, watch, group: certificates.k8s.io, resource: certificatesigningrequests
Verbs: update, group: certificates.k8s.io, resource: certificatesigningrequests/approval
Verbs: approve, group: certificates.k8s.io, resource: signers, resourceName: <signerNameDomain>/<signerNamePath> or <signerNameDomain>/*


For example:

access/certificate-signing-request/clusterrole-approve.yaml Copy access/certificate-signing-request/clusterrole-approve.yaml to clipboard
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: csr-approver
rules:
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests/approval
  verbs:
  - update
- apiGroups:
  - certificates.k8s.io
  resources:
  - signers
  resourceNames:
  - example.com/my-signer-name # example.com/* can be used to authorize for all signers in the 'example.com' domain
  verbs:
  - approve

To allow signing a CertificateSigningRequest:

Verbs: get, list, watch, group: certificates.k8s.io, resource: certificatesigningrequests
Verbs: update, group: certificates.k8s.io, resource: certificatesigningrequests/status
Verbs: sign, group: certificates.k8s.io, resource: signers, resourceName: <signerNameDomain>/<signerNamePath> or <signerNameDomain>/*

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: csr-signer
rules:
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests/status
  verbs:
  - update
- apiGroups:
  - certificates.k8s.io
  resources:
  - signers
  resourceNames:
  - example.com/my-signer-name # example.com/* can be used to authorize for all signers in the 'example.com' domain
  verbs:
  - sign

 Normal user
A few steps are required in order to get a normal user to be able to authenticate and invoke an API. First, this user must have a certificate issued by the Kubernetes cluster, and then present that certificate to the Kubernetes API.

Create private key
The following scripts show how to generate PKI private key and CSR. It is important to set CN and O attribute of the CSR. CN is the name of the user and O is the group that this user will belong to. You can refer to RBAC for standard groups.

openssl genrsa -out myuser.key 2048
openssl req -new -key myuser.key -out myuser.csr
 
 How to create a CSR with OpenSSL
OpenSSL is available on many platforms (for Windows binaries e.g., see http://www.openssl.org/related/binaries.html") and can be used to generate a key pair and a CSR. The most convenient way, in our opinion, is to write a short OpenSSL configuration file which you feed to the openssl req command afterwards (but feel free to use an alternative procedure if you prefer).

Create a text file named myserver.cnf (where myserver is supposed to denote the name/FQDN of your server) with the following content:

# OpenSSL configuration file for creating a CSR for a server certificate
# Adapt at least the FQDN and ORGNAME lines, and then run 
# openssl req -new -config myserver.cnf -keyout myserver.key -out myserver.csr
# on the command line.

# the fully qualified server (or service) name
FQDN = foo.example.org

# the name of your organization
# (see also https://www.switch.ch/pki/participants/)
ORGNAME = Example University

# subjectAltName entries: to add DNS aliases to the CSR, delete
# the '#' character in the ALTNAMES line, and change the subsequent
# 'DNS:' entries accordingly. Please note: all DNS names must
# resolve to the same IP address as the FQDN.
ALTNAMES = DNS:$FQDN   # , DNS:bar.example.org , DNS:www.foo.example.org

# --- no modifications required below ---
[ req ]
default_bits = 2048
default_md = sha256
prompt = no
encrypt_key = no
distinguished_name = dn
req_extensions = req_ext

[ dn ]
C = CH
O = $ORGNAME
CN = $FQDN

[ req_ext ]
subjectAltName = $ALTNAMES
The CN attribute is the only attribute which must always be specified in a CSR for a SWITCHpki server certificate. All other attributes are optional (as far as the CSR is concerned), but some of them will automatically be added to the issued certificate, if needed: C (countryName), ST (stateOrProvinceName), L (localityName) and O (organizationName). If desired, an OU (organizationalUnit) attribute can be included in the request.

The CN attribute must be set to the fully qualified domain name of your server - i.e. www.example.com, www.subdomain.example.com or similar. The ALTNAMES line can be used to specify subjectAltName entries if you prefer specifying them this way (otherwise, simply use the text field on the enrollment form).

Then, after having saved the myserver.cnf file, create the key pair and the CSR with the following command(s):

$ touch myserver.key
$ chmod 600 myserver.key
$ openssl req -new -config myserver.cnf -keyout myserver.key -out myserver.csr
This will create a 2048-bit RSA key pair, store the private key in the file myserver.key and write the CSR to the file myserver.csr. The private key is stored with no passphrase. Changing the permissions to 600 (i.e. -rw-------) restricts access to the (confidential) private key to the owner of the file (on a non-UNIX system, use a directory with restrictive file ACLs or equivalent).

The CSR can then be submitted through the SWITCHpki QuoVadis certificate request form.

To examine your CSR, use the following command (prints subject, public key and requested extensions, if present):

$ openssl req -in myserver.csr -noout -text -nameopt sep_multiline


Create private key
The following scripts show how to generate PKI private key and CSR. It is important to set CN and O attribute of the CSR. CN is the name of the user and O is the group that this user will belong to. You can refer to RBAC for standard groups.

openssl genrsa -out myuser.key 2048
openssl req -new -key myuser.key -out myuser.csr
Create CertificateSigningRequest
Create a CertificateSigningRequest and submit it to a Kubernetes Cluster via kubectl. Below is a script to generate the CertificateSigningRequest.

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: myuser
spec:
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZVzVuWld4aE1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQTByczhJTHRHdTYxakx2dHhWTTJSVlRWMDNHWlJTWWw0dWluVWo4RElaWjBOCnR2MUZtRVFSd3VoaUZsOFEzcWl0Qm0wMUFSMkNJVXBGd2ZzSjZ4MXF3ckJzVkhZbGlBNVhwRVpZM3ExcGswSDQKM3Z3aGJlK1o2MVNrVHF5SVBYUUwrTWM5T1Nsbm0xb0R2N0NtSkZNMUlMRVI3QTVGZnZKOEdFRjJ6dHBoaUlFMwpub1dtdHNZb3JuT2wzc2lHQ2ZGZzR4Zmd4eW8ybmlneFNVekl1bXNnVm9PM2ttT0x1RVF6cXpkakJ3TFJXbWlECklmMXBMWnoyalVnald4UkhCM1gyWnVVV1d1T09PZnpXM01LaE8ybHEvZi9DdS8wYk83c0x0MCt3U2ZMSU91TFcKcW90blZtRmxMMytqTy82WDNDKzBERHk5aUtwbXJjVDBnWGZLemE1dHJRSURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBR05WdmVIOGR4ZzNvK21VeVRkbmFjVmQ1N24zSkExdnZEU1JWREkyQTZ1eXN3ZFp1L1BVCkkwZXpZWFV0RVNnSk1IRmQycVVNMjNuNVJsSXJ3R0xuUXFISUh5VStWWHhsdnZsRnpNOVpEWllSTmU3QlJvYXgKQVlEdUI5STZXT3FYbkFvczFqRmxNUG5NbFpqdU5kSGxpT1BjTU1oNndLaTZzZFhpVStHYTJ2RUVLY01jSVUyRgpvU2djUWdMYTk0aEpacGk3ZnNMdm1OQUxoT045UHdNMGM1dVJVejV4T0dGMUtCbWRSeEgvbUNOS2JKYjFRQm1HCkkwYitEUEdaTktXTU0xMzhIQXdoV0tkNjVoVHdYOWl4V3ZHMkh4TG1WQzg0L1BHT0tWQW9FNkpsYWFHdTlQVmkKdjlOSjVaZlZrcXdCd0hKbzZXdk9xVlA3SVFjZmg3d0drWm89Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF

Some points to note:

usages has to be 'client auth'

expirationSeconds could be made longer (i.e. 864000 for ten days) or shorter (i.e. 3600 for one hour)

request is the base64 encoded value of the CSR file content. You can get the content using this command:

cat myuser.csr | base64 | tr -d "\n"

Approve certificate signing request
Use kubectl to create a CSR and approve it.

Get the list of CSRs:

kubectl get csr
Approve the CSR:

kubectl certificate approve myuser


Get the certificate
Retrieve the certificate from the CSR:

kubectl get csr/myuser -o yaml
The certificate value is in Base64-encoded format under status.certificate.

Export the issued certificate from the CertificateSigningRequest.

kubectl get csr myuser -o jsonpath='{.status.certificate}'| base64 -d > myuser.crt

Create Role and RoleBinding
With the certificate created it is time to define the Role and RoleBinding for this user to access Kubernetes cluster resources.

This is a sample command to create a Role for this new user:

kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods

This is a sample command to create a RoleBinding for this new user:

kubectl create rolebinding developer-binding-myuser --role=developer --user=myuser

Add to kubeconfig
The last step is to add this user into the kubeconfig file.

First, you need to add new credentials:

kubectl config set-credentials myuser --client-key=myuser.key --client-certificate=myuser.crt --embed-certs=true

Add to kubeconfig
The last step is to add this user into the kubeconfig file.

First, you need to add new credentials:

kubectl config set-credentials myuser --client-key=myuser.key --client-certificate=myuser.crt --embed-certs=true

Then, you need to add the context:

kubectl config set-context myuser --cluster=kubernetes --user=myuser

To test it, change the context to myuser:

kubectl config use-context myuser
Approval or rejection
Control plane automated approval
The kube-controller-manager ships with a built-in approver for certificates with a signerName of kubernetes.io/kube-apiserver-client-kubelet that delegates various permissions on CSRs for node credentials to authorization. The kube-controller-manager POSTs SubjectAccessReview resources to the API server in order to check authorization for certificate approval.

Approval or rejection using kubectl
A Kubernetes administrator (with appropriate permissions) can manually approve (or deny) CertificateSigningRequests by using the kubectl certificate approve and kubectl certificate deny commands.

To approve a CSR with kubectl:

kubectl certificate approve <certificate-signing-request-name>
Likewise, to deny a CSR:

kubectl certificate deny <certificate-signing-request-name>


Create a CertificateSigningRequest object to send to the Kubernetes API
Generate a CSR manifest (in YAML), and send it to the API server. You can do that by running the following command:

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: my-svc.my-namespace
spec:
  request: $(cat server.csr | base64 | tr -d '\n')
  signerName: example.com/serving
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF
Notice that the server.csr file created in step 1 is base64 encoded and stashed in the .spec.request field. You are also requesting a certificate with the "digital signature", "key encipherment", and "server auth" key usages, signed by an example example.com/serving signer. A specific signerName must be requested. View documentation for supported signer names for more information.

The CSR should now be visible from the API in a Pending state. You can see it by running:

kubectl describe csr my-svc.my-namespace