https://jite.eu/2019/2/6/ca-with-cfssl/#adding-your-ca-to-the-computers-certificate-storage

Adding your CA to the computers certificate storagePermalink
When you have certificates, you might want to allow your computer (and servers) to let the certificates to be seen as secure (that is, no annoying ‘SELF SIGNED CERTIFICATE ERROR!’). Depending on your OS, this is done in a few different ways.
Each computer have a trusted store, and to make our certificates seen as secure on a specific computer, we need to add the public certificate to the trusted store. We don’t add each of the certificates to it, as that would be very annoying, but instead we add the root certificate to the trusted store, that way all the certificates created in the same trust-chain will be seen as secure by the computer in question.

On windows, this is done through a certificate utility which you can find if you search on “Manage Computer Certificates”, once inside the utility, open the Trusted Root Certificates and right click on certificates and import the certificate public key. On debian and ubuntu based machines, you do it easiest by installing the ca-certificates package, then copy the public key to the /usr/share/ca-certificates directory and then run the update-ca-certificates command (likely as super user or via sudo).

Now your certificates will be seen as secure by the computer!

If your computer requires the certificate in der / .crt format, use OpenSSL to convert the certificate with openssl x509 -outform der -in certificate.pem -out certificate.crt.