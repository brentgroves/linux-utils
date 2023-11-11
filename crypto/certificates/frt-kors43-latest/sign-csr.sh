#!/bin/bash
# Use the CA certificate to sign the end-entity certificate signing request
# openssl x509 -req -days number_of_days -in path_to_csr.csr -CA path_to_CA_certificate.pem -CAkey path_to_CA_key.key -out new_certificate.pem -set_serial 01 -sha256
# Serial number uniquely identifies a certificate within the CA

openssl x509 -req -days 20 -in cert.csr -CA CA_certificate.crt -CAkey CA_private_key.key -out certificate.crt -set_serial 07 -extfile v3.ext -sha256
