#!/usr/bin/env python
# https://cryptobook.nakov.com/digital-signatures/rsa-sign-verify-examples
# https://www.pycryptodome.org/src/examples
# https://pycryptodome.readthedocs.io/en/latest/src/signature/pkcs1_v1_5.html

# The simple use of RSA signatures is demonstrated above, but the industry usually follows the crypto standards.
# For the RSA signatures, the most adopted standard is "PKCS#1", which has several versions (1.5, 2.0, 2.1, 2.2), 
# the latest described in RFC 8017. The PKCS#1 standard defines the RSA signing algorithm (RSASP1) and the RSA 
# signature verification algorithm (RSAVP1), 
# which are almost the same like the implemented in the previous section.

# To demonstrate the PKCS#1 RSA digital signatures, we shall use the following code, based on the pycryptodome 
# Python library, which implements RSA sign / verify, following the PKCS#1 v1.5 specification:


from Crypto.PublicKey import RSA
from Crypto.Signature.pkcs1_15 import PKCS115_SigScheme
from Crypto.Hash import SHA256
import binascii

# Generate 1024-bit RSA key pair (private + public key)
keyPair = RSA.generate(bits=1024)
pubKey = keyPair.publickey()

# Sign the message using the PKCS#1 v1.5 signature scheme (RSASP1)
msg = b'Message for RSA signing'
hash = SHA256.new(msg)
signer = PKCS115_SigScheme(keyPair)
signature = signer.sign(hash)
print("Signature:", binascii.hexlify(signature))

# Verify valid PKCS#1 v1.5 signature (RSAVP1)
msg = b'Message for RSA signing'
hash = SHA256.new(msg)
verifier = PKCS115_SigScheme(pubKey)
try:
    verifier.verify(hash, signature)
    print("Signature is valid.")
except:
    print("Signature is invalid.")

# Verify invalid PKCS#1 v1.5 signature (RSAVP1)
msg = b'A tampered message'
hash = SHA256.new(msg)
verifier = PKCS115_SigScheme(pubKey)
try:
    verifier.verify(hash, signature)
    print("Signature is valid.")
except:
    print("Signature is invalid.")