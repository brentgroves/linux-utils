I am with you always.  Trust me to watch over you and trust in my plan for you.  I will help you endure all things in order for your faith to grow stronger with each trial.  Without trials you will not grow to trust me but when you see that no matter how tough the situation is you can have peace and joy by looking to me then your faith shall be complete.

Good morning dear ones,
I hope you and your loved ones are staying healthy and fit this week, and for those of you are hurting I hope you get better soon! I heard a quote I liked this week: Let us work with joy and try to be happy.  This is easier said than done but at it's a good thought anyway :-/
- Sincerely yours
Brent
260-548-5684

# Next
Start testing the 3 certificates
# login name change from busche-cnc.com to mobexglobal.com
- Can not create repos in Mobex Global Project of Azure Dev Ops
# TLS protocol
- The TLS protocol used to rely on only self-contained x509v3 certificates to secure communications.
- The certificate chain is downloaded and the client would use a local database, trust store, and a time consuming assymetrical public key cypher method to identify a CA certificate as being valid.
- Then a TLS handshake occurs that involves the passing of random numbers between the client and server to calculate a less time consuming symmetric ciphers session key used to encode/decode all traffic for a session.
- Now clients are beginning to not rely on only a self-contained x509 certificate but a distributed PKI system. 
- Like a internet task force is responsible for the issueing of domain names there is another for managing and issuing object identifiers, OID, that map to URL.  
- Some ojbect identifier types in place are for certificate status check, certificate repository, and validation policy service providers.
- These OID are contained in the certificate extension fields defined in x509v3 certificates and are now required by Chrome for it to trust a web site.
- At the moment I believe the TLS clients check for the presence of the object identifiers without actually using them as they are intended in the PKI process.
- So I determined the mandatory x509v3 extension fields required by Chrome by using the Google certificate checker and added them to our openssl x509 generated end entity certificate and also resolved our root and intermediate certificate errors found by this linter.
- The next step is to validate this new certificate chain with Chrome. I can start out by running a local Apache or Nginx web server and then test on a Jetty servlet server like that which Niagara uses before sending the certificate chain to be uploaded to Niagara on frt-kors43. 
# Securing Mach2 with TLS connections
## Our goal is to get rid of the browser warning message
To this end I generated root, intermediate, and end-entity x509v3 certificates which includes:
- A Subject Alternative Names section containing the FQDN the web site can be accessed with.
- An authorityInfoAccess field containing an OID for both a OCSP and CA Issurer URI:
OCSP;URI:http://ocsp.busche-cnc.com/,caIssuers;URI:http://busche-cnc.com/ca.html
- An a general purpose certificate policy as well as a validation certificate policy.

I validate these 3 certificates using the google chrome certificate linter and got rid of the errors.

Now I'm going to test the certificate chain on the same web servlet server Niagara uses before appending the private key to this chain and sending it to Sam to add to frt-kors4.
- Jetty Servlet Server
- Apache
- Nginx

