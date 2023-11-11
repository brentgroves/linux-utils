https://blogg.bekk.no/how-to-sign-a-certificate-request-with-openssl-e046c933d3ae
https://devopscube.com/create-self-signed-certificates-openssl/
https://www.ssl.com/how-to/manually-generate-a-certificate-signing-request-csr-using-openssl/
The OpenSSL command below will generate a 2048-bit RSA private key and CSR:
openssl req -newkey rsa:2048 -keyout PRIVATEKEY.key -out MYCSR.csr

Step 1: Creating private keys and certificates
https://www.ibm.com/docs/en/license-metric-tool?topic=certificate-step-1-creating-private-keys-certificates

# Create a new private key in the PKCS#1 format.
openssl genrsa -des3 -out key_name.key key_strength

For example:
openssl genrsa -out private_key.key 2048
openssl genrsa -out frt_kors43_private_key.key 2048

# Create a certificate signing request (CSR). 
The request is associated with your private key and is later transformed into a certificate.
openssl req -new -key path_to_private_key.key -out csr_name.csr
openssl req -new -key frt_kors43_private_key.key -out frt_kors43.csr

Country Name: US
State: Indiana
Locality: Fruitport
Organization: Mobex Global
Organizational Unit Name: Information Systems
Company Name: frt-kors43
Email Address: sjackson@mobexglobal.com
No challenge password
Optional company name: frt-kor43.busche-cnc.com

# Step #2: Sign the request to transform it into the certificate.
https://www.ibm.com/docs/en/license-metric-tool?topic=certificate-step-2-signing-certificates
Before you begin
Using a private CA to sign your request is not the only way. You can also send the request to internationally trusted CAs, such as Entrust, VeriSign, and so on, or use the CA of your organization. The certificates of these CAs are often trusted by default and do not display any warnings in the browser. Warnings might be displayed if you use a private CA.

# Create a private certificate authority (CA) and a certificate for it.
Create a private CA. This step creates a private key (.key) and a request (.csr) similar to those that you created in Creating private keys and certificates.
openssl req -new -newkey rsa:key_strength -nodes 
-out CA_csr_name.csr -keyout CA_key_name.key -sha256

# Create the CA private key and a CSR
For example:
pushd ~/src/linux-utils/crypto/certificates/workflow/csr/frt-kors43
openssl req -new -newkey rsa:2048 -nodes -out CA_CSR.csr -keyout CA_private_key.key -sha256
Country Name: US
State: Indiana
Locality: Albion
Organization: Mobex Global
Organizational Unit Name: Information Systems
Company Name: devcon2
Email Address: bgroves@mobexglobal.com
No challenge password
No optional company name

Where:
key_strength
Key strength, measured in bits. The maximum value that you can use for License Metric Tool is:
For application update 9.2.10 and higher: 16384 bits
For application update 9.2.9 and lower: 2048 bits.
CA_csr_name
File name for the certificate signing request (CSR). The certificate authority (CA) requires a separate request.
CA_key_name
File name for the private key. The certificate authority (CA) requires a separate private key.

# Create a certificate for your private CA. This step creates a certificate (.pem) that you can use to sign other CSR.
https://www.ibm.com/docs/en/sia?topic=osdc-certificate-key-formats-23

openssl x509 -signkey path_to_CA_key.key -days 
number_of_days -req -in path_to_CA_csr.csr 
-out CA_certificate_name.pem -sha256

For example:
https://serverfault.com/questions/920461/why-openssl-ignore-days-for-expiration-date-for-self-signed-certificate
397 days
TLS/SSL certificates cannot be issued for more than 13 months (397 days), as announced by popular browsers, like Google and Apple at CA/Browser Forum in March 2020. This has reduced the certificate validity period from three or two to just over a year.

openssl x509 -signkey CA_private_key.key -days 397 -req -in CA_CSR.csr -out CA_certificate.pem -sha256
Signature ok
subject=C = US, ST = Indiana, L = Albion, O = Mobex Global, OU = Information Systems, CN = devcon2, emailAddress = bgroves@mobexglobal.com
Getting Private key

openssl x509 -in CA_certificate.pem -noout -pubkey
openssl x509 -in CA_certificate.pem -noout -enddate
outputs the certificate's SubjectPublicKeyInfo block in PEM format.
https://www.mkssoftware.com/docs/man1/openssl_x509.1.asp
openssl x509 -in CA_certificate.pem -noout -text

path_to_CA_csr
File name for the certificate signing request (CSR) that you created for the certificate authority (CA).
path_to_CA_key
File name for the private key that you created for the certificate authority (CA).
number_of_days
Number of days for the new certificate to be valid.
CA_certificate_name
File name for the certificate of your CA. This certificate is used to sign other CSR.

# Use the CA certificate to sign the certificate signing request that you created in step 1 Creating private keys and certificates
openssl x509 -req -days number_of_days -in path_to_csr.csr -CA path_to_CA_certificate.pem -CAkey path_to_CA_key.key -out new_certificate.pem -set_serial 01 -sha256

openssl x509 -req -days 397 -in frt_kors43.csr -CA CA_certificate.crt -CAkey CA_private_key.key -out frt_kors43_certificate.pem -set_serial 01 -sha256

# sam's csr
openssl x509 -req -days 397 -in frtkors43_v1.csr -CA CA_certificate.crt -CAkey CA_private_key.pem -out frtkors43v1_cert.pem -set_serial 01 -sha256
Signature ok
subject=C = US, ST = Michigan, L = Fruitport, O = Mobex GLobal, OU = IS, CN = FRT-KORS43
Getting CA Private Key
Signature ok
subject=C = US, ST = Indiana, L = Fruitport, O = Mobex Global, OU = Information Systems, CN = frt-kors43, emailAddress = sjackson@mobexglobal.com
Getting CA Private Key

number_of_days
Number of days for the new certificate to be valid.
path_to_csr
Path to certificate signing request (CSR) that you want to sign.
path_to_CA_certificate
Path to certificate that you created for the certificate authority (CA).
path_to_CA_key
Path to the private key that you created for the certificate authority (CA).
new_certificate
File name for the signed certificate that is created from your certificate signing request (CSR). 

openssl x509 -in frt_kors43_certificate.pem -noout -pubkey
outputs the certificate's SubjectPublicKeyInfo block in PEM format.
openssl x509 -in frt_kors43_certificate.pem -noout -issuer
openssl x509 -in frt_kors43_certificate.pem -noout -subject
openssl x509 -in frt_kors43_certificate.pem -noout -enddate
https://www.mkssoftware.com/docs/man1/openssl_x509.1.asp
openssl x509 -in frt_kors43_certificate.pem -noout -text

# create a certificate chain
https://www.niagara-community.com/s/article/Importing-a-PEM-file-using-Workbench
In a nut shell, you just copy the Private Key, Primary certificate, any intermediate certificates and the root certificate into the same text file. This master file would have a ‘.PEM’ extension. Import this file into the Niagara User Key Store.

example:
frt_kors43_private_key.key
frt_kors43_certificate.pem
CA_certificate.pem

https://help.mulesoft.com/s/article/How-to-Download-Whole-Certificate-Chain-From-A-Remote-Host-and-Import-to-a-Trust-Store

https://www.youtube.com/watch?v=jk0F_ZDZg1U