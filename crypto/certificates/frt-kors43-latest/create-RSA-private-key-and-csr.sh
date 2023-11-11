#!/bin/bash
#generate the RSA private key
openssl genpkey -outform PEM -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out priv.key

#Create the CSR (Click csrconfig.txt in the command below to download config)
openssl req -new -nodes -key priv.key -config x509.config -nameopt utf8 -utf8 -addext "certificatePolicies = 1.2.3.4" -out cert.csr