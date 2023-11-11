https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/

Even though the custom CA certificate may be included in the filesystem (in the ConfigMap kube-root-ca.crt), you should not use that certificate authority for any purpose other than to verify internal Kubernetes endpoints. An example of an internal Kubernetes endpoint is the Service named kubernetes in the default namespace.

If you want to use a custom certificate authority for your workloads, you should generate that CA separately, and distribute its CA certificate using a ConfigMap that your pods have access to read.

Requesting a certificate
The following section demonstrates how to create a TLS certificate for a Kubernetes service accessed through DNS.

Note: This tutorial uses CFSSL: Cloudflare's PKI and TLS toolkit click here to know more.

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