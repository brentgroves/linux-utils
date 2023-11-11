https://certificatedecoder.dev/

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


Mobex certificate:
Issued To: CN=mobexglobal.com
Issued By: C=US, ST=TX, L=Houston, O=cPanel, Inc., CN=cPanel, Inc. Certification Authority
Serial Number: 18 ff f8 09 07 9e 23 dc 93 0a 3b 72 28 3a 39 dc
Issued On: Mon Jan 30 2023 19:00:00 GMT-0500 (Eastern Standard Time)
Expires On: Mon May 01 2023 19:59:59 GMT-0400 (Eastern Daylight Time)
SHA-256 Fingerprint: 81 32 d2 7a 5c 10 54 de 3b 1e 21 25 a1 86 f1 77 7d 6f 09 e9 1d 5d 89 9a 09 af e6 28 3f 29 b8 8c
SHA-1 Fingerprint: 58 7f 3b 8a 56 bc ef 8e 28 d2 92 ff 7b 29 07 7e b9 f9 5f 3f

Public Key:
Modulus: dd 0f ff 99 15 30 ae 13 3f 8e bf 3d a5 ab ab 45 d2 7a 0a 73 92 16 19 99 43 b6 d3 ed 7b 8d 5c 6d 81 3c 0a 23 fa 5e a3 2c 43 6c 50 8a 9b 5e 6f 21 03 4b 0f dd 18 7c 21 0b 4d 27 21 5a ed 49 1b 70 1c 7e 4c 7e 71 cf be 03 35 5e 21 4b b3 65 38 8b b0 ee bd 1e ee eb 71 4a 3b dd d6 04 46 26 d0 8b b3 26 c6 88 96 9c b6 a2 14 14 d6 19 ad b1 33 76 16 db 28 27 83 1e ff 38 8f 56 a2 e6 9e 37 12 80 1d 79 28 ae 8e 8c 87 66 ae a3 89 bb 51 b3 82 3b 20 58 95 58 8e 6a 4b 35 e3 c9 a4 59 a3 b7 3a 12 13 0d d5 d0 50 af 18 95 4d 01 13 36 4b 5f be cf 97 57 53 e4 f8 88 c0 93 62 b3 a1 4e 6b 1c 7d ae 0c 31 eb 4a 8d c0 19 f2 a0 a4 7a c4 04 11 97 ad 6f 9d eb 01 8b 82 f4 6f ef a2 46 c7 d7 0a 23 d6 79 f4 e0 f8 4b 54 63 a6 bc 8f eb 71 ce dc 06 e6 07 65 46 25 cf 27 fd dc 35 d7 cc 7d f9 1c 8f 8b
Exponent: 01 00 01

-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3Q//mRUwrhM/jr89paur
RdJ6CnOSFhmZQ7bT7XuNXG2BPAoj+l6jLENsUIqbXm8hA0sP3Rh8IQtNJyFa7Ukb
cBx+TH5xz74DNV4hS7NlOIuw7r0e7utxSjvd1gRGJtCLsybGiJactqIUFNYZrbEz
dhbbKCeDHv84j1ai5p43EoAdeSiujoyHZq6jibtRs4I7IFiVWI5qSzXjyaRZo7c6
EhMN1dBQrxiVTQETNktfvs+XV1Pk+IjAk2KzoU5rHH2uDDHrSo3AGfKgpHrEBBGX
rW+d6wGLgvRv76JGx9cKI9Z59OD4S1RjpryP63HO3AbmB2VGJc8n/dw118x9+RyP
iwIDAQAB
-----END PUBLIC KEY-----