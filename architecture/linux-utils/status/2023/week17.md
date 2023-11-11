Good morning dear ones,
I hope you and your loved ones are doing well this week my friends. Isn't this time of year great after enduring so many dreary days in the winter months isn't great to be able to sit outside and soak up the sunshine! Since it is review time again I would like to take this oppurtunity to say how fortunate I feel to be working with such a kind, considerate, and thoughtful group of guys as yourselves.  Thank you so much!!!
As always please feel free to call me for whatever reason at home or at work.
-Sincerely yours,
Brent
260-564-4868

discuss MSC prep.
Big Picture:
1. Attempting to create a simple user interface for customers to manage longer running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
2. Give the option to our report customers to encrypt reports containing sensitive data. This requires key pairs for ciphers algorithms such as RSA or ECDSA. In our case we have a nonsycronizing private hockeypuck OpenPGP key server to manage these keys.

key server:
What is key server? https://en.wikipedia.org/wiki/Key_server_(cryptographic)
"In computer security, a key server is a computer that receives and then serves existing cryptographic keys to users or other programs. The users' programs can be running on the same network as the key server or on another networked computer.
The keys distributed by the key server are almost always provided as part of a cryptographically protected public key certificates containing not only the key but also 'entity' information about the owner of the key. The certificate is usually in a standard format, such as the OpenPGP public key format, the X.509 certificate format, or the PKCS format. Further, the key is almost always a public key for use with an asymmetric key encryption algorithm."

What is Mobex Global Private CA key server? It is used to create, approved, and sign certificates in the X.509 format.  
Why do we need a private Certificate Authority? 
1. To make sure a hacker do not intercept data entered into our web apps.
2. Secure traffic going to and from our database servers. 
3. Database and web services are not accessible to public certificate authorities without unnecessarily opening holes in our private network by setting up firewall rules. 
Why do we need a public Certificate Authority?
To host our K8s cloud based web services in Microsoft Teams which requires an HTTPS connection with TLS certificates signed by one of the 100 or so industry public certificate authorities.

Since we now have access to PKI tools and a private CA server I would like to find out other places we can use public keys. 
When signing keys the CA server configuration profile used requires a usages list.  Here is a list of certificate usages: 
	+ Other Key Usages
		+ signing
		+ digital signature
		+ content commitment
		+ key encipherment
		+ key agreement
		+ data encipherment
		+ cert sign
		+ crl sign
		+ encipher only
		+ decipher only
		
	+ More Key Usages
		+ any
		+ server auth
		+ client auth
		+ code signing
		+ email protection
		+ s/mime
		+ ipsec end system
		+ ipsec tunnel
		+ ipsec user
		+ timestamping
		+ ocsp signing
		+ microsoft sgc
		+ netscape sgc

What is the Mobex Global OpenPGP key server?
The OpenPGP format for cipher keys such as RSA is tied to a email address and a long key know as a fingerprint. The public key in OpenPGP is not signed by a trusted or public certificate authority as is the case for HTTPS web browsing, but by the entity performing the encryption at his own discresion. Each customer that wants there reports encrypted would have there own key pair whose public key is stored on our OpenPGP key server and whose private key is stored on his own computer. As part of the report creation pipeline the excel file would be encrypted using the customers public key so that only they would be able to decrypt it using the private key stored on their computer. 

