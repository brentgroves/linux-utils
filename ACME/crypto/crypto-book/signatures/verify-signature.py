#!/usr/bin/env python
# https://stackoverflow.com/questions/61175300/how-to-decrypt-with-public-key-in-pycryptodome-python-3-7

# What you're describing is a signature. Look at the sign/verify 
# API of pycryptodome. The words "encryption" and "decryption" 
# are confusing when applied to RSA. So it's better to reserve 
# the word encryption exclusively for the case when the sender 
# transforms plaintext using the receiver's public key. 
# Only the receiver can recover the plaintext. 
# When we transform the plaintext using our private key, 
# so that anybody can recover the plaintext with our public key, 
# that is called signing. – 
# President James K. Polk
#  Apr 13, 2020 at 15:40

# https://pycryptodome.readthedocs.io/en/latest/src/signature/pkcs1_v1_5.html
# An old but still solid digital signature scheme based on RSA.
# It is more formally called RSASSA-PKCS1-v1_5 in Section 8.2 
# of RFC8017.
# The following example shows how a private RSA key 
# (loaded from a file) can be used to compute the signature of 
# a message:

from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA256
from Crypto.PublicKey import RSA
message = b'To be signed'
key = RSA.import_key(open('private_key.der').read())
h = SHA256.new(message)
signature = pkcs1_15.new(key).sign(h)

key = RSA.import_key(open('public_key.der').read())
h = SHA256.new(message)
try:
    pkcs1_15.new(key).verify(h, signature)
    print("The signature is valid.")
except (ValueError, TypeError):
   print("The signature is not valid.")