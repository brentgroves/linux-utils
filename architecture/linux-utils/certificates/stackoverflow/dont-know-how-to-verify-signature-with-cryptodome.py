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

from cryptography import x509
from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives import serialization

from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA256
from Crypto.PublicKey import RSA
from pathlib import Path
from os import chdir

try:
  chdir('/home/brent/src/linux-utils/crypto/certificates/stackoverflow')
  with open("subject=C_=_US_O_=_Let's_Encrypt_CN_=_R3.pem", "rb") as f:
      pem_data = f.read()
  # >>> with open("exercises.zip", mode="rb") as zip_file:
  # ...     contents = zip_file.read()
  issuer_cert = x509.load_pem_x509_certificate(pem_data)
  public_key = issuer_cert.public_key()
  # print(isinstance(public_key, rsa.RSAPublicKey))
  # https://cryptography.io/en/latest/hazmat/primitives/asymmetric/rsa/#module-cryptography.hazmat.primitives.asymmetric.rsa
  pem = public_key.public_bytes(
    encoding=serialization.Encoding.PEM,
    format=serialization.PublicFormat.SubjectPublicKeyInfo
  )
  print(pem)
  key = RSA.import_key(pem)
  # key = RSA.import_key(open('public_key.der').read())
  with open("subject=CN_=__stackexchange_com.pem", "rb") as f:
      pem_data = f.read()
  # >>> with open("exercises.zip", mode="rb") as zip_file:
  # ...     contents = zip_file.read()
  tbs_cert = x509.load_pem_x509_certificate(pem_data)
  signature = tbs_cert.signature
  print(signature)
  tbs_certificate_bytes=tbs_cert.tbs_certificate_bytes
  print(tbs_certificate_bytes)
  signature_hash_algorithm=tbs_cert.signature_hash_algorithm
  print(signature_hash_algorithm)
  pkcs1_15.new(key).verify(h, signature)

  print("done")
except InvalidSignature as error:
    print(error)
    print('Invalid Signature')

except ValueError:
    print('If the issuer name on the certificate does not match the subject name of the issuer or the signature algorithm is unsupported.')    

except TypeError:
    print('If the issuer does not have a supported public key type.')    



# message = b'To be signed'
# key = RSA.import_key(open('private_key.der').read())
# h = SHA256.new(message)
# signature = pkcs1_15.new(key).sign(h)

# key = RSA.import_key(open('public_key.der').read())
# h = SHA256.new(message)
# try:
#     pkcs1_15.new(key).verify(h, signature)
#     print("The signature is valid.")
# except (ValueError, TypeError):
#    print("The signature is not valid.")

