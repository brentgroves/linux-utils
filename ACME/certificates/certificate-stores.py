SSL Certificate Loading¶
If using the ssl Python module (e.g. as part of making connections to https:// URLs), Python in its default configuration will want to obtain a list of trusted X.509 / SSL certificates for verifying connections.

If a list of trusted certificates cannot be found, you may encounter errors like ssl.SSLCertVerificationError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate.

maybe it's in this huge file
/etc/ssl/certs/ca-certificates.crt

https://valid-isrgrootx1.letsencrypt.org/
I get the lock in chrome so it must be somewhere.

https://superuser.com/questions/1717914/make-chrome-trust-the-linux-system-certificate-store-or-select-certificates-via
https://superuser.com/questions/1717914/make-chrome-trust-the-linux-system-certificate-store-or-select-certificates-via
#!/bin/bash

### Script installs root.cert.pem to certificate trust store of applications using NSS
### (e.g. Firefox, Thunderbird, Chromium)
### Mozilla uses cert8, Chromium and Chrome use cert9

###
### Requirement: apt install libnss3-tools
###

###
### CA file to install (CUSTOMIZE!)
###

certfile="root.cert.pem"
certname="My Root CA"

###
### For cert8 (legacy - DBM)
###

for certDB in $(find ~/ -name "cert8.db")
do
    certdir=$(dirname ${certDB});
    certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i ${certfile} -d dbm:${certdir}
done

###
### For cert9 (SQL)
###

for certDB in $(find ~/ -name "cert9.db")
do
    certdir=$(dirname ${certDB});
    certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i ${certfile} -d sql:${certdir}
done