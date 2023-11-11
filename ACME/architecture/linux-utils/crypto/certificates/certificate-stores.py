SSL Certificate Loading¶
If using the ssl Python module (e.g. as part of making connections to https:// URLs), Python in its default configuration will want to obtain a list of trusted X.509 / SSL certificates for verifying connections.

If a list of trusted certificates cannot be found, you may encounter errors like ssl.SSLCertVerificationError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate.

maybe it's in this huge file
/etc/ssl/certs/ca-certificates.crt

https://valid-isrgrootx1.letsencrypt.org/
I get the lock in chrome so it must be somewhere.