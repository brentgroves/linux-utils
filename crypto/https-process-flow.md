https://certificatedecoder.dev/

- user browses to web site.
- the x.509 certificate is fetched from the web server or ingress controller.
- the browser verifies the sha256WithRSAEncryption signature is valid.
Mobex x.509 certificate summary:
Here are some details about our Mobex certificate.
chain-of-trust:
COMODO RSA certificate authority
cPanel Inc., certificate authority
mobexglobal.com, TLS/SSL certificate
Issued To: CN=mobexglobal.com
Issued By: C=US, ST=TX, L=Houston, O=cPanel, Inc., CN=cPanel, Inc. Certification Authority
Serial Number: 18 ff f8 09 07 9e 23 dc 93 0a 3b 72 28 3a 39 dc
Issued On: Mon Jan 30 2023 19:00:00 GMT-0500 (Eastern Standard Time)
Expires On: Mon May 01 2023 19:59:59 GMT-0400 (Eastern Daylight Time)

This is the public that is used to encrypt browser data that only we can decode.

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