[golang gpg/openpgp encryption/decryption example](
https://gist.github.com/stuart-warren/93750a142d3de4e8fdd2)

Manual File Encryption Process:
1. Recipient generates RSA key pair using email address.
2. Recipient exports public key to key server.
3. File owner imports recipients public key from key server.
4. File owner encrypts files or directories using recipients public key.
5. File owner emails or uploads encrypted file to FTP server or QNAP.
6. Recipient downloads encrypted file and decrypts it using his/her private key.

golang gpg/openpgp encryption/decryption example
https://gist.github.com/stuart-warren/93750a142d3de4e8fdd2

This example uses Ubuntu and the GPG utility to encrypt/decrypt files but GPG can also be installed on Windows:
[Windows GPG](https://learn.microsoft.com/en-us/system-center/orchestrator/standard-activities/pgp-decrypt-file?source=recommendations&view=sc-orch-2022#install-gnupg)

Maybe the currently most popular OpenPGP key server is:
[hockeypuck key server](https://canonical.com/blog/migrating-the-launchpad-keyservers-from-sks-to-hockeypuck)
"Ubuntu and Launchpad use OpenPGP keys heavily to manage binary and source packages from primary and user archives."

GPG is OpenPGP utility that is installed on many Linux distributions that this example uses. 
https://www.howtogeek.com/427982/how-to-encrypt-and-decrypt-files-with-gpg-on-linux/

# Generating your key pair
"The gpg command was installed on all of the Linux distributions that were checked, including Ubuntu, Fedora, and Manjaro."
pick a email address to associate this key pair with (moto.groves@gmail.com).
gpg --full-generate-key
# upload you public key to a key server
What is Hockeypuck? It is an OpenPGP public keyserver easily ran as a docker container.
Since we don't have a private keyserver I will use a public one.
- get a code uniquely identifying your key pair
gpg --fingerprint moto.groves@gmail.com
# go to remote computer
ssh brent@reports-avi
- install moto-groves@gmail.com public key on remote system.
gpg --keyserver pgp.mit.edu --search-keys moto.groves@gmail.com
# sign the key
gpg --sign-key moto.groves@gmail.com
# encypt raven.txt file
gpg --encrypt --sign --armor -r moto.groves@gmail.com raven.txt
gpg --encrypt --sign --armor -r moto.groves@gmail.com ~/Downloads/TB-202203_to_202303_on_04-11_GP.xlsx
# go back to recipient's computer
ssh brent@moto
lftp brent@reports-avi
get /home/brent/Downloads/TB-202203_to_202303_on_04-11_GP.xlsx.asc 
exit
gpg --decrypt TB-202203_to_202303_on_04-11_GP.xlsx.asc > TB-202203_to_202303_on_04-11_GP.xlsx

How does HMAC256 for our PKI and CA server work:
Combines base64 ASCII encoding, public key symetrical cipher, and SHA256 hashing to determine the message was not altered. We use this in the HTTP authsign endpoint to verify the CSR was not changed and the user at least has access to our randomly generated 16 byte Hex API key. 

What is a key pair?
The first step in creating a TLS certificate process is to generate a key pair.
- key pairs are used in ciphers such as ecsd and rsa to encrypt/decrypt messages.
- private key - used to decrypt message
- public key - used to encrypt message
- private/public key role reversal for certificate signatures. In this way we can use the CA public key to cipher and then hash the base64 DER encoded portion of the certificate to compare against the signature of the certificate to verify the certificate was generated from a legitimate CA in our trust store. 
- destinguished encoding rules (DER) portable binary data structure format used to encode certificate data such as CN, C, O, and OU. 
- signing - Applying a cipher to a HASH of all certificate data.
- cipher - used to encrypt/decrypt messages.
- hash - Used to encrypt messages, certificate data, to verify message has not been tampered with. 
- Asymetrical cipher, such as RSA and ECSDA, used in the signing of certificates relies witha key pair and is most secure.
- Symetrical cipher, such as AES, uses only one key to encrypt/decrypt messages, is faster than Asymetrical ciphers, and is what is used to encode/decode all data in an HTTPS connection except for the signing of certificates which uses an Asymetrical cipher to verify the author of a certificate. 

What is RBAC?
- defines different roles that make sense for each k8s object, such as create, get, and approve for the certificate object.
- defines users that are each tied to a certificate key pair for authentication purposes.
- binds roles to users.

How are certificates generated?
- usually certificates are generated with OpenSSL but can also be generated by the CFSSL golang PKI tools. K8s generates its own during installation.

K8s TLS certificates
- Are a regular k8s object.
- Use a modified version of the ACME protocol to automate the management of certificates.
- As part of the installation process a root certificate is generated that helps secure communications to the k8s API through programs such as the kubelet and kubectl.
- This certificate should be used for only k8s services. If you need a certificate for your own services then create one and store it as a k8s certificate object.
- used for all user authentication similar to how ssh keys are used to authenticate a user to a server.

ACME:
- Industry standard protocal used in the automated management of TLS certificates.
- Issuer objects are defined for different certificate authorities which do the actual signing of certificates. 

Why install a CA server?
- If k8s has it's own root certificate then why can't we just use it for signing?
- The k8s root certificate is meant to be used for actual or user create plugin k8s services only.
- It is tied to k8s intermal DNS although it can be made to work with user services and external DNS it is clumsy to do so and not recommended.
- Running PKI tools and CA server such as Cloud Flares CFSSL in Kubernetes is straigt-forward and useful to manage certificates that are to be used for both k8s and non-k8s services.


Key Info
https://stackoverflow.com/questions/14218925/how-can-i-decrypt-a-hmac
HMAC with SHA256 can only be used to hash a value, which is a one-way trip only. If you want to be able to encrypt/decrypt files you will have to use a program such as gpg or write code that uses a cipher, such as aes or des.

[Public Keys](https://www.digitalocean.com/community/tutorials/how-to-handle-apt-key-and-add-apt-repository-deprecation-using-gpg-to-add-external-repositories-on-ubuntu-22-04)
https://blog.mdaemon.com/encrypting-vs-signing-with-openpgp-whats-the-difference
