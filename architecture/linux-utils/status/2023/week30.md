I love you my son and will guide and strengthen you each and every moment of the day.  Please resist fearful anxious thoughts and trust me for everything.

# Roles
1. Kubernetes technician
2. Data warehouse administrator
3. Reporting system architect
5. Database consultant

Good morning dear ones,
I hope you had a pleasant weekend and I look forward to spending time with you all this week.  Also, I appreciate being a part of a great group of guys working together to make it through the week and maybe having a little fun on the way :-) As always please feel free to ask my help about anything at home or at work.
-Sincerely yours
Brent
260-564-4868

# Responsibilites
1. Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases. This includes validating our result sets to ensure they match what Plex shows on its reports and screens.  
2. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
3. Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-synchronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.
4. Provide secure communications to our web services by managing our CA, requesting and signing new certificates, and implementing PKI standards.
5. Program database ETL scripts and reporting system software.  

## Mobex Global web site
Our Mobex Global web site is secured by a 90 day CPanel signed certificate managed by another company.
## Report web service
We use "Let's Encrypt" for our Azure Ingress Controller use an automated PKI certificate renewal process.
We also have a low cost report viewer in the works that relies on a self-signed 398 day certificate.
This self-signed server certificate is signed by an internally generated CA using the defacto OpenSSL PKI library.
## Mach2 web service
This is secured by following the process found in the Niagara Station Security guide as well using the OpenSSL PKI library to create a self-signed server certificate.
### Niagara Station Security guide 
"Ensuring continued secure system access requires advance planning. There is no certificate renewal process. For each expiring certificate, you must create a new, replacement certificate, get it signed, import it into the User Key Store, and ensure that the root CA certificate used to sign it is in each station’s User Trust Store. If your company uses a third-party CA, the whole process can take a couple of weeks. As a best prac-tice, keep track of each certificate expiration date, and plan ahead to replace old certificates before they expire."

# Step 1: Creating private keys and certificates
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

openssl x509 -req -days 397 -in frt_kors43.csr -CA CA_certificate.pem -CAkey CA_private_key.key -out frt_kors43_certificate.pem -set_serial 01 -sha256

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

# Research Activities
## WHAT IF THE CUSTOMER HAS THEIR OWN CERTIFICATE?
https://www.niagara-community.com/s/article/Importing-a-PEM-file-using-Workbench
What if the customer has their own signed certificate from some signing authority and doesn’t want to generate one using the Niagara Certificate Manager. The steps for importing a PEM into the User Key Store will still apply. What is a bit different is they will need a PEM that contains the complete chain of trust for their certificate, and it must have the private key at the top. Normally the private key is optional, but that is when you have created the certificate on the Jace (or Supervisor), so the private key is already there. In the case of their own certificate, the Jace is not going to know the private key until it is imported via the PEM. 
As with all other certificates, you will need to import the CA related to the certificate into the System Trust Store. 
## What does tridium need to secure communications to Jace or web services.
If tridium has the private key of the frt-kors43 certificate it can use that to decode info the client sends.
If tridium has devcon2's signer certificate and the frt-kors43 any client can download the frt-kors43 entire certificate chain.
If the client is given devcon2's signer pubkey it can use that to decode the frt-kor43 certificate's signature and verify the certificate has not been changed since it was hashed.
If the client has the devcon2's signer certificate in it's trusted store any certificate it receives signed by is is trusted and the lock will appear in Chrome.

