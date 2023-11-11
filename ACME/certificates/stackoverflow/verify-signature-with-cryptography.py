#!/usr/bin/env python
# https://cryptography.io/en/latest/x509/reference/#loading-certificates
# https://cryptography.io/en/latest/x509/reference/#loading-certificates
# https://cryptography.io/en/latest/x509/reference/#cryptography.x509.Certificate.tbs_certificate_bytes
# https://launchpad.net/pyopenssl (this library has little documentation)
# The default OpenSSL version on Ubuntu 22.04 is 3.1.0 so this
# environment will use it unless you specifically install 1.1.1 in the conda environment.

from cryptography import x509
from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives.serialization import load_pem_private_key
from cryptography.hazmat.primitives.serialization import load_pem_public_key
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import padding
# import pem
from pathlib import Path
from os import chdir

try:
  chdir('/home/brent/src/linux-utils/crypto/certificates/stackoverflow')
  with open("subject=C_=_US_O_=_Let's_Encrypt_CN_=_R3.pem", "rb") as f:
      pem_data = f.read()
  # >>> with open("exercises.zip", mode="rb") as zip_file:
  # ...     contents = zip_file.read()
  issuer_cert = x509.load_pem_x509_certificate(pem_data)

  # key = load_pem_private_key(pem_data, password=None)
  # https://cryptography.io/en/latest/hazmat/primitives/asymmetric/serialization/
  # print(issuer_cert.public_key)
  public_key = issuer_cert.public_key()
  print(isinstance(public_key, rsa.RSAPublicKey))
  # https://cryptography.io/en/latest/hazmat/primitives/asymmetric/rsa/#module-cryptography.hazmat.primitives.asymmetric.rsa
  pem = public_key.public_bytes(
    encoding=serialization.Encoding.PEM,
    format=serialization.PublicFormat.SubjectPublicKeyInfo
  )
  print(pem)

  # with open("subject=C_=_US_O_=_Internet_Security_Research_Group_CN_=_ISRG_Root_X1.pem", "rb") as f:
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
# An InvalidSignature exception will be 
# raised if the signature fails to verify.
  public_key.verify(
      tbs_cert.signature,
      tbs_cert.tbs_certificate_bytes,
      # Depends on the algorithm used to create the certificate
      padding.PKCS1v15(),
      tbs_cert.signature_hash_algorithm
  )
  print("Signature verified")
  # https://cryptography.io/en/latest/x509/reference/#cryptography.x509.Certificate.verify_directly_issued_by
  # verify_directly_issued_by(issuer)[source]
  # Parameters
  # :
  # issuer (Certificate) – The issuer certificate to check against.

  # Warning
  # This method verifies that the certificate issuer name matches 
  # the issuer subject name and that the certificate is signed by 
  # the issuer’s private key. No other validation is performed. 
  # Callers are responsible for performing any additional 
  # validations required for their use case (e.g. checking the 
  # validity period, whether the signer is allowed to issue 
  # certificates, that the issuing certificate has a strong public 
  # key, etc).

  # Validates that the certificate is signed by the provided issuer 
  # and that the issuer’s subject name matches the issuer name of 
  # the certificate.

  # Returns
  # :
  # None

  # Raises
  # :
  # ValueError – If the issuer name on the certificate does not match the subject name of the issuer or the signature algorithm is unsupported.
  # TypeError – If the issuer does not have a supported public key type.


  print("done")
except InvalidSignature as error:
    print(error)
    print('Invalid Signature')

except ValueError:
    print('If the issuer name on the certificate does not match the subject name of the issuer or the signature algorithm is unsupported.')    

except TypeError:
    print('If the issuer does not have a supported public key type.')    

  # An InvalidSignature exception will be raised if the signature fails to verify.
# https://cryptography.io/en/latest/x509/reference/#cryptography.x509.Certificate.tbs_certificate_bytes
# issuer_public_key=issuer_cert.public_key
# issuer_public_key = load_pem_public_key(issuer_cert_public_key)


# from cryptography.hazmat.primitives.serialization import load_pem_public_key
# from cryptography.hazmat.primitives.asymmetric import padding
# issuer_public_key = load_pem_public_key(pem_issuer_public_key)
# cert_to_check = x509.load_pem_x509_certificate(pem_data_to_check)
# issuer_public_key.verify(
#     cert_to_check.signature,
#     cert_to_check.tbs_certificate_bytes,
#     # Depends on the algorithm used to create the certificate
#     padding.PKCS1v15(),
#     cert_to_check.signature_hash_algorithm,
# )

# from cryptography import x509
# # import pem
# from pathlib import Path
# from os import chdir

# chdir('/home/brent/src/linux-utils/crypto/certificates/stackoverflow')
# with open("subject=C_=_US_O_=_Let's_Encrypt_CN_=_R3.pem", "rb") as f:
#      pem_data = f.read()
# # >>> with open("exercises.zip", mode="rb") as zip_file:
# # ...     contents = zip_file.read()
# issuer_cert = x509.load_pem_x509_certificate(pem_data)
# print(issuer_cert.p.serial_number)