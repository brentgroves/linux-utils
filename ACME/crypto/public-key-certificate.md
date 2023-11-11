https://en.wikipedia.org/wiki/Public_key_certificate
In cryptography, a public key certificate, also known as a digital certificate or identity certificate, is an electronic document used to prove the validity of a public key.[1][2] The certificate includes information about the key, information about the identity of its owner (called the subject), and the digital signature of an entity that has verified the certificate's contents (called the issuer). If the signature is valid, and the software examining the certificate trusts the issuer, then it can use that key to communicate securely with the certificate's subject. In email encryption, code signing, and e-signature systems, a certificate's subject is typically a person or organization. However, in Transport Layer Security (TLS) a certificate's subject is typically a computer or other device, though TLS certificates may identify organizations or individuals in addition to their core role in identifying devices. TLS, sometimes called by its older name Secure Sockets Layer (SSL), is notable for being a part of HTTPS, a protocol for securely browsing the web.

In a typical public-key infrastructure (PKI) scheme, the certificate issuer is a certificate authority (CA),[3] usually a company that charges customers to issue certificates for them. By contrast, in a web of trust scheme, individuals sign each other's keys directly, in a format that performs a similar function to a public key certificate.

The most common format for public key certificates is defined by X.509.[4] Because X.509 is very general, the format is further constrained by profiles defined for certain use cases, such as Public Key Infrastructure (X.509) as defined in RFC 5280.

Types of certificate

The roles of root certificate, intermediate certificate and end-entity certificate as in the chain of trust.
TLS/SSL server certificate
The Transport Layer Security (TLS) protocol – as well as its outdated predecessor, the Secure Sockets Layer (SSL) protocol – ensures that the communication between a client computer and a server is secure. The protocol requires the server to present a digital certificate, proving that it is the intended destination. The connecting client conducts certification path validation, ensuring that:

The subject of the certificate matches the hostname (not to be confused with the domain name) to which the client is trying to connect.
A trusted certificate authority has signed the certificate.
The Subject field of the certificate must identify the primary hostname of the server as the Common Name.[clarification needed] A certificate may be valid for multiple hostnames (e.g., a domain and its subdomains). Such certificates are commonly called Subject Alternative Name (SAN) certificates or Unified Communications Certificates (UCC). These certificates contain the Subject Alternative Name field, though many CAs also put them into the Subject Common Name field for backward compatibility. If some of the hostnames contain an asterisk (*), a certificate may also be called a wildcard certificate.

Once the certification path validation is successful, the client can establish an encrypted connection with the server.

Internet-facing servers, such as public web servers, must obtain their certificates from a trusted, public certificate authority (CA).

TLS/SSL client certificate
Client certificates authenticate the client connecting to a TLS service, for instance to provide access control. Because most services provide access to individuals, rather than devices, most client certificates contain an email address or personal name rather than a hostname. In addition, the certificate authority that issues the client certificate is usually the service provider to which client connects because it is the provider that needs to perform authentication. Some service providers even offer free SSL certificates as part of their packages.[5]

While most web browsers support client certificates, the most common form of authentication on the Internet is a username and password pair. Client certificates are more common in virtual private networks (VPN) and Remote Desktop Services, where they authenticate devices.

Email certificate
In accordance with the S/MIME protocol, email certificates can both establish the message integrity and encrypt messages. To establish encrypted email communication, the communicating parties must have their digital certificates in advance. Each must send the other one digitally signed email and opt to import the sender's certificate.

Some publicly trusted certificate authorities provide email certificates, but more commonly S/MIME is used when communicating within a given organization, and that organization runs its own CA, which is trusted by participants in that email system.

S/MIME (Secure/Multipurpose Internet Mail Extensions) is a standard for public key encryption and signing of MIME data. S/MIME is on an IETF standards track and defined in a number of documents, most importantly RFC 3369, 3370, 3850 and 3851. It was originally developed by RSA Data Security and the original specification used the IETF MIME specification[1] with the de facto industry standard PKCS#7 secure message format. Change control to S/MIME has since been vested in the IETF and the specification is now layered on Cryptographic Message Syntax (CMS), an IETF specification that is identical in most respects with PKCS #7. S/MIME functionality is built into the majority of modern email software and interoperates between them. Since it is built on CMS, MIME can also hold an advanced digital signature.



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