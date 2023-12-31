https://certificatedecoder.dev/
https://www.esri.com/arcgis-blog/products/bus-analyst/field-mobility/learn-how-to-download-a-ssl-certificate-for-a-secured-portal/

What is an X.509 certificate?
An X.509 certificate is an electronic document that proves the ownership of a cryptographic public key. The certificate includes information about the key, its owner (subject), issuer, and the digital signature of the issuer that verifies the content of the certificate. If the certificate signature is valid and the software trusts the issuer, then the public key can be used to communicate securely with the certificate subject. The most common format for a certificate is defined in the X.509 standard and further detailed in RFC 5280.

How are certificates issued?
In public key infrastructure (PKI), the certificate is issued by a certificate authority (CA) that is usually a company that charges its customers for issuing certificates for them. Certificates can also be issued by individuals in a web of trust scheme.

What are the uses of a certificate?
A certificate can be used for Transport Layer Security (TLS) over HTTPS, email encryption, code signing, digital signatures and other purposes. A certificate can have one or more purposes.

What is the structure of a certificate?
The structure of an X.509 certificate is as follows:
Certificate
Version
Serial Number
Signature Algorithm
Issuer
Validity period
Not Before
Not After
Subject
Subject Public Key Info
Subject Public Key Algorithm
Subject Public Key
Issuer Unique Identifier (optional, v2+)
Subject Unique Identifier (optional, v2+)
Extensions (optional, v3)
...
Certificate Signature Algorithm
Certificate Signature
Note: Thumbprints are not part of the encoded certificate. They are generated by calculating the hash of the encoded certificate.


