My son look to me for abundant life.
Don't worry about anything because I love you and you can trust me.

Good morning dear ones,
I hope you all had a very pleasant weekend and look forward to working with each of you soon.  I also feel very fortunate to be part of this team which is kind and respectful to one another!  If you need anything at all please contact me at home or at work. As you may not know I will be out of the office today going to the doctor concerning Christina's foot injury.
-Sincerely yours,
Brent
260-564-4868

Microsoft Teams Personal/Group/Channel Tabs:
There are advantages to having UIs controlled using Teams.
Integrated AAD security.
One place to work.
Simple one function UIs grouped and organized by department.
Types of software linked to tabs includes:
Power BI reports.
Reports Scheduler.
Reports Viewer.
Plex ToolList / ToolBoss / DW sync.
Plex ToolList Enhanced Reports
Where is reporting software running? In Azure K8s, AKS cluster.
How is it securely accessed? HTTPs via an NGinx ingress controller. 

Keep data secure is not easy is it?  
I was working on making a Microsoft Teams tab to schedule reports using a service running on our very small Azure AKS cluster.  This work lead me to the necessity of the service being accessed using HTTPS.  So I spent some time looking at the Microsoft suggestion to add HTTPS functionality to a service.  This suggestion is to use the no cost NGinx ingress controller and certificates issued by the free and open source certificate authority (CA) "Let's Encrypt" 

Note: Noticed that Stackoverflow.com switched from using DigiCert Inc. to "Let's Encrypt". I believe it is a very secure CA but is more difficult to setup than what we pay for.

Can we use python and a CA issued TLS certificate to securely communicate with web services? Yes.
There are good libraries to do this: https://www.pycryptodome.org/src/examples
https://cryptography.io/en/latest/x509/reference/#loading-certificates
Also much of the needed certificate information to do this can be gotten without any programming by using the openssl executable.
From my understanding 90% of the generated public key pairs are generated from openssl.

Summary of how we or a browser can verify a server's identity from a TLS certificate:
https://kulkarniamit.github.io/whatwhyhow/howto/verify-ssl-tls-certificate-signature.html
The CA computes a SHA256 hash from all the subject's data except the signature.
The CA then digests the hash using its own private-key.
The encrypted hash is the TLS certificate's digital signature. 
To verify the issued certificate the browser computes the SHA256 hash of all the subject's data except the signature.
The browser then digests the hash using public-key of the issuer.
It then compares the subject certificate's digital signature to the one it just computed.
If the two signatures are the same the certificate is valid.
If any of the data was modified in transit the values will not match.
What prevents a man-in-the-middle attack is that the issuer's certificate or at least its public key is known by all and stored in the OS certificate store.
After the certificate has been verified to be authenticate and unaltered we can use the public key of the issuer to perform encryption of data sent to the server.
When a request is made to the server to begin an secure session the server responds not only with it's certificate but also the certificate of the issuing CA and probably the root CA.
The root CA is offline most all of the time and it's certificate can not be put on a revocation list.
The issuing CA is online and maintains a published revocation list of compromised certificates.

Mobex x.509 certificate summary:
Here are some details about our Mobex certificate.

# bash command to download and separate the Mobex Global certificate chain.
openssl s_client -showcerts -verify 5 -connect mobexglobal.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

chain-of-trust:
COMODO RSA certificate authority
cPanel Inc., certificate authority
mobexglobal.com, TLS/SSL certificate
Issued To: CN=mobexglobal.com
Issued By: C=US, ST=TX, L=Houston, O=cPanel, Inc., CN=cPanel, Inc. Certification Authority
Serial Number: 18 ff f8 09 07 9e 23 dc 93 0a 3b 72 28 3a 39 dc
Issued On: Mon Jan 30 2023 19:00:00 GMT-0500 (Eastern Standard Time)
Expires On: Mon May 01 2023 19:59:59 GMT-0400 (Eastern Daylight Time)

This is the public that is used to encrypt browser data that only we can decode.

openssl x509 -inform pem -in mobexglobal.com -pubkey -noout > publickey.pem

-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3Q//mRUwrhM/jr89paur
RdJ6CnOSFhmZQ7bT7XuNXG2BPAoj+l6jLENsUIqbXm8hA0sP3Rh8IQtNJyFa7Ukb
cBx+TH5xz74DNV4hS7NlOIuw7r0e7utxSjvd1gRGJtCLsybGiJactqIUFNYZrbEz
dhbbKCeDHv84j1ai5p43EoAdeSiujoyHZq6jibtRs4I7IFiVWI5qSzXjyaRZo7c6
EhMN1dBQrxiVTQETNktfvs+XV1Pk+IjAk2KzoU5rHH2uDDHrSo3AGfKgpHrEBBGX
rW+d6wGLgvRv76JGx9cKI9Z59OD4S1RjpryP63HO3AbmB2VGJc8n/dw118x9+RyP
iwIDAQAB
-----END PUBLIC KEY-----

Below I have included several web sites that contains some information about the SSL/TLS certificate process if you are interested. 
https://cryptobook.nakov.com/
https://aesencryption.net
https://certificatedecoder.dev/
https://letsencrypt.org/how-it-works/
https://www.encryptionconsulting.com/education-center/what-is-rsa/
https://www.keyfactor.com/resources/what-is-pki/
https://www.ibm.com/docs/en/i/7.1?topic=concepts-digital-signatures
https://www.keyfactor.com/blog/what-is-acme-protocol-and-how-does-it-work/
https://www.ssl.com/faqs/what-is-a-certificate-authority/



