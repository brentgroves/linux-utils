
# OpenSSL vs NSS

**[OpenSSL vs NSS]<https://www.quora.com/How-does-one-decide-between-OpenSSL-GnuTLS-and-Mozillas-NSS>)**
"The fact is that OpenSSL almost certainly remains the most credible SSL/TLS library out there, followed closely by NSS and more distantly by GnuTLS."
I chose OpenSSL to implement our PKI because there is a lot of documentation for it and it seems to be the most popular for your typical business PKI at the moment.
Chromium, Firefox, Thunderbird, and Libre Office use NSS because it is more suited for development of an application that needs to use security object such as private keys and certificates and the fact that it comes with it's own security database assures its popularity.

# Instructions for adding our certificate chain to Windows computers

Our Mach2 servers use SSL certificates that we have generated from our PKI.  We must add the certificate chain to each computer that access the Mach2 servers so the user does not have to bypass a security warning screen.  There are several ways to do this.  

## add to local Windows trust store

certmgr
add ca.cert.pem to trusted root certificate authorities
add intermediate.cert.pem to intermediate certificate authorities

## add to Windows trust store using GPO

**[Not quite what we want but close](https://support.securly.com/hc/en-us/articles/206688537-How-to-push-the-Securly-SSL-certificate-with-Active-Directory-GPO
)**

In our PKI we have an intermediate as well as a root CA so we must add a second step to import our intermediate certificate into the trusted intermediate certificate store like we did using certmgr in the previous section.

## add to chrome trust store

```bash
get ca-chain-bundle.cert.pem 
run chrome
type chrome://settings/certificates
go to Authorities tab
import certs
select PEM certificate chain from the dropdown.
select ca-chain-bundle.cert.pem
select trust websites
notice new authority entry and select it
verify both the root and intermediate certificates are installed.
```

## verify root and intermediate certificate in Chrome trust store

certutil -d sql:$HOME/.pki/nssdb -L
Certificate Nickname                                         Trust Attributes
SSL,S/MIME,JAR/XPI

Root CA - Mobex Global                                       CT,c,c
Intermediate CA - Mobex Global                               ,,  

## Add to Firefox or Chrome trust store from command line

###

### For cert9 (SQL)

###

# bash

for certDB in $(find ~/ -name "cert9.db")
do
    certdir=$(dirname ${certDB});
    certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i ${certfile} -d sql:${certdir}
done

## What is NSS

**[Network Security Services](https://wiki.archlinux.org/title/Network_Security_Services)**
Network Security Services (NSS) is a set of libraries designed to support cross-platform development of security-enabled client and server applications.
Applications built with NSS can support SSL v2 and v3, TLS, PKCS #5, PKCS #7, PKCS #11, PKCS #12, S/MIME, X.509 v3 certificates, and other security standards.

NSS is required by many packages, including, for example, Chromium and Firefox.

cert9.db are also called "NSS databases". Paths to NSS databases for some applications are listed in the table below.

Application Path to NSS databases
chromium, evolution ~/.pki/nssdb/
firefox ~/.mozilla/firefox/<profile>/
thunderbird ~/.thunderbird/<profile>/
libreoffice-fresh configurable via Options [1]

**[Manage](https://man.archlinux.org/man/certutil.1)**
"Manage keys and certificate in both NSS databases and other NSS tokens"
