#!/usr/bin/env python
# https://pypi.org/project/pem/
# https://stackoverflow.com/questions/16899247/how-can-i-decode-a-ssl-certificate-using-python
# The core API call are the function pem.parse() and the its convenience helper pem.parse_file():
import pem
from pathlib import Path
from os import chdir

chdir('/home/brent/src/linux-utils/crypto/book/certificates')
with open("mobexglobal.com", "rb") as f:
  #  certs = pem.parse(f.read())
     certs = pem.OpenSSLTrustedCertificate(f.read)
print(certs.as_text())
# for x in certs:
#   print(x)
# or:
# certs = pem.parse_file("cert.pem")
# The function returns a list of valid PEM objects found in the string supplied.
# They can be transformed using str(obj) into native strings,
# or using obj.as_text() into Unicode text (str on Python 3, unicode on Python 2),
# or using obj.as_bytes() into bytes.
# Additional you can obtain the SHA-1 hexdigest using obj.hashdigest() for quick comparison of objects.

