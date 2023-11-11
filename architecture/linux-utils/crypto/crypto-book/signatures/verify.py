#!/usr/bin/env python
# https://www.educative.io/answers/how-to-verify-digital-signature-in-python-using-ecdsa-signingkey
from ecdsa import SigningKey
private_key = SigningKey.generate() # uses NIST192p
signature = private_key.sign(b"Educative authorizes this shot")
print(signature)
public_key = private_key.verifying_key
print("Verified:", public_key.verify(signature, b"Educative authorizes this shot"))