Goal: 
1. The devcon2's root certificate (CA) is imported into the 'System Trust store'.
2. The '.pem' with the frt-kors43 Private Key, certificate, and devcon2's root certificate (CA) is imported into the 'User Key Store'.
https://www.niagara-community.com/s/article/Importing-a-PEM-file-using-Workbench
"After you have signed the server cert for a station, make sure to go into the foxService and webService property sheets of that station and select the correct server certificate in the drop down."
Next:
Niagara Station Security guide 
Page 35 Importing the signed certificate back into the User Key Store
page 35 Installing a root certificate in the Windows trust store
Page 37 Manually importing a certificate into a User Trust Store
Use the newly signed PEM file to import back into the User Key Store to complete the signing process of the certificate(s).
Make sure to IMPORT the root certificate that was used to sign the certificates into every Jace and supervisor Trust store.
page 40 - When a certificate expires Each root, intermediate, server, and code-signing certificate remains valid for a specific period of time (Val-id From and Valid To dates). When a certificate expires, system users receive error messages.
Ensuring continued secure system access requires advance planning. There is no certificate renewal process. For each expiring certificate, you must create a new, replacement certificate, get it signed, import it into the User Key Store, and ensure that the root CA certificate used to sign it is in each station’s User Trust Store. If your company uses a third-party CA, the whole process can take a couple of weeks. As a best prac-tice, keep track of each certificate expiration date, and plan ahead to replace old certificates before they expire.

## How to download a certificate chain using a bash one-liner
$ openssl s_client -showcerts -verify 5 -connect stackoverflow.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done
- Niagara self-signed certificate expired Aug 2022.

## What is the OpenSSL PKI library
- This PKI library is the standard crypto library used by all
- Not only generates certificates but uses the complete PKI process including CSR request flow
document certificate process

## How do we import our self-signed root CA into our Windows trusted store. 
- Follow this process to add the Niagara default certificate to every computer using a group policy. https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/distribute-certificates-to-client-computers-by-using-group-policy 

## What references are there for the Niagara certificate process.
Niagara Station Security guide
**[Niagara Community](https://www.niagara-community.com/)**
**[creating and signing ssl certificate](https://know.innon.com/creating-signing-ssl-certificate-niagara)**
**[Importing a PEM file using Workbench](https://www.niagara-community.com/s/article/Importing-a-PEM-file-using-Workbench)**

Notes: All the docs I am seeing are from 2019 and 2020.
"The CA and Server Certificates can be created using the Certificate Management Tool. Alternatively you may choose to only create the Server Certificate using the Certificate Management Tool. Then generate a certificate signing request which is then sent to a well known signing authority to be signed and imported back into the station's 'User Key Store'."

# git submodules
git submodules because added them to devcontainer for go modules
https://git-scm.com/book/en/v2/Git-Tools-Submodules

# Slight reports system change
Customer requests report from Teams hosted PHP app which inserts request in queue and gets a report serial id.
Report runner pulls next request from queue
Runner needed because all ETL scripts need to be run before next report is ran
(Change) So the runner scales well a worker thread is created for each report database.
Runner thread calls start_etl method of Go Rest API and listens on an MQTT channel for result.
Go Rest API runs ETL script set and produces report set with given id and publishes an MQTT channel result.
MQTT used to notify web app status screen of completed reports.
(Add) Initially use Power BI paginated report but then add a Report Viewer web app accessible through Microsoft Teams.

## Ansible Playbooks
Ansible is now on our dev container image.  When the docker image is created it generates an Ed25519 key pair that is added to the authkeys file of each host in the inventory file by the parallel-ssh utility. After the public key is added to each host no password is required for Ansible to login.
So far I have created tho following playbooks.
- 'update and upgrade' which uses the apt Ansible plugin.
- 'reboot' which uses the plugin 

## What is Ed25519
In public-key cryptography, Edwards-curve Digital Signature Algorithm is a digital signature scheme using a variant of Schnorr signature based on twisted Edwards curves. It is designed to be faster than existing digital signature schemes without sacrificing security.

## Databases or Schemas
PostgreSQL can have up to 4GB of databases and our Azure SQL managed instance can have a maximum of 2,147,483,647 objects. The idea is to have several databases or schemas assigned to at most one report. 
r1: report 1, trial balance, azure schema
r1m: The main PostgreSQL database that the Teams hosted report connects to.
r1w: The PostgreSQL database used by report 1's first report runner's thread.
r2w: The PostgreSQL database used by report 1's second report runner's thread.
https://know.innon.com/creating-signing-ssl-certificate-niagara

niagara system trust store