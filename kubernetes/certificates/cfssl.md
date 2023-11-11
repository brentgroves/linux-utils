https://blog.cloudflare.com/introducing-cfssl/
https://github.com/cloudflare/cfssl
CloudFlare's PKI/TLS toolkit
CFSSL is CloudFlare's PKI/TLS swiss army knife. It is both a command line tool and an HTTP API server for signing, verifying, and bundling TLS certificates. It requires Go 1.16+ to build.

Note that certain linux distributions have certain algorithms removed (RHEL-based distributions in particular), so the golang from the official repositories will not work. Users of these distributions should install go manually to install CFSSL.

https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
Requesting a certificate
The following section demonstrates how to create a TLS certificate for a Kubernetes service accessed through DNS.

Note: This tutorial uses CFSSL: Cloudflare's PKI and TLS toolkit click here to know more.


$ go install github.com/cloudflare/cfssl/cmd/...@latest

   sign             signs a certificate
   bundle           build a certificate bundle
   genkey           generate a private key and a certificate request
   gencert          generate a private key and a certificate
   serve            start the API server
   version          prints out the current version
   selfsign         generates a self-signed certificate
   print-defaults   print default configurations


