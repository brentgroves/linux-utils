https://www.golinuxcloud.com/renew-self-signed-certificate-openssl/
In this tutorial we will cover step by step details to renew self-signed certificate using openssl command. During any certificate renewal, you always have to make sure that you have a copy of the private key which was used to generate the original certificate. Without the private key, you will not be able to renew any certificate.

In such case you will have to create a new private key and then generate a new certificate.
- Step-1: Check the validity of the self-signed certificate
- Step-2: Export CSR from the expired certificate
- Step-3: Renew self-signed certificate 