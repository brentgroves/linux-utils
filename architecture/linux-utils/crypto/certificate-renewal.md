https://www.ibm.com/docs/en/i/7.1?topic=concepts-certificate-renewal

The certificate renewal process that Digital Certificate Manager (DCM) uses varies based on the type of Certificate Authority (CA) that issued the certificate.

If you use the local CA to sign the renewed certificate, DCM uses the information that you provide to create a new certificate in the current certificate store and retains the previous certificate.

If you use a well-known, Internet CA to issue the certificate, you can handle the certificate renewal in one of two ways: to import the renewed certificate from a file you receive from the signing CA or to have DCM create a new public-private key pair for the certificate. DCM provides the first option in case you prefer to renew the certificate directly with the CA that issued it.

If you choose to create a new key pair, DCM handles the renewal in the same way that it handled the creation of the certificate. DCM creates a new public-private key pair for the renewed certificate and generates a Certificate Signing Request (CSR) which consists of the public key and other information that you specify for the new certificate. You can use the CSR to request a new certificate from VeriSign or any other public CA. Once you receive the signed certificate from the CA, you use DCM to import the certificate into the appropriate certificate store. The certificate store then contains both copies of the certificate, the original and the newly issued renewed certificate.

If you choose not to have DCM generate a new key pair, DCM guides you through the process of importing the renewed, signed certificate into the certificate store from an existing file that you received from the CA. The imported, renewed certificate then replaces the previous certificate.

