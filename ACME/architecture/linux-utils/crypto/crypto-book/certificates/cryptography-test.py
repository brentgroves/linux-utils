#!/usr/bin/env python
# https://cryptography.io/en/latest/x509/reference/#loading-certificates
# https://cryptography.io/en/latest/x509/reference/#loading-certificates
# https://launchpad.net/pyopenssl (this library has little documentation)
# The default OpenSSL version on Ubuntu 22.04 is 3.1.0 so this
# environment will use it unless you specifically install 1.1.1 in the conda environment.
from cryptography import x509
# import pem
from pathlib import Path
from os import chdir

chdir('/home/brent/src/linux-utils/crypto/book/certificates')
with open("mobexglobal.com", "rb") as f:
     pem_data = f.read()
# >>> with open("exercises.zip", mode="rb") as zip_file:
# ...     contents = zip_file.read()
cert = x509.load_pem_x509_certificate(pem_data)
print(cert.serial_number)