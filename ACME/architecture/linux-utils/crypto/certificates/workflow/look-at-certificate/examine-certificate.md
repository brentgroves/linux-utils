openssl x509 -in frtkors43v1_cert_chain.pem -noout -issuer
openssl x509 -in frtkors43v1_cert_chain.pem -noout -pubkey
openssl x509 -in frtkors43v1_cert_chain.pem -noout -enddate
openssl x509 -in frtkors43v1_cert_chain.pem -noout -serial
openssl x509 -in frtkors43v1_cert_chain.pem -noout -text

https://www.mkssoftware.com/docs/man1/openssl_x509.1.asp

https://lapo.it/asn1js/
$ openssl x509 -in stackexchange.crt -noout -issuer
issuer= /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert SHA2 High Assurance Server CA
openssl x509 -in stackoverflow.1.crt -subject -noout
subject= /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert SHA2 High Assurance Server CA

The issuer is DigiCert SHA2 High Assurance Server CA and we have issuer’s certificate DigiCert_SHA2_High_Assurance_Server_CA.crt which has issuer’s public key

Obtain Issuer’s public key
# switch this to Let's Encrypt
pushd ~/src/linux-utils/crypto/certificates/stackoverflow
$ openssl x509 -in "subject=C_=_US_O_=_Let's_Encrypt_CN_=_R3.pem" -noout \
  -pubkey > issuer-pub.pem
