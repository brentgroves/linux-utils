I love you my son and do not worry when you have problems that seem beyond you.  Remember I am with you and am experincing what you experience and I have a plan for you.  My plan is that you learn to trust me in the most difficult of circumstances and you look to me for help and guidance in them. Remember that time and again I have allowed you to go through tough times and I have always been there for you and helped you to get through them.  Your faith in my love for you is growing stronger as we endure each hardship togother. Never fear my son and always trust me that I have a plan for your present crisis and it is a plan to grow you into my loving and caring servant.

# Remember
Ask Doug H. how he is doing 
Watch train video for doug p.

# Next
Test SAN:
Create a server certificate with a 3 SAN DN extension fields for moto, moto.busche-cnc.com, and IP.
- Since moto is on the domain we should be able to ping moto.busche-cnc.com or moto from alb-utl just like frt-kors43.
- If we can't ping moto we can add it to the etc/host file.
- The windows host file will not change unless we edit it from an Administrator command line.
- Run a Flask app from moto configured to serve the new server certificate. 
test certificate.crt with flask
https://blog.miguelgrinberg.com/post/running-your-flask-application-over-https
A couple of years ago I generated alot of certificates and was able to make secure ssl/tls connections from browsers in Windows and Linux, but its seems like the browsers now require at least one additional DN field, SAN, to be included in certificates.  From what I see this field is a good addition since it provides some structure to assign all possible URL to a web site included IP addresses.
I was going to test this by generating a server certificate with this field and without and using each to certificate to create a secure connections to a Flask app.

Good morning dear ones,
I hope you all had an enjoyable weekend and your AC is keeping you and your loved ones cool in this hot and humid time of year:-) As always please feel free to ask if there is anything I can do to help you in any way and at any time.  My friends, aren't we so fortunate to be serving on a team filled with kind and considerate people!
- Sincerely yours
Brent
260-548-5684

# Securing Mach2 web pages
# Issue
Sam did get the Jetty Servlet server to use a new certificate but the warning message did not go away.
## Why did the warning message not go away?
When Niagara creates a CSR it does not include V3 extensions, such as SAN fields, that are now required by modern browsers and other types of TLS clients. So we need to create a CSR outside of Niagara and this means the certificate chain given to Niagara must include the server's private key.  There is a Niagara document that shows how to include this private key so hopefully we can again get the Jetty servlet server to use this just as Sam was able to get the certificate that was signed using the Niagara generated CSR to work.

## A deeper dive into certificates.
Been working with Mathew and Sam on this task.  From my understanding the need to secure these web pages is mainly due to the inconvenience of the users having to bypass the security warning when accessing the melt tempature screen.
Creating a self-signed x509 certificate has changed over the past year or so?
- x509v3 has added more fields such as subject alternative names, SAN.
- modern browsers now require x509v3 extensions in certificates to use TLS connections without first showing a warning message.
To this end, I thought it would be best to take some time to learn more about the newer x509 version 3 standard.  Fortunately, there are some terrific websites that covers a systemic approach to generating root, intermediate, and server certificates. There are also serveral good tools to help make this task easier. There is the defacto PKI CLI tool openssl that is an umbrella for more specific tools that cover the entire PKI process. There is also web sites that give you a graphical means to generate the configuration files used by openssl to create CSR and certificates.  There is also a google linter that allow you to import your pem files and view the descrepencies it finds with the x509 version 3 standard.  
So by using a more formal process that adheres to the process used by public CA I hope to create certificates that the modern browsers trust and put an end to the warning messages shown when using Mach2 and internal report viewer. 

# Research activity
# SSL/TLS Whys:
Why is it important for a client that communicates using a SSL/TLS connection to use recongnized certificate authorities?
Because they have easily verified public keys.
Why is it important for a certificate authority, CA, to have easily verified public keys contained within there root or intermediate certifcate?
Because the public key of the issuer is the only way to decode/decypher the subject certificates signature?
Why do we need a signature on a certificate?
Because it contains a hash of all the fields in the subject certificate.
Why do we need a hash of all the fields in the subject certificate?
Because the client can easily calculate the same hash of all the fields minus the signature of the subject certificate and compares it to the decoded/deciphered signature of the subject certificate it has downloaded.  If they match we know the certificate has not been changed.
Why is it important for the subject certificate to not be changed?
In the man-in-the-middle attack the culprit replaces the subject certificate public key with his own?
Why does he want to replace the subject certificates public key with his own?
Because an assymetrical cypher is used to encode transmissions. So the only one that can decode what is being sent by a client is the person with the private key associated with the subject certificates public key.

