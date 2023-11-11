
After generating the CSR, the applicant sends it to a CA, who independently verifies that the information it contains is correct and, if so, digitally signs the certificate with an issuing private key and sends it to the applicant.

When the signed certificate is presented to a third party (such as when that person accesses the certificate-holder’s website), the recipient can cryptographically confirm the CA’s digital signature via the CA’s public key. Additionally, the recipient can use the certificate to confirm that signed content was sent by someone in possession of the corresponding private key, and that the information has not been altered since it was signed. A key part of this aspect of the certificate is something called a chain of trust.

https://www.ssl.com/faqs/what-is-a-certificate-authority/

A chain of trust consists of several parts:

1. A trust anchor, which is the originating certificate authority (CA).
2. At least one intermediate certificate, serving as “insulation” between the CA and the end-entity certificate.
3. The end-entity certificate, which is used to validate the identity of an entity such as a website, business, or person.



It’s easy to see a chain of trust for yourself by inspecting an HTTPS website’s certificate. When you check an SSL/TLS certificate in a web browser, you’ll find a breakdown of that digital certificate’s chain of trust, including the trust anchor, any intermediate certificates, and the end-entity certificate. These various points of verification are backed up by the validity of the previous layer or “link,” going back to the trust anchor.
