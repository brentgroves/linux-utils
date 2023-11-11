#!/usr/bin/env python
# https://pem.readthedocs.io/en/stable/twisted.html
import pem

from twisted.internet import ssl

key = pem.parse_file("key.pem")
cert, chain = pem.parse_file("cert_and_chain.pem")
cert = ssl.PrivateCertificate.loadPEM(str(key) + str(cert))
chainCert = ssl.Certificate.loadPEM(str(chain))
dhParams = ssl.DiffieHellmanParameters(str(pem.parse_file("dhparams.pem")))

ctxFactory = ssl.CertificateOptions(
      privateKey=cert.privateKey.original,
      certificate=cert.original,
      extraCertChain=[chainCert.original],
      dhParameters=dhParams,
)
# Turns out, this is a major use case. Therefore it can be simplified to:

# ctxFactory = pem.twisted.certificateOptionsFromFiles(
#    "key.pem", "cert_and_chain.pem", "dhparams.pem",
# )