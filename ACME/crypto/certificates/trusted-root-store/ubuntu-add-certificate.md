https://ubuntu.com/server/docs/security-trust-store

Enterprise environments sometimes have a local Certificate Authority (CA) that issues certificates for use within the organization. For an Ubuntu server to be functional and trust the hosts in this environment this CA must be installed in Ubuntu’s trust store.

How to recognize the form (PEM or DER)?
To install a certificate in the trust store it must be in PEM form. A PEM-formatted certificate is human-readable in base64 format, and starts with the lines ----BEGIN CERTIFICATE----. If you see these lines, you’re ready to install. If not, it is most likely a DER certificate and needs to be converted.

Installing a certificate in PEM form
Assuming a PEM-formatted root CA certificate is in local-ca.crt, follow the steps below to install it.

Note: It is important to have the .crt extension on the file, otherwise it will not be processed.

pushd ~/src/linux-utils/crypto/certificates/trusted-root-store
$ sudo apt-get install -y ca-certificates
$ sudo cp local-ca.crt /usr/local/share/ca-certificates
mv exp-niagara.pem exp-niagara.crt
$ sudo cp exp-niagara.crt /usr/local/share/ca-certificates
$ sudo update-ca-certificates
Updating certificates in /etc/ssl/certs...
rehash: warning: skipping ca-certificates.crt,it does not contain exactly one certificate or CRL
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...

Adding debian:exp-niagara.pem
done.
done.

After this point you can use Ubuntu’s tools like curl and wget to connect to local sites.
curl --verbose https://frt-kors43.busche-cnc.com
curl --verbose https://frt-kors43.busche-cnc.com
openssl s_client -connect frt-kors43:443 -CApath /etc/ssl/certs/ 2>&1 < /dev/null

openssl s_client -connect frt-kors43.busche-cnc.com:443 -CApath /etc/ssl/certs/ 2>&1 < /dev/null

openssl s_client -connect 172.20.0.41:443 -CApath /etc/ssl/certs/ 2>&1 < /dev/null



Note: 
/etc/ssl/certs # Lots of .pem files in this dir
