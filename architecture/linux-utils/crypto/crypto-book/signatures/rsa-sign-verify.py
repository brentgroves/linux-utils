#!/usr/bin/env python
# https://cryptobook.nakov.com/digital-signatures/rsa-sign-verify-examples
# https://www.pycryptodome.org/src/examples

# Let's demonstrate in practice the RSA sign / verify algorithm. We shall use the pycryptodome package 
# in Python to generate RSA keys. After the keys are generated, we shall compute RSA digital signatures and 
# verify signatures by a simple modular exponentiation (by encrypting and decrypting the message hash).
# Next, generate a 1024-bit RSA key-pair:
from Crypto.PublicKey import RSA
keyPair = RSA.generate(bits=1024)
print(f"Public key:  (n={hex(keyPair.n)}, e={hex(keyPair.e)})")
print(f"Private key: (n={hex(keyPair.n)}, d={hex(keyPair.d)})")


# Now, let's sign a message, using the RSA private key {n, d}. Calculate its hash and raise the hash 
# to the power d modulo n (encrypt the hash by the private key). We shall use SHA-512 hash. It will 
# fit in the current RSA key size (1024). 
# In Python we have modular exponentiation as built in function pow(x, y, n):
# Given three numbers x, y and p, compute (x^y) % p Examples:
# Input:  x = 2, y = 3, p = 5
# Output: 3
# Explanation: 2^3 % 5 = 8 % 5 = 3.
# Input:  x = 2, y = 5, p = 13
# Output: 6
# Explanation: 2^5 % 13 = 32 % 13 = 6.

# Modular exponentiation is the remainder when an integer b (the base) is raised to the power e (the exponent), 
# and divided by a positive integ and m = 13, dividing 53 = 125 by 13 leaves a remainder of c = 8.

# https://cryptobook.nakov.com/digital-signatures/rsa-sign-verify-examples

# RSA sign the message
msg = b'A message for signing'
from hashlib import sha512
hash = int.from_bytes(sha512(msg).digest(), byteorder='big')
signature = pow(hash, keyPair.d, keyPair.n)
print("Signature:", hex(signature))


# The obtained digital signature is an integer in the range of the RSA key length [0...n). 
# For the above private key and the above message, the obtained signature looks like this:
# Signature: 0x650c9f2e6701e3fe73d3054904a9a4bbdb96733f1c4c743ef573ad6ac14c5a3bf8a4731f6e6276faea5247303677fb8dbdf24ff78e53c25052cdca87eecfee85476bcb8a05cb9a1efef7cb87dd68223e117ce800ac46177172544757a487be32f5ab8fe0879fa8add78be465ea8f8d5acf977e9f1ae36d4d47816ea6ed41372b

# The signature is 1024-bit integer (128 bytes, 256 hex digits). 
# This signature size corresponds to the RSA key size.

# RSA verify signature
msg = b'A message for signing'
hash = int.from_bytes(sha512(msg).digest(), byteorder='big')
hashFromSignature = pow(signature, keyPair.e, keyPair.n)
print("Signature valid:", hash == hashFromSignature)