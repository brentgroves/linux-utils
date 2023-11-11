https://stackoverflow.com/questions/12911373/how-do-i-use-a-x509-certificate-with-pycrypto
PyCrypto does not support X.509 certificates. You must first extract the public key with the command:

openssl x509 -inform pem -in mycert.pem -pubkey -noout > publickey.pem

openssl x509 -inform pem -in mobexglobal.com -pubkey -noout > publickey.pem
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3Q//mRUwrhM/jr89paur
RdJ6CnOSFhmZQ7bT7XuNXG2BPAoj+l6jLENsUIqbXm8hA0sP3Rh8IQtNJyFa7Ukb
cBx+TH5xz74DNV4hS7NlOIuw7r0e7utxSjvd1gRGJtCLsybGiJactqIUFNYZrbEz
dhbbKCeDHv84j1ai5p43EoAdeSiujoyHZq6jibtRs4I7IFiVWI5qSzXjyaRZo7c6
EhMN1dBQrxiVTQETNktfvs+XV1Pk+IjAk2KzoU5rHH2uDDHrSo3AGfKgpHrEBBGX
rW+d6wGLgvRv76JGx9cKI9Z59OD4S1RjpryP63HO3AbmB2VGJc8n/dw118x9+RyP
iwIDAQAB
-----END PUBLIC KEY-----

Then, you can use RSA.importKey on publickey.pem.

If you don't want or cannot use openssl, you can take the PEM X.509 certificate and do it in pure Python like this:

from Crypto.Util.asn1 import DerSequence
from Crypto.PublicKey import RSA
from binascii import a2b_base64

# Convert from PEM to DER
pem = open("mycert.pem").read()
lines = pem.replace(" ",'').split()
der = a2b_base64(''.join(lines[1:-1]))

# Extract subjectPublicKeyInfo field from X.509 certificate (see RFC3280)
cert = DerSequence()
cert.decode(der)
tbsCertificate = DerSequence()
tbsCertificate.decode(cert[0])
subjectPublicKeyInfo = tbsCertificate[6]

# Initialize RSA key
rsa_key = RSA.importKey(subjectPublicKeyInfo)