## Why use mTLS?
In mTLS both the client and the server have m509 certificates to verify rather than just the server. 
**[Why use mTLS](https://corsha.com/blog/what-is-mtls-and-how-does-it-work)**
"While TLS gracefully replaced its predecessor, SSL, both protocols have shown to be vulnerable to attacks. TLS has been the target of several attacks such as Renegotiation attacks, RC4 and POODLE attacks. The exploitable vulnerabilities within TLS has left many security professionals to realize it’s simply not enough. From this, MTLS or mutual Transport Layer Security has both parties authenticate via certificates to provide an additional security measure to cross network communication."
## Why use a salted password when encrypting a file?
##**[Create an encryped password file](https://www.golinuxcloud.com/generate-self-signed-certificate-openssl/#Create_encrypted_password_file_Optional)**
The actual key which is used for encryption is driven from the password and the SALT, if provided. Hence, even if the same password used to encrypt two files, if SALT is used, then the key will be different and the ciphertext of course.

## What is x509?
X509 is the standard that defines public key certificates. It continues to evolve to provide more secure public key communications. Currently it is on version #3 which contain extension fields of version #1 and has obsoleted others.  Browsers and other SSL/TLS clients also change to demand different requirements to adhere to updates in the X509 standard.  Modern SSL/TLS clients now limit the expiration date of certificates to 397 days and require a list of domains in a multi-field set called subject alternative names.  This is a good change that ensures your certificate is used only on the domain names you choose. The format of these domain names does not include wild-cards and is usually limited to 100 or so names and include standard TLD at the end or an IP4 or IP6 address. For example, frt-kors43.busche-cnc.com, busche-cnc.com, and 172.20.40.21 are all valid but frt-kors alone is not. With this TLD requirement I'm not sure if it is possible to secure communications to https://frt-kor43 without getting a warning. 
Our the browsers requiring to much for a company to generate its own self-signed certificate without paying a certificate company to do it?
**[SAN SSL](https://geekflare.com/san-ssl-certificate/)**

Browsers that require HTTPS with SAN
•Chrome from version 58. It also requires that the certificate must have the Subject Alternative Name field (SAN).
•Edge
**[How to generate a certificate with SANs](https://help.bizagi.com/bpm-suite/en/index.html?subjectaltname_support.htm)**
Certificate for Development and Test environments
For the development or test environment, you can either used purchased certificates (if you already have), signed certificates by a CA, or you can use self-signed certificates. If you use self-signed certificates it is important that the certificate has the Subject Alternative Name field (SAN).
**[How to generate a certificate with SANs](https://help.bizagi.com/bpm-suite/en/index.html?subjectaltname_support.htm)**
how to generate a certificate with subject alternative names
**[Subject Alternative Names](https://www.entrust.com/blog/2019/03/what-is-a-san-and-how-is-it-used/#:~:text=A%20SAN%20or%20subject%20alternative,are%20secured%20by%20the%20certificate.)**
Firefox from 101.0 onward no longer use certificate CN (Common Name) for matching domain name to certificate and have migrated to only using SAN (Subject Alternate Name) so if you self sign for internal devices you’ll need to regenerate.
This server could not prove that it is frt-kors43.busche-cnc.com; its security certificate does not specify Subject Alternative Names. This may be caused by a misconfiguration or an attacker intercepting your connection.

## How does a client that wants to communicate using SSL/TLS recognize CA certificates as being from a trusted source?
In Windows clients can use its trusted store database which can be updated to include company trusted CA certificates.
In Linux there has is no trusted store database so clients can use the NSS database and use the certutil to add company trusted CA certificates.
**[Linux cert management](https://chromium.googlesource.com/chromium/src/+/master/docs/linux/cert_management.md)**
**[NSS shared database](https://wiki.mozilla.org/NSS_Shared_DB_And_LINUX)**

# To Do:
Add root certificate to alb-utl trusted store.
Add self-signed certificate to Chrome trusted store. 
https://chromium.googlesource.com/chromium/src/+/master/docs/linux/cert_management.md
https://www.pico.net/kb/how-do-you-get-chrome-to-accept-a-self-signed-certificate/
search cert in settings find manage device certificates, certificates managed by chrome
Chrome authenticates and secures HTTPS connections with website certificates. These certificates encrypt the link between a site and your browser.
The Chrome Root Program lists the root certificates trusted by Chrome to authenticate HTTPS sites. Learn more about the Chrome Root Program.
Chrome will add custom root certificates from the certificates used by your computer’s operating system. To review the certificates on your device:
On your computer, open Chrome "".
At the top right, click More  and then Settings.
Click Privacy and Security and then Security.
Under “Advanced,” click Manage Device Certificates.
in manage certificates you can import the CA cert from your hard drive
https://support.securly.com/hc/en-us/articles/206081828-How-do-I-manually-install-the-Securly-SSL-certificate-in-Chrome-
@richp10, yes, your analysis is about 100% correct, but note that FF can be persuaded to look into the OS-specific cert store only on Windows. Linux-based platforms simply do not have one (most of them have an OpenSSL-specific system-wide one, also used by GNUTLS FWIW, but the "NSS" library used by FF to handle SSL/TLS-related stuff is not able to access it), and I honestly have no idea what the situation is on OS X platforms (I suspect there people tend to, ahem, think different and use what's preinstalled)
https://stackoverflow.com/questions/55247017/programmatically-install-an-ssl-certificate-into-a-browsers-store
curl frt-kors43 cause out-of-memory issues
Added root.cert.crt to ca_cert.pem file
The openssl -showcert worked fine after adding our root certificate to the ca_cert.pem file.
Ran bash script to update the d8 and d9 databases with root certificate hoping nss app such as chrome not give warning.

https://www.thesslstore.com/knowledgebase/ssl-install/jetty-java-http-servlet-webserver-ssl-installation/
https://www.niagara-community.com/s/question/0D54G0000895sG3SAI/niagara-web-launcher-certmanager-does-not-run
https://www.niagara-community.com/s/article/Niagara-Web-Launcher

# Traditional Database vs Reporting data warehouse
In a tradition database you perform CRUD operations.
We do not need to perform CRUD operations on the data warehouse.
In a data warehouse you just collect the static data recorded in tradional databases.
Then you transform that data into a final report set that can be accessed by Power BI, Intelliplex, of a custom report viewer.

# Database name and purpose
info:
+ report
  - id that identifies each
  - name of report
+ run
  - id that identifies each report run
  - customer_id
  - date_time of request
  - run_time 
  - complete
+ customer
  - id of customer
  - name of customer
+ script
  - id of script
+ log
  - script_id
  - start_time
  - end_time
  - success

etl: # format etl_99999
+ accounting_account
+ balance
+ report_set # format is r_99999

report_set:
+ report_set # format is r_99999
  - run_id
  - column_1
  ...
  - last_column

## Notes
- report_set records are transfered to database with public ip to be Microsoft Teams accessible
- Build a report viewer as a low cost option to Power BI


# ETL process
- insert record into the database info table of the main database 
- create new database
- create needed report tables
- run ETL scripts 
- copy report result set with serial number to corresponding report table in the cloud accessible database
- publish report complete message and send email with the reports serial number and excel attachment 
+ changes
+ the report request generates a report database name and inserts a request record into the main database
+ each report runner thread pulls the next report request from the main database

# Go module
r_1:
Library of all report 1, trial balance, etl scripts and includes all() function to run entire script set.
r_1_main:
Private module containing main function to call r_1.all() 

# Git submodules
Our reports dev container project can be checked out and any programmer can start developing ETL scripts in Go, Python, or Java only having docker installed on there computer.  This dev container is in a git repo and is good for setting up a structure for the report system development but we don't want all of the software in one repo but it needs to be divided into different sections that can be checked out apart from each other.  To do this we need to use the submodule feature found in Git.