https://en.wikipedia.org/wiki/PKCS_1
In cryptography, PKCS #1 is the first of a family of standards called Public-Key Cryptography Standards (PKCS), published by RSA Laboratories. It provides the basic definitions of and recommendations for implementing the RSA algorithm for public-key cryptography. It defines the mathematical properties of public and private keys, primitive operations for encryption and signatures, secure cryptographic schemes, and related ASN.1 syntax representations.

Keys
The PKCS #1 standard defines the mathematical definitions and properties that RSA public and private keys must have. The traditional key pair is based on a modulus, n, that is the product of two distinct large prime numbers, p and q, such that 
�
=
�
�
n = pq.

Starting with version 2.1, this definition was generalized to allow for multi-prime keys, where the number of distinct primes may be two or more. When dealing with multi-prime keys, the prime factors are all generally labeled as 
r_{i} for some i, such that:
As a notational convenience, 

The RSA public key is represented as the tuple 
(n, e), where the integer e is the public exponent.

The RSA private key may have two representations. The first compact form is the tuple 
compact form, the additional terms allow for certain computational optimizations when using the key. In particular, the second format allows to derive the public key.[1]


Primitives
The standard defines several basic primitives. The primitive operations provide the fundamental instructions for turning the raw mathematical formulas into computable algorithms.

I2OSP - Integer to Octet String Primitive - Converts a (potentially very large) non-negative integer into a sequence of bytes (octet string).
OS2IP - Octet String to Integer Primitive - Interprets a sequence of bytes as a non-negative integer
RSAEP - RSA Encryption Primitive - Encrypts a message using a public key
RSADP - RSA Decryption Primitive - Decrypts ciphertext using a private key
RSASP1 - RSA Signature Primitive 1 - Creates a signature over a message using a private key
RSAVP1 - RSA Verification Primitive 1 - Verifies a signature is for a message using a public key

Schemes
By themselves the primitive operations do not necessarily provide any security. The concept of a cryptographic scheme is to define higher level algorithms or uses of the primitives so they achieve certain security goals.

There are two schemes for encryption and decryption:

RSAES-OAEP: improved Encryption/decryption Scheme; based on the Optimal asymmetric encryption padding scheme proposed by Mihir Bellare and Phillip Rogaway.
RSAES-PKCS1-v1_5: older encryption/decryption scheme as first standardized in version 1.5 of PKCS #1.
Note: A small change was made to RSAES-OAEP in PKCS #1 version 2.1, causing RSAES-OAEP in PKCS #1 version 2.0 to be totally incompatible with RSA-OAEP in PKCS #1 version 2.1 and version 2.2.

There are also two schemes for dealing with signatures:

RSASSA-PSS: improved Probabilistic Signature Scheme with appendix; based on the probabilistic signature scheme originally invented by Bellare and Rogaway.
RSASSA-PKCS1-v1_5: old Signature Scheme with Appendix as first standardized in version 1.5 of PKCS #1.
The two signature schemes make use of separately defined encoding methods:

EMSA-PSS: encoding method for signature appendix, probabilistic signature scheme.
EMSA-PKCS1-v1_5: encoding method for signature appendix as first standardized in version 1.5 of PKCS #1.
The signature schemes are actually signatures with appendix, which means that rather than signing some input data directly, a hash function is used first to produce an intermediary representation of the data, and then the result of the hash is signed. This technique is almost always used with RSA because the amount of data that can be directly signed is proportional to the size of the keys; which is almost always much smaller than the amount of data an application may wish to sign.