## Is it OK to have both, the hostname and the FQDN of a server, in an SSL certificate?
**[hostname and FQDN in SAN}(https://security.stackexchange.com/questions/260451/is-it-ok-to-have-both-the-hostname-and-the-fqdn-of-a-server-in-an-ssl-certific)**
A typical browser would probably not allow a secure connection to a host without a FQDN without displaying a warning message.  The browser wants to make sure its accessing the server the certificate was issued for.  If the certicate was issued for frt-kors43 it would not know for sure if it were accessing frt-kors43.google.com or frt-kors.busche-cnc.com because of the /etc/hosts file or automatic concatenation of a DNS suffix by the network settings. The whole domain name business and CA process is geared to verify the browser is accessing the FQDN securely so how could GoDaddy or CPanel issue a certificate to secure just a host name.  If we really wanted to bypass this warning to access https://frt-kors43 without getting a warning message we would have to start Chrome with the flag to bypass the security warning message for all URLs.  


If the browser warning message goes away on my dev system then I will ask Sam to install them on frt-kors43 Niagara system.
## Our PKI structure
ca
├── articles
│   ├── certificate-linters.md
│   ├── Create_encrypted_password_file_Optional
│   ├── generate-self-signed-certificate-openssl
│   ├── install-openssl.md
│   ├── openssl-ca-vs-openssl-x509-comparison.md
│   ├── openssl-create-certificate-chain-linux
│   ├── openssl-generate-csr-create-san-certificate
│   ├── pki-certificates-authority-ocsp.md
│   ├── things-to-consider-when-creating-csr-openssl
│   ├── what-happens-in-a-tls-handshake.md
│   ├── what-is-a-session-key.md
│   ├── what-is-base64.md
│   ├── what-is-pki.md
│   ├── what-is-url-encoding..md
│   └── x509v3.md
├── intermediateCA
│   ├── certs
│   │   ├── ca-chain.cert.pem
│   │   ├── ca-chain.cert.srl
│   │   ├── intermediate.cert.pem
│   │   ├── moto.busche-cnc.com.cert.pem
│   │   ├── moto.san.cert.pem
│   │   └── moto.san.chain.cert.pem
│   ├── crl
│   ├── csr
│   │   ├── intermediate.csr.pem
│   │   ├── moto.busche-cnc.com.csr.pem
│   │   └── moto.san.csr.pem
│   ├── index.txt
│   ├── index.txt.attr
│   ├── index.txt.old
│   ├── newcerts
│   │   └── 355022EACEB09267674C6EA627D1D020FC63F8CB.pem
│   ├── private
│   │   ├── intermediate.key.pem
│   │   ├── moto.busche-cnc.com.key.pem
│   │   └── moto.san.key.pem
│   └── serial
├── mypass.enc
├── openssl_intermediate.cnf
├── openssl_root.cnf
├── rootCA
│   ├── certs
│   │   └── ca.cert.pem
│   ├── crl
│   ├── csr
│   ├── index.txt
│   ├── index.txt.attr
│   ├── index.txt.old
│   ├── newcerts
│   │   └── 2BF360B9F055E0767FC687ECFEA8023E13BBF29F.pem
│   ├── private
│   │   └── ca.key.pem
│   └── serial
└── server_cert_ext.cnf

## Why do we have two CA?
I would like to get the browser warning message to go away so I am following the best practices recommended for creating certificates. One practice is to create both a root and intermediate CA and sign the intermediate CA with the root CA and sign the end-entity CA with the intermediate CA. Then lock away the root certificate where no one can get to it. If the intermediate CA is compromised we can then revoke it and regenerate a replacement without too much difficulty.
## Certificate chain creation process testing
**[renew self-signed certificates](https://www.golinuxcloud.com/renew-self-signed-certificate-openssl/)**
Follow the certificate chain creation process on moto.busche-cnc.com.
Verify each certifice using openssl and Google's x509v3 linter.
Add root and intermediate certificates to Chrome NSS database on Ubuntu system 
Add root and intermediate certificates to Windows trust store
Run Apache web server and configure it to issue this certificate chain 
Run Jetty servlet engine and configure it to issue this certificate chain 
Run Nginx web server and configure it to issue this certificate chain 
From a Ubuntu system test TLS connection to the moto.busche-cnc.com Apache, Jetty, and Nginx instances using curl CLI.
From a Ubuntu system run Chrome and test TLS connection to the moto.busche-cnc.com Apache, Jetty, and Nginx instances.
From the Alb-utl Windows server run Chrome and test TLS connection to the moto.busche-cnc.com Apache, Jetty, and Nginx instances.

## What are SAN certificates?
From the golinuxcloud.com web site it states this problem: 
"Just to recap our exercise, earlier when we tried to connect to our webserver using IP Address instead of hostname then we received "curl: (51) SSL: certificate subject name 'centos8-3' does not match target host name '10.10.10.17'" because we had created our client certificate using centos8-3 as the Common Name for client.csr"
A SAN certificate uses the extensions found in the x509v3 standard to include a field, SAN, that allows you to include multiple IP addresses and DNS names that the certificate is valid for. So no matter what URL a customer uses to access our web site the certificate is valid.

## How to renew a certificate?
The maximum certificate expiration date is now only 397 days so we should think about making the renewal process as easy as possible.
**[renew self-signed certificates](https://www.golinuxcloud.com/renew-self-signed-certificate-openssl/)**
- Step-1: Check the validity of the self-signed certificate
- Step-2: Export CSR from the expired certificate
- Step-3: Renew self-signed certificate 

# Research Activity
## How does the certificate creation process work?
**[What is PKI](https://www.keyfactor.com/education-center/what-is-pki/)**
"How the Certificate Creation Process Works
The certificate creation process relies heavily on asymmetric encryption and works as follows: 

A private key is created and the corresponding public key gets computed 
The CA requests any identifying attributes of the private key owner and vets that information 
The public key and identifying attributes get encoded into a Certificate Signing Request (CSR) 
The CSR is signed by the key owner to prove possession of that private key 
The issuing CA validates the request and signs the certificate with the CA’s own private key"

## How to use wireshark?
**[How to use wireshark](https://www.golinuxcloud.com/how-to-use-wireshark/)**
