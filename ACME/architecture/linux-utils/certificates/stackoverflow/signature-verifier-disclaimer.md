https://cryptography.io/en/latest/x509/reference/#loading-certificates

tbs_certificate_bytes
New in version 1.2.

type
:
bytes

The DER encoded bytes payload (as defined by RFC 5280) that is hashed and then signed by the private key of the certificate’s issuer. This data may be used to validate a signature, but use extreme caution as certificate validation is a complex problem that involves much more than just signature checks.

To validate the signature on a certificate you can do the following. Note: This only verifies that the certificate was signed with the private key associated with the public key provided and does not perform any of the other checks needed for secure certificate validation. Additionally, this example will only work for RSA public keys with PKCS1v15 signatures, and so it can’t be used for general purpose signature verification.