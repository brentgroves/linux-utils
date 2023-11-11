https://www.golinuxcloud.com/create-certificate-authority-root-ca-linux/
In this article I will share the steps to create Certificate Authority Certificate and then use this CA certificate to sign a certificate.

hese are the brief list of steps to create Certificate Authority using OpenSSL:

Create private key to be used for the certificate.
Create certificate Authority from the key that you just generated.
Create Certificate Signing Request for your server.
Sign the certificate signing request using the key from your CA certificate.
