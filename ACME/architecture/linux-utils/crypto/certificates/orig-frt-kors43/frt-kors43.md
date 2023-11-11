There’s a bash one-liner magic that can extract certificates in their own files:
pushd ~/src/linux-utils/crypto/certificates/frt-kors43
$ openssl s_client -showcerts -verify 5 -connect stackoverflow.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

$ openssl s_client -showcerts -verify 5 -connect frt-kor43:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

172.20.0.41 frt-kor43.busche-cnc.com

# another way
https://superuser.com/questions/97201/how-to-save-a-remote-server-ssl-certificate-locally-as-a-file
openssl s_client -connect frt-kor43.busche-cnc.com:443 -showcerts
CONNECTED(00000003)
depth=0 CN = Niagara4, O = Tridium, C = US
verify error:num=18:self signed certificate
verify return:1
depth=0 CN = Niagara4, O = Tridium, C = US
verify error:num=10:certificate has expired
notAfter=Aug 11 15:38:48 2022 GMT
verify return:1
depth=0 CN = Niagara4, O = Tridium, C = US
notAfter=Aug 11 15:38:48 2022 GMT
verify return:1
---
Certificate chain
 0 s:CN = Niagara4, O = Tridium, C = US
   i:CN = Niagara4, O = Tridium, C = US
-----BEGIN CERTIFICATE-----
MIIDgTCCAmmgAwIBAgIMSDIFiLD5Vo6+kLpRMA0GCSqGSIb3DQEBCwUAMDIxETAP
BgNVBAMMCE5pYWdhcmE0MRAwDgYDVQQKDAdUcmlkaXVtMQswCQYDVQQGEwJVUzAe
Fw0yMTA4MTExNTM4NDhaFw0yMjA4MTExNTM4NDhaMDIxETAPBgNVBAMMCE5pYWdh
cmE0MRAwDgYDVQQKDAdUcmlkaXVtMQswCQYDVQQGEwJVUzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAIBsrji2BddT0jyozLqQtZ1peeBrR/PdNW5pKlKc
xn/YsqgWXyDHBxm6blB2xa/e7n/jE4Y9uSmxon+RrYz0k74Pg/6xqkC1P/YVYRML
MTWXwkRnyX1KmsJZKLzgBX0OKV5GcugIgIg0jQk719KZAfb0/8zwDnNf/00nmo2b
DNMvIBeNxWu7z6qblD9y/VDJlAk7ouc6O+snI9D9z1QpfeQxbsnhmAbohpn0VJz8
Q9o1uej56Qys626cWSwpaliiV8SujeN+9kAOY21iZu8fNL+fHVqToadp8aN028JV
6NrYgsjvqmPqn5J0jnNjXkCBR8hfsK6Y4c+rsm2njn+5fC0CAwEAAaOBljCBkzAd
BgNVHQ4EFgQUPXtnjt4saQT0XR/54o+cqjQ+Uu4wHQYDVR0lBBYwFAYIKwYBBQUH
AwEGCCsGAQUFBwMCMA4GA1UdDwEB/wQEAwIFoDATBgNVHREEDDAKgghOaWFnYXJh
NDAuBgNVHRIEJzAloCMGCCsGAQQBoCMCDBdXaW4tNzdFQS05QkIxLUY5MUYtMDM1
NTANBgkqhkiG9w0BAQsFAAOCAQEAOLgFB7KMr0YgBIr4d+Z9ng0kIJzTVrXgQQ0b
SHSC5Fv963ccl1CWNw86mKlRqVPPromO11/Jno+buDt8/IRHiWN965mEK7gXytZ+
RVu/KCHYetUqlG4NC5n+h/8acXPAJT3wkftgZdx41sIlV6H3iCaslbzpCx6IYZGn
0afzKRZHbGwZaFJ3RjVGFNlM4t6VkcC607DF2nho50A/NsPSytWgdqF94XNf+yLm
JncFAxMeibI9Lo+5YG2eIAsHBi98dd7myaBGmIFb3rVuzvukArcYGO8ZhBbjJbVg
G8BQAWnHwaA10zvSU5ttP6J8xDJ+4NNF5FZHoVpUJaZNygnKTg==
-----END CERTIFICATE-----
---
Server certificate
subject=CN = Niagara4, O = Tridium, C = US

issuer=CN = Niagara4, O = Tridium, C = US

