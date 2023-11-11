
https://blog.cloudflare.com/introducing-cfssl/
https://www.youtube.com/watch?v=jsD_lAE8Odg
https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md

![certificate chain](https://blog.cloudflare.com/content/images/image01_4.png)

pushd ~/src/linux-utils/cloudflare-cfssl/kubernetes-the-hardway

https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md#certificate-authority

Certificate Authority
In this section you will provision a Certificate Authority that can be used to generate additional TLS certificates.

{

cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca

}

Results:

ca-key.pem
ca.pem

cfssl gencert --help 
cfssl ls
cfssl print-defaults csr
cfssl print-defaults config

cfssl gencert -initca ca-csr.json
This gives you all 3 certificates but we want each certificate in a separate file.
cfssljson --help
cfssl gencert -initca ca-csr.json | cfssljson -bare ca

2023/03/31 15:40:50 [INFO] generating a new CA key and certificate from CSR
2023/03/31 15:40:50 [INFO] generate received request
2023/03/31 15:40:50 [INFO] received CSR
2023/03/31 15:40:50 [INFO] generating key: rsa-2048
2023/03/31 15:40:51 [INFO] encoded CSR
2023/03/31 15:40:51 [INFO] signed certificate with serial number 595408172640289122691190423472144634592996419026
# we now have 3 files generated
ls
ca.csr  ca-key.pem  ca.pem

https://lapo.it/asn1js/
look at the certificate generated
xclip -selection clipboard -i < 'ca.pem'

openssl x509 -in ca.pem -text

cfssl gencert --help
cfssl gencert -ca cert -ca-key key [-config config] [-profile profile] [-hostname hostname] CSRJSON

cfssl gencert -ca cert -ca-key key