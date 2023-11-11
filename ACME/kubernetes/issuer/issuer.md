https://cert-manager.io/docs/concepts/issuer/
https://cert-manager.io/docs/configuration/acme/

https://cert-manager.io/docs/tutorials/acme/nginx-ingress/#step-6---configure-a-lets-encrypt-issuer

Step 6 - Configure a Let's Encrypt Issuer
We'll set up two issuers for Let's Encrypt in this example: staging and production.

The Let's Encrypt production issuer has very strict rate limits. When you're experimenting and learning, it can be very easy to hit those limits. Because of that risk, we'll start with the Let's Encrypt staging issuer, and once we're happy that it's working we'll switch to the production issuer.

Note that you'll see a warning about untrusted certificates from the staging issuer, but that's totally expected.




Issuer
Issuers, and ClusterIssuers, are Kubernetes resources that represent certificate authorities (CAs) that are able to generate signed certificates by honoring certificate signing requests. All cert-manager certificates require a referenced issuer that is in a ready condition to attempt to honor the request.

An example of an Issuer type is CA. A simple CA Issuer is as follows:

apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: ca-issuer
  namespace: mesh-system
spec:
  ca:
    secretName: ca-key-pair
This is a simple Issuer that will sign certificates based on a private key. The certificate stored in the secret ca-key-pair can then be used to trust newly signed certificates by this Issuer in a Public Key Infrastructure (PKI) system.

Namespaces
An Issuer is a namespaced resource, and it is not possible to issue certificates from an Issuer in a different namespace. This means you will need to create an Issuer in each namespace you wish to obtain Certificates in.

If you want to create a single Issuer that can be consumed in multiple namespaces, you should consider creating a ClusterIssuer resource. This is almost identical to the Issuer resource, however is non-namespaced so it can be used to issue Certificates across all namespaces.

Supported Issuers
cert-manager supports a number of 'in-tree', as well as 'out-of-tree' Issuer types. An exhaustive list of these Issuer types can be found in the cert-manager configuration documentation.

Issuer Configuration
The first thing you'll need to configure after you've installed cert-manager is an Issuer or a ClusterIssuer. These are resources that represent certificate authorities (CAs) able to sign certificates in response to certificate signing requests.

This section documents how the different issuer types can be configured. You might want to read more about Issuer and ClusterIssuer resources.

cert-manager comes with a number of built-in certificate issuers which are denoted by being in the cert-manager.io group. You can also install external issuers in addition to the built-in types. Built-in and external issuers are treated the same and are configured similarly.