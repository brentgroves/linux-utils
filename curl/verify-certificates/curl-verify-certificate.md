https://www.baeldung.com/linux/validating-certificates-curl

2. What Is cURL Used For?
In Linux, cURL stands for “Client URL“. Virtually every internet-using human on the globe uses curl daily. Linux command lines or scripts use curl to transfer data. cURL finds its use in cars, television sets, routers, printers, audio equipment, mobile phones, tablets, set-top boxes, and media players. It’s the internet transfer engine for thousands of software applications in over ten billion installations.

2.1. Checking Certificates
Validating certificates can be complex. First, we have to look for a CDP or OCSP AIA. Only then do we make a request, parse the response, and check that the response is signed against by a CA that is authorized to respond for the certificate in question. 

If it’s a CRL, we need to see if the serial number of the certificate we’re checking is in the list. On the contrary, if it’s OCSP, then we need to see if we’ve received a “good” response. Additionally, we may want to verify that the certificate is within its validity period and chains to a trusted root. We can check the root certificate by querying our platform using the following cURL command: 

$ curl --verbose https://www.google.com
curl --verbose https://frt-kors43
* Could not resolve host: frt-kors43
* Closing connection 0
curl: (6) Could not resolve host: frt-kors43
curl --verbose https://frt-kors43.busche-cnc.com
*   Trying 172.20.0.41:443...
* Connected to frt-kors43.busche-cnc.com (172.20.0.41) port 443 (#0)
* ALPN: offers h2
* ALPN: offers http/1.1
*  CAfile: /home/brent/anaconda3/ssl/cacert.pem
*  CApath: none
* [CONN-0-0][CF-SSL] TLSv1.3 (OUT), TLS handshake, Client hello (1):
* [CONN-0-0][CF-SSL] TLSv1.3 (IN), TLS handshake, Server hello (2):
* [CONN-0-0][CF-SSL] TLSv1.2 (IN), TLS handshake, Certificate (11):
* [CONN-0-0][CF-SSL] TLSv1.2 (OUT), TLS alert, unknown CA (560):
* SSL certificate problem: self signed certificate
* Closing connection 0
curl: (60) SSL certificate problem: self signed certificate
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.

Copy
 If the connection is successful and verified by the root certificate, we’ll see the following entry: 

* SSL certificate verify ok.

# Checking Certificate Serial Number & Fingerprint
It’s important to check the serial number and fingerprint of each certificate before installation. We can validate the serial number and fingerprint of a certificate using OpenSSL. Running the following command will return the serial number and SHA1 fingerprint: 

$ openssl x509 -noout -serial -fingerprint -sha1 -inform pem -in RootCertificateHere.crt
$ openssl x509 -noout -serial -fingerprint -sha1 -inform pem -in exp-niagara.pem
serial=48320588B0F9568EBE90BA51
SHA1 Fingerprint=03:6E:ED:6F:F6:B2:35:0F:6B:E1:DE:EB:DB:76:9B:EB:FB:5E:9B:B4

We should as well do revocation checks against every intermediate and check the certificate’s fingerprint against the explicit blacklists that Mozilla/Apple/Google/Microsoft maintain.

Certificate Validation Methods with cURL
curl performs peer SSL certificate validation by default. This is done using a certificate store that the SSL library can use to make sure the peer’s server certificate is valid.

https://gist.github.com/CMCDragonkai/f5f76b8eb13e7579aba3
The SSL/TLS store location is not standardised across operating systems or even Linux distros. It could be anywhere in:

/etc/ssl/certs # Lots of .pem files in this dir
/etc/pki/tls/certs/ca-bundle.crt
/etc/ssl/certs/ca-bundle.crt
/etc/pki/tls/certs/ca-bundle.trust.crt
/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
/System/Library/OpenSSL (OSX)
It could be a file, or it could be a hashed directory.

Furthermore, not every single application uses the OS certificate store. Some applications like Firefox and HTTPIE bundle their own certificate store for use.

All of this means, updating the certificate store on your OS does not mean all applications can make use of the new updated certificates. Every application needs to be updated on a case by case basis.


Definitions:
https://social.technet.microsoft.com/wiki/contents/articles/53271.active-directory-certificate-services-aia-crl-and-ocsp.aspx

Let’s assume a SSL / TLS client (Ex: Web Browser) receives  a digital certificate from a web server. The certificate is issued to the web server by the User CA.

In order to ensure that the certificate is issued by a trusted entity , the SSL client needs to validate the entire chain. The validation will continue until it will reach to the Root CA. The validation process will stop once it will reach to the Root CA, because Root CA is already trusted by the web browser and does not need further validation.

AIA (Authority Information Access) is useful during this validation process. The AIA field captures the location of the issuer certificate, and client can download a copy of the issuer certificate during each stage of validation.

• In this case, the web site certificate is issued by ComputerCA, so the AIA field shows the location of ComputerCA.
• Similarly, the AIA filed of Computer CA points to the location of its issuing CA, which is Intermediate CA.
• The AIA filed of Intermediate CA points to the location of its issuing CA, which is Root CA.
• AIA is not applicable for Root CA, as it is using self signed certificate. Moreover, Root CA is the Trust Anchor which should already be trusted by the web browser.

So AIA is mostly instrumental to furnish a copy of the intermediate CAs to the SSL client, during the validation process. 

Another key function of AIA is to support Microsoft Online Certificate Status Protocol (OCSP) Responder. We will discuss OCSP later, but the location of OSCP Responder needs to be added in AIA. 

The OCSP responder server FQDN must be specified in the AIA field, following below format :

http:// <FQDN of OSCP responder server>/ocsp

AIA repositories support HTTP and LDAP protocol.

CRL and CDP

Certificate Revocation List (CRL) contains the list of non-expired revoked certificates. It does not contain the revoked certificate itself, but the serial number of the revoked certificate.

CRL Distribution Point (CDP) is the repository where CRL can be found and downloaded.

Validating CRL is one of the most important part of certificate validation, as the client wants to ensure that the certificate is not revoked by the issuer. 

• If the certificate serial number is not found in the CRL, that means the certificate is not revoked. 

• If the certificate serial number matches with any serial number within CRL which is signed by the issuer, that means the certificate has been revoked and no longer valid. Therefore, most of the SSL based applications do not work until they can access a valid CRL which is mentioned in the certificate.

Like Certificates, each CRL is digitally signed by the CA which has published the CRL. Also, each CRL has a validity period beyond which it is no longer valid.

