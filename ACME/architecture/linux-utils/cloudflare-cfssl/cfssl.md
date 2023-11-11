https://blog.cloudflare.com/introducing-cfssl/
https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
https://www.youtube.com/watch?v=jsD_lAE8Odg
https://github.com/kelseyhightower/kubernetes-the-hard-way
https://github.com/cloudflare/cfssl

https://blog.cloudflare.com/introducing-cfssl/
https://github.com/cloudflare/cfssl
CloudFlare's PKI/TLS toolkit
CFSSL is CloudFlare's PKI/TLS swiss army knife. It is both a command line tool and an HTTP API server for signing, verifying, and bundling TLS certificates. It requires Go 1.16+ to build.

Note that certain linux distributions have certain algorithms removed (RHEL-based distributions in particular), so the golang from the official repositories will not work. Users of these distributions should install go manually to install CFSSL.

go install github.com/cloudflare/cfssl/cmd/...@latest
this command installs the programs to ~/go/bin which has been added to our path.


CloudFlare's PKI/TLS toolkit
CFSSL is CloudFlare's PKI/TLS swiss army knife. It is both a command line tool and an HTTP API server for signing, verifying, and bundling TLS certificates. It requires Go 1.16+ to build.

Note that certain linux distributions have certain algorithms removed (RHEL-based distributions in particular), so the golang from the official repositories will not work. Users of these distributions should install go manually to install CFSSL.

CFSSL consists of:

a set of packages useful for building custom TLS PKI tools
the cfssl program, which is the canonical command line utility using the CFSSL packages.
the multirootca program, which is a certificate authority server that can use multiple signing keys.
the mkbundle program is used to build certificate pool bundles.
the cfssljson program, which takes the JSON output from the cfssl and multirootca programs and writes certificates, keys, CSRs, and bundles to disk.


Using the Command Line Tool
The cfssl command line tool takes a command to specify what operation it should carry out:

   sign             signs a certificate
   bundle           build a certificate bundle
   genkey           generate a private key and a certificate request
   gencert          generate a private key and a certificate
   serve            start the API server
   version          prints out the current version
   selfsign         generates a self-signed certificate
   print-defaults   print default configurations

   https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/

   https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
Create a certificate signing request
Generate a private key and certificate signing request (or CSR) by running the following command:

cat <<EOF | cfssl genkey - | cfssljson -bare server
{
  "hosts": [
    "my-svc.my-namespace.svc.cluster.local",
    "my-pod.my-namespace.pod.cluster.local",
    "192.0.2.24",
    "10.0.34.2"
  ],
  "CN": "my-pod.my-namespace.pod.cluster.local",
  "key": {
    "algo": "ecdsa",
    "size": 256
  }
}
EOF

Where 192.0.2.24 is the service's cluster IP, my-svc.my-namespace.svc.cluster.local is the service's DNS name, 10.0.34.2 is the pod's IP and my-pod.my-namespace.pod.cluster.local is the pod's DNS name. You should see the output similar to:

2022/02/01 11:45:32 [INFO] generate received request
2022/02/01 11:45:32 [INFO] received CSR
2022/02/01 11:45:32 [INFO] generating key: ecdsa-256
2022/02/01 11:45:32 [INFO] encoded CSR
This command generates two files; it generates server.csr containing the PEM encoded PKCS#10 certification request, and server-key.pem containing the PEM encoded key to the certificate that is still to be created.


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

Name:                   my-svc.my-namespace
Labels:                 <none>
Annotations:            <none>
CreationTimestamp:      Tue, 01 Feb 2022 11:49:15 -0500
Requesting User:        yourname@example.com
Signer:                 example.com/serving
Status:                 Pending
Subject:
        Common Name:    my-pod.my-namespace.pod.cluster.local
        Serial Number:
Subject Alternative Names:
        DNS Names:      my-pod.my-namespace.pod.cluster.local
                        my-svc.my-namespace.svc.cluster.local
        IP Addresses:   192.0.2.24
                        10.0.34.2
Events: <none>


Get the CertificateSigningRequest approved
Approving the certificate signing request is either done by an automated approval process or on a one off basis by a cluster administrator. If you're authorized to approve a certificate request, you can do that manually using kubectl; for example:

kubectl certificate approve my-svc.my-namespace
certificatesigningrequest.certificates.k8s.io/my-svc.my-namespace approved
You should now see the following:

kubectl get csr
NAME                  AGE   SIGNERNAME            REQUESTOR              REQUESTEDDURATION   CONDITION
my-svc.my-namespace   10m   example.com/serving   yourname@example.com   <none>              Approved
This means the certificate request has been approved and is waiting for the requested signer to sign it.

Sign the CertificateSigningRequest
Next, you'll play the part of a certificate signer, issue the certificate, and upload it to the API.

A signer would typically watch the CertificateSigningRequest API for objects with its signerName, check that they have been approved, sign certificates for those requests, and update the API object status with the issued certificate.

Create a Certificate Authority 
You need an authority to provide the digital signature on the new certificate.

First, create a signing certificate by running the following:

cat <<EOF | cfssl gencert -initca - | cfssljson -bare ca
{
  "CN": "My Example Signer",
  "key": {
    "algo": "rsa",
    "size": 2048
  }
}
EOF


