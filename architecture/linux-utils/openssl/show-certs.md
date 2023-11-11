https://unix.stackexchange.com/questions/368123/how-to-extract-the-root-ca-and-subordinate-ca-from-a-certificate-chain-in-linux/487546#487546

https://kulkarniamit.github.io/whatwhyhow/howto/verify-ssl-tls-certificate-signature.html#fn:1

$ openssl s_client -showcerts -verify 5 -connect stackoverflow.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done


Download all the certificates offered by server to a file /tmp/stackoverflow-certs.crt

$ openssl s_client -connect stackoverflow.com:443 -showcerts 2>/dev/null \
</dev/null | sed -n '/-----BEGIN/,/-----END/p' > /tmp/stackoverflow-certs.crt