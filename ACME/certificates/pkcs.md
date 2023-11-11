https://en.wikipedia.org/wiki/PKCS

In cryptography, PKCS stands for "Public Key Cryptography Standards". These are a group of public key cryptography standards devised and published by RSA Security LLC, starting in the early 1990s

In cryptography, PKCS stands for "Public Key Cryptography Standards". These are a group of public key cryptography standards devised and published by RSA Security LLC, starting in the early 1990s. The company published the standards to promote the use of the cryptography techniques to which they had patents, such as the RSA algorithm, the Schnorr signature algorithm and several others. Though not industry standards (because the company retained control over them), some of the standards have begun to move into the "standards track" processes of relevant standards organizations in recent years[when?], such as the IETF and the PKIX working group.

PKCS Standards Summary
Version	Name	Comments
PKCS #1	2.2	RSA Cryptography Standard[1]	See RFC 8017. Defines the mathematical properties and format of RSA public and private keys (ASN.1-encoded in clear-text), and the basic algorithms and encoding/padding schemes for performing RSA encryption, decryption, and producing and verifying signatures.
PKCS #2	-	Withdrawn	No longer active as of 2010. Covered RSA encryption of message digests; subsequently merged into PKCS #1.
PKCS #3	1.4	Diffie–Hellman Key Agreement Standard[2]	A cryptographic protocol that allows two parties that have no prior knowledge of each other to jointly establish a shared secret key over an insecure communications channel.
PKCS #4	-	Withdrawn	No longer active as of 2010. Covered RSA key syntax; subsequently merged into PKCS #1.
PKCS #5	2.1	Password-based Encryption Standard[3]	See RFC 8018 and PBKDF2.
PKCS #6	1.5	Extended-Certificate Syntax Standard[4]	Defines extensions to the old v1 X.509 certificate specification. Obsoleted by v3 of the same.
PKCS #7	1.5	Cryptographic Message Syntax Standard[5]	See RFC 2315. Used to sign and/or encrypt messages under a PKI. Used also for certificate dissemination (for instance as a response to a PKCS #10 message). Formed the basis for S/MIME, which is as of 2010 based on RFC 5652, an updated Cryptographic Message Syntax Standard (CMS). Often used for single sign-on.
PKCS #8	1.2	Private-Key Information Syntax Standard[6]	See RFC 5958. Used to carry private certificate keypairs (encrypted or unencrypted).
PKCS #9	2.0	Selected Attribute Types[7]	See RFC 2985. Defines selected attribute types for use in PKCS #6 extended certificates, PKCS #7 digitally signed messages, PKCS #8 private-key information, and PKCS #10 certificate-signing requests.
PKCS #10	1.7	Certification Request Standard[8]	See RFC 2986. Format of messages sent to a certification authority to request certification of a public key. See certificate signing request.

This command generates two files; it generates server.csr containing the PEM encoded PKCS#10 certification request, and server-key.pem containing the PEM encoded key to the certificate that is still to be created.

