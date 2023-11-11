https://www.ibm.com/docs/en/license-metric-tool?topic=certificate-step-1-creating-private-keys-certificates

Open the command line.
Create a new private key in the PKCS#1 format.
openssl genrsa -des3 -out key_name.key key_strength
openssl genrsa -des3 -out private_key.key 2048

Where:
-des3
Enables password for the private key. This is an optional parameter. You can also enable password for an existing private key by using the following command:
openssl rsa -des3 -in path_to_private_key.key -out key_name.key

key_name
File name for your new private key.
key_strength
Key strength, measured in bits. The maximum value that you can use for License Metric Tool is:
For application update 9.2.10 and higher: 16384 bits
For application update 9.2.9 and lower: 2048 bits.

Create a certificate signing request (CSR). The request is associated with your private key and is later transformed into a certificate.
openssl req -new -key path_to_private_key.key -out csr_name.csr

For example:
openssl req -new -key private_key.key -out CSR.csr

Where:
path_to_private_key
Path to your private key.
csr_name
File name for your certificate signing request (CSR).
After you run the command, you are asked to provide information that helps your users to identify your certificate and ensure that it can be trusted. The following excerpt from the command line is filled in with sample information:
Country Name (2 letter code) [XX]: US
State or Province Name (full name) []: New York
Locality Name (eg, city) [Default City]: New York
Organization Name (eg, company) [Default Company Ltd]: IBM
Organizational Unit Name (eg, section) []: Software
Common Name (eg, your name or your server's hostname) []: inventory.ibm.com
Email Address []: inventory@ibm.com

https://frt-kors43/deltav/home