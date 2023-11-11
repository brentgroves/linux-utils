https://www.keyfactor.com/resources/what-is-pki/
The Role of Digital Certificates in PKI
PKI governs encryption keys by issuing and managing digital certificates. Digital certificates are also called X.509 certificates and PKI certificates.

However, you refer to them, a digital certificate has these qualities: 

Is an electronic equivalent of a driver’s license or passport 
Contains information about an individual or entity 
Is issued from a trusted third party 
Is tamper-resistant 
Contains information that can prove its authenticity 
Can be traced back to the issuer 
Has an expiration date 
Is presented to someone (or something) for validation

Why: To make sure that the public key given to encrypt the message is who you think it's from.


Introducing Certification Authorities
Certification Authorities (CAs) are responsible for creating digital certificates and own the policies, practices, and procedures for vetting recipients and issuing the certificates. 

Vetting is the process of performing a background check on someone

Specifically, the owners and operators of a CA determine: 

Vetting methods for certificate recipients 
Types of certificates issued 
Parameters contained within the certificate 
Security and operations procedures 

Once CAs make these determinations, they must formally document their policies. From there, it’s up to the consumers of certificates to decide how much trust they want to place in certificates from any given CA. 

How the Certificate Creation Process Works
The certificate creation process relies heavily on asymmetric encryption and works as follows: 

A private key is created and the corresponding public key gets computed 
The CA requests any identifying attributes of the private key owner and vets that information 
The public key and identifying attributes get encoded into a Certificate Signing Request (CSR) 
The CSR is signed by the key owner to prove possession of that private key 
The issuing CA validates the request and signs the certificate with the CA’s own private key 


