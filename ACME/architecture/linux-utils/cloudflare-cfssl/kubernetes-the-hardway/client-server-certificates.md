https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md#client-and-server-certificates

pushd ~/src/linux-utils/cloudflare-cfssl/kubernetes-the-hardway

Client and Server Certificates
In this section you will generate client and server certificates for each Kubernetes component and a client certificate for the Kubernetes admin user.

The Admin Client Certificate
Generate the admin client certificate and private key:

{

cat > admin-csr.json <<EOF
{
  "CN": "admin",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:masters",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  admin-csr.json | cfssljson -bare admin

}


cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  admin-csr.json | cfssljson -bare admin

Results:

admin-key.pem
admin.pem

2023/03/31 16:22:31 [INFO] generate received request
2023/03/31 16:22:31 [INFO] received CSR
2023/03/31 16:22:31 [INFO] generating key: rsa-2048
2023/03/31 16:22:31 [INFO] encoded CSR
2023/03/31 16:22:31 [INFO] signed certificate with serial number 159987284785078996581825489954735525603168112305
2023/03/31 16:22:31 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").


https://blog.cloudflare.com/introducing-cfssl/


cfssl serve -address=localhost -port=8888 -ca-key=ca-key.pem -ca=ca.pem

pushd ~/src/linux-utils/cloudflare-cfssl/kubernetes-the-hardway/repeat-using-server
cfssl gencert -remote="localhost:8888" -config ca-config.json -profile kubernetes admin-csr.json | cfssljson -bare admin2