https://kulkarniamit.github.io/whatwhyhow/howto/verify-ssl-tls-certificate-signature.html#fn:1
bash oneliner:
openssl s_client -showcerts -verify 5 -connect stackoverflow.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

or 
openssl s_client -connect stackoverflow.com:443 -showcerts 2>/dev/null \
</dev/null | sed -n '/-----BEGIN/,/-----END/p' > /tmp/stackoverflow-certs.crt

*.crt is just an extension to identify it as certificate but the file is of PEM type

Just copy the contents between -----BEGIN CERTIFICATE----- and -----END CERTIFICATE-----(including these delimiters) into their own files. In this case, I have 2 sections with those delimiters and hence I will create 2 files