# common errors

# valid 
https://github.com/cert-manager/cert-manager/issues/481

# req.cnf
https://stackoverflow.com/questions/43665243/invalid-self-signed-ssl-cert-subject-alternative-name-missing
openssl req -x509 -nodes -days 730 -newkey rsa:2048 \
 -keyout cert.key -out cert.pem -config req.cnf -sha256
# requirements
https://cabforum.org/baseline-requirements-certificate-contents/

 gen csr
https://certificatetools.com/
# verify csr
openssl req -in cert.csr -noout -text
https://www.sslshopper.com/csr-decoder.html
# sign csr
./create-RSA-private-key-and-csr.sh
# verify certificate
https://www.sslshopper.com/certificate-decoder.html
https://certlogik.com/decoder/
https://crt.sh/lintcert

openssl x509 -in frt_kors43_certificate.crt -text -noout
https://www.sslshopper.com/certificate-decoder.html

https://stackoverflow.com/questions/43665243/invalid-self-signed-ssl-cert-subject-alternative-name-missing
To fix this, you need to supply an extra parameter to openssl when you're creating the cert, basically

-sha256 -extfile v3.ext

where v3.ext is a file like so, with %%DOMAIN%% replaced with the same name you use as your Common Name. More info here and over here. Note that typically you'd set the Common Name and %%DOMAIN%% to the domain you're trying to generate a cert for. So if it was www.mysupersite.com, then you'd use that for both.

v3.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = %%DOMAIN%%
Note: Scripts that address this issue, and create fully trusted ssl certs for use in Chrome, Safari and from Java clients can be found here
Another note: If all you're trying to do is stop chrome from throwing errors when viewing a self signed certificate, you can can tell Chrome to ignore all SSL errors for ALL sites by starting it with a special command line option, as detailed here on SuperUser