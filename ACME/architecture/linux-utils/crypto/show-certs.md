https://unix.stackexchange.com/questions/368123/how-to-extract-the-root-ca-and-subordinate-ca-from-a-certificate-chain-in-linux/487546#487546

https://kulkarniamit.github.io/whatwhyhow/howto/verify-ssl-tls-certificate-signature.html#fn:1

$ openssl s_client -showcerts -verify 5 -connect stackoverflow.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

openssl s_client -showcerts -verify 5 -connect mobexglobal.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print >out}' && for cert in *.crt; do newname=$(openssl x509 -noout -subject -in $cert | sed -n 's/^.*CN=\(.*\)$/\1/; s/[ ,.*]/_/g; s/__/_/g; s/^_//g;p').pem; mv $cert $newname; done

Download all the certificates offered by server to a file /tmp/stackoverflow-certs.crt

$ openssl s_client -connect stackoverflow.com:443 -showcerts 2>/dev/null \
</dev/null | sed -n '/-----BEGIN/,/-----END/p' > /tmp/stackoverflow-certs.crt


The default behavior of the following command is to print all fields

$ openssl x509 -in 'subject=CN_=__stackexchange_com.pem' -noout -text

However, there are command line options to specify which fields should be excluded while printing

$ openssl x509 -in 'subject=CN_=__stackexchange_com.pem' -text -noout -certopt ca_default \
  -certopt no_validity -certopt no_serial -certopt no_subject \
  -certopt no_extensions -certopt no_signame


The output tells us that the certificate was hashed usingSHA256 . However, the output you see is in hex and is separated by :. Let’s remove the first line, colon separator and spaces to get just the hex part

$ SIGNATURE_HEX=$(openssl x509 -in stackexchange.crt -text -noout -certopt ca_default -certopt no_validity -certopt no_serial -certopt no_subject -certopt no_extensions -certopt no_signame | grep -v 'Signature Algorithm' | tr -d '[:space:]:')
   
$ echo $SIGNATURE_HEX 
