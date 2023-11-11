What is signing?
Encrypting the hash is called signing. This is how a signature is generated. We can’t know the signature beforehand to sign it.



CA computes a hash from all the certificate data except the signature.
The CA then encrypts the hash using a symetrical encryption.
The encrypted hash is the digital signature. 
We use the public key sent in the certificate to decrypt its digital signature.
We then compare the hash sent in the certificate with the value we decrypted.
If the two values are the same the certificate is valid.

Verify SSL/TLS Certificate Signature

Introduction
If you’ve read/heard about digital signatures, openssl, public key cryptography, https or tls, you may have wondered

“How does my browser use these signatures?”
“How does my browser verify these digital signatures?”
“When amazon.com provides a digital certificate, how and why does my browser trust it?”
This article lets us take the reins of browser and be the verification guard using openssl tools. Let’s try to understand what goes behind the scenes of a browser’s certificate signature verification.

Prerequisites
Linux based machine
OpenSSL (it’s usually installed on linux based machines)
First of all, why should we (as in browsers) verify?
Let’s say we’ve read about uses of Diffie-Hellman, RSA1 public key cryptography, AES-CBC2 and hash algorithms. Now, if we were supposed to design a secure architecture to browse amazon.com, our thought process would be something like:

Hmm, let me see… First of all, I need to encrypt my passwords, credit card info etc, so I need a key to encrypt. The server also needs to have the same key to decrypt my content and to encrypt the data it sends me”

However, it’s impractical to visit Amazon Seattle HQ and get a key exchanged. It’s also ridiculously idiotic to trade our secret key as plaintext on internet. It’s as good as handing out the key to anyone listening to our connection. I need a secure key exchange protocol like DHKE3!”

If I can trade my DH4 public parameters with amazon.com, we (server and I) can securely generate our own little shared secret key and we can use that to encrypt/decrypt stuff”
“Whoops! If I receive DH public parameters as plaintext on internet, the person listening to our connection in starbucks could also send me those parameters and I could end up trading keys with him! That’s bad!”

IDEA!! Is this the best idea or what! What if amazon.com can share it’s public key with me, sign DH parameters using it’s private key! Now, when I decrypt using amazon’s public key, I can be 100% sure that amazon.com had signed it using it’s private key and nobody else! YAY!! Problem solved!”

(After a few minutes …)

“I think I celebrated a little early! I think we’re back to the same problem. What if this impersonator in my network sends me a public key and claims that amazon.com sent it? How do I verify??”

This is where we need a “Trusted Third Party/Certificate Authority/CA)”. CA computes a hash over all the certificate data (except signature) and encrypts the hash with it’s private key.

[Q] Why was the signature excluded from hash?
[A] CA doesn’t have a time machine to go into the future and see what signature would be generated. If it did, it would sign the entire certificate including the future signature.

FYI: Encrypting the hash is called signing. This is how a signature is generated. We can’t know the signature beforehand to sign it.

So, the signature is delivered separately to clients?
[A] No, it’s part of the certificate. All of the data you need to validate the server’s identity is contained in the certificate (including the signature). So, you need to remove the signature field before computing the hash and verifying.

What data is signed??
[A] Entity’s identity, validity, extensions, public key and a lot of other data related to entity is signed by the CA. If any parts of the certificate are modified by a man-in-the-middle, the CA’s signature will not validate.

Basic structure of a X.509 certificate
The basic structure of a certificate is shown in the specification for X.509 certificates on the Internet, RFC5280.

X.509 v3 certificate basic syntax:

   Certificate  ::=  SEQUENCE  {
        tbsCertificate       TBSCertificate,
        signatureAlgorithm   AlgorithmIdentifier,
        signatureValue       BIT STRING  }

TBSCertificate (TBS is short for To Be Signed),
tbsCertificate:	The field contains the names of the subject and issuer, a public key associated with the subject, a validity period, and other associated information

signatureAlgorithm:	Identifier for the cryptographic algorithm used by the CA to sign this certificate

signatureValue:	Digital signature computed upon the ASN.1 DER encoded tbsCertificate

Consider tbsCertificate, signatureAlgorithm, signatureValue as custom data types (struct) with other fields.

So, Certificate has a SEQUENCE. A SEQUENCE contains an ordered field of one or more types. It is encoded into a (type-length-value) TLV triplet that begins with a Tag byte of 0x30. tbsCertificate and signatureAlgorithm also have a SEQUENCE.

