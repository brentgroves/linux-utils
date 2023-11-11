https://blog.cloudflare.com/introducing-cfssl/
https://computingforgeeks.com/build-pki-ca-for-certificates-management-with-cloudflare-cfssl/
https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
https://github.com/kelseyhightower/kubernetes-the-hard-way

git clone git@github.com:brentgroves/cfssl-test.git
pushd ~/src/cffssl-test
Build Private PKI/TLS CA for Certificates Management With CloudFlare CFSSL
CloudFlare’s PKI/TLS toolkit
Adapted from CFSSL GitHub page, CFSSL is CloudFlare’s open source PKI/TLS swiss army knife. It is both a command line tool and an HTTP API server for signing, verifying, and bundling TLS certificates. Getting the correct bundle together is a black art, and can quickly become a debugging nightmare if it’s not done correctly. CloudFlare wrote CFSSL to make bundling easier. By picking the right chain of certificates, CFSSL solves the balancing act between performance, security, and compatibility.

SSL certificates bind domain names to server names, and company names to locations thus forming the core of trust on the web by assuring the identity of websites. In other words, the certificate contains the server name, the trusted certificate authority (CA) that vouches for the authenticity of the certificate, and the server’s public encryption key.