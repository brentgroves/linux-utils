#!/usr/bin/env python
# https://stackoverflow.com/questions/51039393/get-or-build-pem-certificate-chain-in-python

# https://www.pyopenssl.org/en/stable/api/ssl.html#OpenSSL.SSL.Connection.get_peer_cert_chain
# https://www.pyopenssl.org/en/latest/
# pip install pyopenssl
# https://anaconda.org/anaconda/pyopenssl
# 23.0.0
# conda install -c anaconda pyopenssl
from OpenSSL import SSL
import socket
from cryptography import x509
from cryptography.exceptions import InvalidSignature

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives.asymmetric import padding

try:
  dst = ('stackoverflow.com', 443)
  # dst = ('www.google.com', 443)
  ctx = SSL.Context(SSL.SSLv23_METHOD)
  s = socket.create_connection(dst)
  s = SSL.Connection(ctx, s)
  s.set_connect_state()
  # Using bytes(str, enc)
  # convert string to byte
  url = bytes(dst[0], 'utf-8')
  # bstr=dst[0].encode('utf-8').tobytes()
  s.set_tlsext_host_name(url)

  s.sendall('HEAD / HTTP/1.0\n\n')
  s.recv(16)
  stack_pem = {}
  issuer_pem = {}
  root_pem = {}

  certs = s.get_peer_cert_chain()
  for pos, cert in enumerate(certs):
    print("Certificate #" + str(pos))
    for component in cert.get_subject().get_components():
        print("Subject %s: %s" % (component))
    print ("notBefore:" + str(cert.get_notBefore()))
    print ("notAfter:" + str(cert.get_notAfter()))
    print ("version:" + str(cert.get_version()))
    print ("sigAlg:" + str(cert.get_signature_algorithm()))
    print ("digest:" + str(cert.digest('sha256')))
    if pos==0:
        tbs_pem=cert.to_cryptography().public_bytes(serialization.Encoding.PEM)
    if pos==1:
        issuer_pem=cert.to_cryptography().public_bytes(serialization.Encoding.PEM)
    if pos==2:
        root_pem=cert.to_cryptography().public_bytes(serialization.Encoding.PEM)

  tbs_cert = x509.load_pem_x509_certificate(tbs_pem)
  issuer_cert = x509.load_pem_x509_certificate(issuer_pem)

  # https://cryptography.io/en/latest/hazmat/primitives/asymmetric/serialization/
  # print(issuer_cert.public_key)
  public_key = issuer_cert.public_key()
  # print(isinstance(public_key, rsa.RSAPublicKey))
  # https://cryptography.io/en/latest/hazmat/primitives/asymmetric/rsa/#module-cryptography.hazmat.primitives.asymmetric.rsa
  pem = public_key.public_bytes(
    encoding=serialization.Encoding.PEM,
    format=serialization.PublicFormat.SubjectPublicKeyInfo
  )
# print(pem)
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

  print("done")
except InvalidSignature as error:
    print(error)
    print('Invalid Signature')

except ValueError:
    print('If the issuer name on the certificate does not match the subject name of the issuer or the signature algorithm is unsupported.')    

except TypeError:
    print('If the issuer does not have a supported public key type.')    