---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: RSA-PSS
Server Temp Key: ECDH, P-256, 256 bits
---
SSL handshake has read 1389 bytes and written 452 bytes
Verification error: certificate has expired
---
New, TLSv1.2, Cipher is ECDHE-RSA-AES256-GCM-SHA384
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-RSA-AES256-GCM-SHA384
    Session-ID: D117DDA1B4A124AD1BB604DF0262F03EA05ADA705CFAB3C92BC78184019A631F
    Session-ID-ctx: 
    Master-Key: A4C2D29F344C80CA10212452204F22C09FA000A68609BE54C11183FF2499A6BE292C8CC8BE6E459D89B3E2BCEE8D9303
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    Start Time: 1689889825
    Timeout   : 7200 (sec)
    Verify return code: 10 (certificate has expired)
    Extended master secret: yes
---

openssl s_client -showcerts -connect frt-kor43.busche-cnc.com:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >niagara4.pem

To use the certificate, with wget,

wget https://frt-kor43.busche-cnc.com:443/ --ca-certificate=niagara4.pem
--2023-07-20 17:56:24--  https://frt-kor43.busche-cnc.com/
Resolving frt-kor43.busche-cnc.com (frt-kor43.busche-cnc.com)... 172.20.0.41
Connecting to frt-kor43.busche-cnc.com (frt-kor43.busche-cnc.com)|172.20.0.41|:443... connected.
ERROR: cannot verify frt-kor43.busche-cnc.com's certificate, issued by ‘C=US,O=Tridium,CN=Niagara4’:
  Issued certificate has expired.
ERROR: no certificate subject alternative name matches
        requested host name ‘frt-kor43.busche-cnc.com’.
To connect to frt-kor43.busche-cnc.com insecurely, use `--no-check-certificate'.
wget https://frt-kor43.busche-cnc.com:443/ --ca-certificate=niagara4.pem --no-check-certificate

wget https://frt-kor43:443/ --ca-certificate=niagara4.pem
--2023-07-20 17:58:14--  https://frt-kor43/
Resolving frt-kor43 (frt-kor43)... 172.20.0.41
Connecting to frt-kor43 (frt-kor43)|172.20.0.41|:443... connected.
ERROR: cannot verify frt-kor43's certificate, issued by ‘C=US,O=Tridium,CN=Niagara4’:
  Issued certificate has expired.
ERROR: no certificate subject alternative name matches
        requested host name ‘frt-kor43’.
To connect to frt-kor43 insecurely, use `--no-check-certificate'.

https://support.avigilon.com/s/article/How-to-Disable-SSL-Certificate-Warnings-in-Chrome-Internet-Explorer-and-Mozilla-Firefox?language=en_US
https://windowsreport.com/chrome-ignore-certificate-errors/
Google Chrome is the most used browser we have today. This is a testament to how robust and user-friendly it is. That said, you may need to ignore certificate errors on Chrome especially since this is an issue you may experience from time to time.

SSL certificates are standard security solutions used to encrypt data between a visitor’s web browser and a website. Visitors will feel much safer on SSL-encrypted sites because they keep sensitive data like payment information and data safe.

The HTTPS in the URL and the padlock icon shown within an address bar are indicators that the site is encrypted.
How do I turn off certificate checks?
1. Chrome ignore certificate errors localhost
Launch the Chrome browser.
On the address locator input the link below.
chrome://flags/

Type secure in the search box and click enter.

Scroll down to the Insecure origins treated as secure flag.
Click on the dropdown list and select Enabled.



https://kinsta.com/knowledgebase/neterr-cert-authority-invalid/
What Is NET::ERR_CERT_AUTHORITY_INVALID Error?
As the name of the error implies, this problem pops up when your browser can’t verify the validity of your website’s SSL certificate. If you haven’t set up a certificate or are using HTTP for your website, which isn’t recommended, you shouldn’t run into this error.

Generally speaking, there are three primary causes for the invalid certificate authority error. Let’s break down each one in turn:

You’re using a self-signed SSL certificate. Using a self-signed certificate can save you money, but since browsers can’t verify its validity, your visitors may run into the error in question. Browser warnings can scare a lot of users away, so we recommend against this approach.
Your certificate has expired. SSL certificates expire as a security precaution. How long your certificate lasts can vary, but at some point, you’ll need to renew it or automate the renewal process (some authorities and web hosts enable you to do this easily).
The certificate comes from a non-trusted source. Just as with self-signed certificates, if browsers can’t verify the authority that generated your certificate, you’ll see an error.
