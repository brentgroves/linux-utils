https://www.ssl.com/faqs/what-is-a-certificate-authority/

What Is a Certificate Authority (CA)?
A certificate authority (CA), also sometimes referred to as a certification authority, is a company or organization that acts to validate the identities of entities (such as websites, email addresses, companies, or individual persons) and bind them to cryptographic keys through the issuance of electronic documents known as digital certificates.

A digital certificate provides:
Authentication, by serving as a credential to validate the identity of the entity that it is issued to.
Encryption, for secure communication over insecure networks such as the Internet.
Integrity of documents signed with the certificate so that they cannot be altered by a third party in transit.

(certificate request)[https://d1smxttentwwqu.cloudfront.net/wp-content/uploads/2019/07/ca-diagram-b.png]

Typically, an applicant for a digital certificate will generate a key pair consisting of a private key and a public key, along with a certificate signing request (CSR). A CSR is an encoded text file that includes the public key and other information that will be included in the certificate (e.g. domain name, organization, email address, etc.). Key pair and CSR generation are usually done on the server or workstation where the certificate will be installed, and the type of information included in the CSR varies depending on the validation level and intended use of the certificate. Unlike the public key, the applicant’s private key is kept secure and should never be shown to the CA (or anyone else).

After generating the CSR, the applicant sends it to a CA, who independently verifies that the information it contains is correct and, if so, digitally signs the certificate with an issuing private key and sends it to the applicant.

When the signed certificate is presented to a third party (such as when that person accesses the certificate-holder’s website), the recipient can cryptographically confirm the CA’s digital signature via the CA’s public key. Additionally, the recipient can use the certificate to confirm that signed content was sent by someone in possession of the corresponding private key, and that the information has not been altered since it was signed. A key part of this aspect of the certificate is something called a chain of trust.