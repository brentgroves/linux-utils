https://certificatetools.com/
https://lightbend.github.io/ssl-config/CertificateGeneration.html
# https://www.openssl.org/docs/manmaster/man5/x509v3_config.html
cat > "x509.config" << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=critical,CA:true
keyUsage=critical,digitalSignature,nonRepudiation,cRLSign,keyCertSign
subjectAltName=@alt_names
issuerAltName=issuer:copy
subjectKeyIdentifier=hash
[alt_names]
DNS