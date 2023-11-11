https://blog.cloudflare.com/how-to-build-your-own-public-key-infrastructure/

Issuing certificates
Certificate authorities do not just create certificates out of a private key and thin air, they need a public key and metadata to populate the certificate’s data fields. This information is typically communicated to a CA via a certificate signing request (CSR).



A CSR is very similar in structure to a certificate. The CSR contains:

Information about the organization that is requesting the certificate
A public key
A digital signature by the requestor’s private key
Given a CSR, a certificate authority can create a certificate. First, it verifies that the requestor has control over the associated private key. It does this by checking the CSR’s signature. Then the CA will check to see if the requesting party should be given a certificate and which domains/IPs it should be valid for. This can be done with a database lookup or through a registration authority. If everything checks out, the CA uses its private key to create and sign the certificate to send back to the requestor.

Requesting Certificates
Let’s say you have CFSSL set up as CA as described above and it’s running on a server called “ca1.mysite.com” with an authentication API key. How do you get this CA to issue a certificate? CFSSL provides two commands to help with that: gencert and sign. They are available as JSON API endpoints or command line options.

The gencert command will automatically handle the whole certificate generation process. It will create your private key, generate a CSR, send the CSR to the CA to be signed and return your signed certificate.

There are two configuration files needed for this. One to tell the local CFSSL client where the CA is and how to authenticate the request, and a CSR configuration used to populate the CSR.


