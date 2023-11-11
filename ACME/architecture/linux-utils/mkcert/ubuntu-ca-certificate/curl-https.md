For windows do this:
curl https://reports01/myhello/ --ssl-no-revoke 

For ubuntu do this:
https://ubuntu.com/server/docs/security-trust-store

ls /etc/ssl/certs show a list of all certificates.

trust store

Often in an enterprise environments there is a local Certificate Authority (CA) that issues certificates local to the organization. For an Ubuntu server to be functional and trust the hosts in this environment this CA must be installed in Ubuntu’s trust store.
Installing a certificate in PEM form

To install a certificate in the trust store it must be in PEM form. Assuming the root CA certificate is in PEM form at a file called local-ca.crt, follow the steps below to convert to DER form an install.

$ sudo apt-get install -y ca-certificates
$ sudo cp local-ca.crt /usr/local/share/ca-certificates
$ sudo update-ca-certificates

Note: It is important to have the .crt extension on the file, otherwise it will not be processed.

After this point you can use Ubuntu’s tools like curl and wget to connect to local sites.
https://betterstack.com/community/questions/how-to-list-all-available-ca-ssl-certificates-on-ubuntu/
To list all available CA SSL certificates run the following lines of code:

awk -v cmd='openssl x509 -noout -subject' '

/BEGIN/{close(cmd)};{print | cmd}' < /etc/ssl/certs/ca-certificates.crt

This will display the subject of every CA certificate in /etc/ssl/certs/ca-certificates.crt

But beware that you may get an error if SSL servers forget to provide the intermediate certificates. In that case, you can try running the following command to get the list of certificates being sent.

openssl s_client -showcerts -connect the-git-server:443



https://www.baeldung.com/linux/curl-https-connection
Self-Signed Certificates

Sometimes, if a server is using a self-signed certificate, we’ll encounter the error “SSL certificate problem: self-signed certificate” when making a curl request. This means that the server is not using a certificate that was signed by a trusted authority.
freestar

Let’s say we’re running a local Spring Boot project that’s configured with TLS.

One way to handle this is to force curl to ignore the certificate verification, using the -k or –insecure flag:

curl -k https://localhost:8443/baeldung

However, ignoring HTTPS errors can be very insecure. Instead, another option is to use the certificate from the server we’re trying to access.
3.1. Getting Server Certificate

When we call an HTTPS endpoint using one-way SSL, the client validates the receiving server certificate with the certificate that it has available. Therefore, we’ll need to save the shared server certificate in the client.

To retrieve a list of server certificates, we’ll use the OpenSSL command, with the -showcerts argument:

openssl s_client -showcerts -connect <Domain Name or IP Address>:<Port>

openssl s_client -showcerts -connect reports01:443
openssl s_client -showcerts -connect reports11:443


The -showcerts option prints out the complete certificate chain. We can save the certificates into a file to invoke the endpoint:

openssl s_client -showcerts -connect https://localhost:8443/baeldung </dev/null | sed -n -e '/-.BEGIN/,/-.END/ p' > baeldung.pem

openssl s_client -showcerts -connect https://reports01/myhello </dev/null | sed -n -e '/-.BEGIN/,/-.END/ p' > mkcert.pem