https://www.ssl.com/faqs/what-is-an-x-509-certificate/#:~:text=509%20is%20a%20standard%20format,websites%2C%20individuals%2C%20or%20organizations.

https://www.ssl.com/faqs/what-is-an-x-509-certificate/#:~:text=509%20is%20a%20standard%20format,websites%2C%20individuals%2C%20or%20organizations.

X.509 is a standard format for public key certificates, digital documents that securely associate cryptographic key pairs with identities such as websites, individuals, or organizations.

First introduced in 1988 alongside the X.500 standards for electronic directory services, X.509 has been adapted for internet use by the IETF’s Public-Key Infrastructure (X.509) (PKIX) working group. RFC 5280 profiles the X.509 v3 certificate, the X.509 v2 certificate revocation list (CRL), and describes an algorithm for X.509 certificate path validation.

Common applications of X.509 certificates include:

SSL/TLS and HTTPS for authenticated and encrypted web browsing
Signed and encrypted email via the S/MIME protocol
Code signing
Document signing
Client authentication
Government-issued electronic ID

Key Pairs and Signatures
No matter its intended application(s), each X.509 certificate includes a public key, digital signature, and information about both the identity associated with the certificate and its issuing certificate authority (CA):

The public key is part of a key pair that also includes a private key. The private key is kept secure, and the public key is included in the certificate. This public/private key pair:
Allows the owner of the private key to digitally sign documents; these signatures can be verified by anyone with the corresponding public key.
Allows third parties to send messages encrypted with the public key that only the owner of the private key can decrypt.
A digital signature is an encoded hash (fixed-length digest) of a document that has been encrypted with a private key. When an X.509 certificate is signed by a publicly trusted CA, such as SSL.com, the certificate can be used by a third party to verify the identity of the entity presenting it.
Note: Not all applications of X.509 certificates require public trust. For example, a company can issue its own privately trusted certificates for internal use. For more information, please read our article on Private vs. Public PKI.
Each X.509 certificate includes fields specifying the subject, issuing CA, and other required information such as the certificate’s version and validity period. In addition, v3 certificates contain a set of extensions that define properties such as acceptable key usages and additional identities to bind a key pair to.



Certificate Fields and Extensions
To review the contents of a typical X.509 certificate in the wild, we will examine www.ssl.com’s SSL/TLS certificate, as shown in Google Chrome. (You can check all of this in your own browser for any HTTPS website by clicking the lock on the left side of the address bar.)

The first group of details includes information about the Subject, including the name and address of the company and the Common Name (or Fully Qualified Domain Name) of the website that the certificate is intended to protect. (Note: the Serial Number shown in this subject field is a Nevada business identification number, not the serial number of the certificate itself.)

**![First Group of Details](https://www.ssl.com/wp-content/uploads/2019/09/faq-x.509-01.png)**

Scrolling down, we encounter information about the Issuer. Not coincidentally, in this case, the Organization is “SSL Corp” for both subject and issuer, but the issuer’s Common Name is the name of the issuing CA certificate rather than a URL.

Below the Issuer, we see the certificate’s Serial Number (a positive integer uniquely identifying the certificate), X.509 Version (3), the Signature Algorithm, and dates specifying the certificate’s Validity Period.

Next, we arrive at the Public Key, Signature, and associated information.

In addition to the fields above, X.509 v3 certificates include a group of Extensions that offer additional flexibility in certificate use. For example, the Subject Alternative Name extension allows the certificate to be bound to multiple identities. (For this reason, multiple-domain certificates are sometimes referred to as SAN certificates). In the example below, we can see that the certificate actually covers eleven different SSL.com subdomains:


**![SAN certificate](https://www.ssl.com/wp-content/uploads/2019/09/faq-x.509-05b.png)**

The Fingerprints shown below the certificate information in Chrome are not part of the certificate itself, but are independently calculated hashes that can be used to uniquely identify a certificate.

For both administrative and security-related reasons, X.509 certificates are typically combined into chains for validation. As shown in the screenshot from Google Chrome below, the SSL/TLS certificate for www.ssl.com is signed by one of SSL.com’s intermediate certificates, SSL.com EV SSL Intermediate CA RSA R3. In turn, the intermediate certificate is signed by SSL.com’s EV RSA root:

For publicly trusted websites, the web server will provide its own end-entity certificate, plus any intermediates required for validation. The root CA certificate with its public key will be included in the end user’s operating system and/or browser application, resulting in a complete chain of trust.
