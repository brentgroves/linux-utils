https://ubuntu.com/server/docs/security-trust-store

Installing a root CA certificate in the trust store
Enterprise environments sometimes have a local Certificate Authority (CA) that issues certificates for use within the organization. For an Ubuntu server to be functional and trust the hosts in this environment this CA must be installed in Ubuntu’s trust store.

How to recognize the form (PEM or DER)?
To install a certificate in the trust store it must be in PEM form. A PEM-formatted certificate is human-readable in base64 format, and starts with the lines ----BEGIN CERTIFICATE----. If you see these lines, you’re ready to install. If not, it is most likely a DER certificate and needs to be converted.

Installing a certificate in PEM form
Assuming a PEM-formatted root CA certificate is in local-ca.crt, follow the steps below to install it.

Note: It is important to have the .crt extension on the file, otherwise it will not be processed.

$ sudo apt-get install -y ca-certificates
$ sudo cp local-ca.crt /usr/local/share/ca-certificates
$ sudo update-ca-certificates
After this point you can use Ubuntu’s tools like curl and wget to connect to local sites.

Converting from DER-form to PEM-form
Convert a DER-formatted certificate called local-ca.der to PEM form like this:
$ sudo openssl x509 -inform der -outform pem -in local-ca.der -out local-ca.crt

The CA trust store location
The CA trust store as generated by update-ca-certificates is available at the following locations:

As a single file (PEM bundle) in /etc/ssl/certs/ca-certificates.crt
As an OpenSSL compatible certificate directory in /etc/ssl/certs