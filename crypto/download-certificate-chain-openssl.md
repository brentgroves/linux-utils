https://help.mulesoft.com/s/article/How-to-Download-Whole-Certificate-Chain-From-A-Remote-Host-and-Import-to-a-Trust-Store

openssl s_client -showcerts -verify 5 -connect www.google.com:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".pem"; print >out}'

To import the above files into a trust store (whether the JDK cacert trust store or your own custom), run the following command to add that certificate to your trust store.
In the example below, replace "$JAVA_HOME/jre/lib/security/cacerts" with the path to your trust store file, as well as any name for the alias "<your alias here>":
keytool -importcert -file cert1.pem -keystore $JAVA_HOME/jre/lib/security/cacerts -alias "alias-test1" -deststoretype JKS

keytool -importcert -file cert2.pem -keystore $JAVA_HOME/jre/lib/security/cacerts -alias "alias-test2" -deststoretype JKS

You can confirm the same using openssl asn1parse tool as well (Shown later in this article)

Verifying server’s public key
Download the server’s certificates to /tmp in PEM format.

openssl s_client -connect frt-kors43.busche-cnc.com:443 -showcerts 2>/dev/null </dev/null

$ openssl s_client -connect stackoverflow.com:443 -showcerts 2>/dev/null </dev/null \
  | sed -n '/-----BEGIN/,/-----END/p' > /tmp/stackoverflow-certs.crt
Command options:

s_client : Implements a generic SSL/TLS client which connects to a remote host using SSL/TLS

-connect: Specifies the host and optional port to connect to

-showcerts: Displays the server certificate list as sent by the server

2>/dev/null: redirects stderr to /dev/null

< /dev/null: instantly send EOF to the program, so that it doesn’t wait for input

/dev/nullis a special file that discards all data written to it, but reports that the write operation succeeded

sed: stream editor for filtering and transforming text

-n: suppress automatic printing of pattern space

PEM (Privacy Enhanced Mail) is nothing more than a base64-encoded DER (Distinguished Encoding Rules)

