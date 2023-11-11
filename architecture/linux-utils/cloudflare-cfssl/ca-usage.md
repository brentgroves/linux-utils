[CloudFlare CFSSL](https://www.genome.gov/)
https://blog.cloudflare.com/introducing-cfssl/

![Certificate Bundle](https://blog.cloudflare.com/content/images/image01_4.png)


# generate a certificate signed by the Mobex CA root certificate

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  reports51-csr.json | cfssljson -bare reports51

# output

cfssl gencert -remote="localhost:8888" -config ca-config.json -profile kubernetes admin-csr.json | cfssljson -bare admin2