TBSCertificate  ::=  SEQUENCE  {
        version         [0]  EXPLICIT Version DEFAULT v1,
        serialNumber         CertificateSerialNumber,
        signature            AlgorithmIdentifier,
        issuer               Name,
        validity             Validity,
        subject              Name,
        subjectPublicKeyInfo SubjectPublicKeyInfo,
        issuerUniqueID  [1]  IMPLICIT UniqueIdentifier OPTIONAL,
                             -- If present, version MUST be v2 or v3
        subjectUniqueID [2]  IMPLICIT UniqueIdentifier OPTIONAL,
                             -- If present, version MUST be v2 or v3
        extensions      [3]  EXPLICIT Extensions OPTIONAL
                             -- If present, version MUST be v3
        }

AlgorithmIdentifier  ::=  SEQUENCE  {
        algorithm               OBJECT IDENTIFIER,
        parameters              ANY DEFINED BY algorithm OPTIONAL  }

Just to get a glimpse of how this data is structured, it’s probably a good time to take a look at the super helpful ASN.1 decoder by Lapo Luchini.

In order to verify that a certificate was signed by a specific CA, we would need to possess the following:

Public key of the CA (issuer)
Signature and Algorithm used to generate the signature

Verifying server’s public key
Download the server’s certificates to /tmp in PEM format.

$ openssl s_client -connect stackoverflow.com:443 -showcerts 2>/dev/null </dev/null \
  | sed -n '/-----BEGIN/,/-----END/p' > ./stackoverflow-certs.crt

openssl s_client -connect mobexglobal.com:443 -showcerts 2>/dev/null </dev/null \
  | sed -n '/-----BEGIN/,/-----END/p' > ./mobexglobal-certs.crt

  [Q] I thought a server has one certificate, what are these other certificates that we’re downloading?

[A] You are right, server always needs to show just one certificate. The other certificates are the intermediary and probably root CA certificates. We need those to get the intermediary public keys (Issuer’s public key)

he above openssl command creates a file in this format:

$ cat /tmp/stackoverflow-certs.crt 
-----BEGIN CERTIFICATE-----
MIIIPDCCBySgAwIBAgIQB2XGTnTlkdaAOcoqhHVj8DANBgkqhkiG9w0BAQsFADBw
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
...
aVnw9vahqf7nKHHcC2VRTUgkQfn9yDmmBOo0nQ8Xgfpd65/PaxVfBnuKfEkXBfpM
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIEsTCCA5mgAwIBAgIQBOHnpNxc8vNtwCtCuF0VnzANBgkqhkiG9w0BAQsFADBs
...
/D6q1UEL2tU2ob8cbkdJf17ZSHwD2f2LSaCYJkJA69aSEaRkCldUxPUd1gJea6zu
xICaEnL6VpPX/78whQYwvwt/Tv9XBZ0k7YXDK/umdaisLRbvfXknsuvCnQsH6qqF
0wGjIChBWUMo0oHjqvbsezt3tkBigAVBRQHvFwY+3sAzm2fTYS5yh+Rp/BIAV0Ae
cPUeybQ=
-----END CERTIFICATE-----

pushd ~/src/linux-utils/crypto/certificates
There’s a bash one-liner magic that can extract certificates in their own files:
pushd ~/src/linux-utils/crypto
$ openssl s_client -showcerts -verify 5 -connect stackoverflow.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

openssl s_client -showcerts -verify 5 -connect mobexglobal.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

If you’re uncomfortable using that one-liner, that’s fine too. 2 more steps and we will get the same output.

Download all the certificates offered by server to a file /tmp/stackoverflow-certs.crt

$ openssl s_client -connect stackoverflow.com:443 -showcerts 2>/dev/null \
</dev/null | sed -n '/-----BEGIN/,/-----END/p' > /tmp/stackoverflow-certs.crt
*.crt is just an extension to identify it as certificate but the file is of PEM type

Just copy the contents between -----BEGIN CERTIFICATE----- and -----END CERTIFICATE-----(including these delimiters) into their own files. In this case, I have 2 sections with those delimiters and hence I will create 2 files

$ ls -la stackoverflow*
-rw-rw-r-- 1 <username>  <groupname> 1688 Mar 11 13:28 stackoverflow.1.crt
-rw-rw-r-- 1 <username>  <groupname> 2914 Mar 11 13:29 stackoverflow.2.crt
-rw-rw-r-- 1 <username>  <groupname> 4602 Mar 11 12:03 stackoverflow-certs.crt

https://www.gnu.org/software/gawk/manual/html_node/Ranges.html
$ openssl s_client -showcerts -verify 5 -connect stackoverflow.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

https://unix.stackexchange.com/questions/368123/how-to-extract-the-root-ca-and-subordinate-ca-from-a-certificate-chain-in-linux/487546#487546


if line contains BEGIN increment a.
and output all the lines in the range to cert{a}.crt

s_client : Implements a generic SSL/TLS client which connects to a remote host using SSL/TLS
-showcerts: Displays the server certificate list as sent by the server

2>/dev/null: redirects stderr to /dev/null

< /dev/null: instantly send EOF to the program, so that it doesn’t wait for input

# note have to change this from DigiCert to Let's Encrypt
Make sure you have the issuer certificate of stackoverflow.com certificate

$ openssl x509 -in stackexchange.crt -noout -issuer
issuer= /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert SHA2 High Assurance Server CA
openssl x509 -in stackoverflow.1.crt -subject -noout
subject= /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert SHA2 High Assurance Server CA

The issuer is DigiCert SHA2 High Assurance Server CA and we have issuer’s certificate DigiCert_SHA2_High_Assurance_Server_CA.crt which has issuer’s public key

Obtain Issuer’s public key
# switch this to Let's Encrypt
pushd ~/src/linux-utils/crypto/book/signatures
$ openssl x509 -in "subject=C_=_US_O_=_Let's_Encrypt_CN_=_R3.pem" -noout \
  -pubkey > issuer-pub.pem

x509: display certificate information, convert certificates to 
     various forms, sign certificate requests or edit certificate trust 
     settings
-in: input filename to read a certificate from
-noout: prevents output of the encoded version of the certificate
-pubkey: Outputs the certificate\'s SubjectPublicKeyInfo block in PEM format


Get the signature of certificate in binary format

The default behavior of the following command is to print all fields

$ openssl x509 -in 'subject=CN_=__stackexchange_com.pem' -noout -text

However, there are command line options to specify which fields should be excluded while printing

$ openssl x509 -in 'subject=CN_=__stackexchange_com.pem' -text -noout -certopt ca_default \
  -certopt no_validity -certopt no_serial -certopt no_subject \
  -certopt no_extensions -certopt no_signame

  Where,

x509: display certificate information, convert certificates to various forms, sign certificate requests or edit 		
	  certificate trust settings
-in: input filename to read a certificate from
-noout: prevents output of the encoded version of the certificate
-text: Prints out the certificate in text form. Full details are output including the public key, signature algorithms, 
	   issuer and subject names, serial number any extensions present and any trust settings
-certopt: Customise the output format used with -text

The output tells us that the certificate was hashed usingSHA256 . However, the output you see is in hex and is separated by :. Let’s remove the first line, colon separator and spaces to get just the hex part

export SIGNATURE_HEX=$(openssl x509 -in 'subject=CN_=__stackexchange_com.pem' -text -noout -certopt ca_default -certopt no_validity -certopt no_serial -certopt no_subject -certopt no_extensions -certopt no_signame | grep -v 'Signature Algorithm' | tr -d '[:space:]:')
   
$ echo $SIGNATURE_HEX 

tr
Unix-like operating system command
tr is a command in Unix, Plan 9, Inferno, and Unix-like operating systems. It is an abbreviation of translate or transliterate, indicating its operation of replacing or removing specific characters in its input data set. Wikipedia
Stands for: Translate
Function: Translate, squeeze, and/or delete characters from standard input, writing to standard output
Syntax: tr -cds STRING1 STRING2
Example: tr A-Z a-z <mixed >lower

Convert the signature to binary
$ echo ${SIGNATURE_HEX} | xxd -r -p > stackexchange-signature.bin


If you prefer a straightforward command-line to obtain your signature in binary:

Find out the offset where RSA signature lives in the certificate:

$ openssl asn1parse -in 'subject=CN_=__stackexchange_com.pem'

You can also use https://lapo.it/asn1js to verify where your BIT STRING starts

In my example, the signature begins at an offset of 1572. There is no other section/content below it. So you can safely consume everything from offset 1851 and it will be the signature bytes

$ openssl asn1parse -in 'subject=CN_=__stackexchange_com.pem' -strparse 1572 -out verify-signature.bin
Error in encoding
140545980245696:error:0D07207B:asn1 encoding routines:ASN1_get_object:header too long:asn1_lib.c:157:
     
$ file stackexchange-signature.bin 
stackexchange-signature.bin: data

I’ve no idea why that throws up that encoding error but the signature dump is successful.
https://kulkarniamit.github.io/whatwhyhow/howto/verify-ssl-tls-certificate-signature.html#fn:1
Use issuer’s public key (Remember the issuer signed the server certificate using the corresponding private key) to decrypt the signature.
pushd ~/src/linux-utils/crypto/certificates/stackoverflow
$ openssl rsautl -verify -inkey issuer-pub.pem -in stackexchange-signature.bin -pubin > stackexchange-signature-decrypted.bin

rsautl: command can be used to sign, verify, encrypt and decrypt data using the RSA algorithm
-verify: verify the input data and output the recovered data
-inkey: the input key file
-in: input filename to read data from
-pubin: input file is an RSA public key