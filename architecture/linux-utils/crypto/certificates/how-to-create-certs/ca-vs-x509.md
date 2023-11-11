https://www.golinuxcloud.com/openssl-ca-vs-openssl-x509-comparison/
openssl ca vs openssl x509 comparison
openssl is a single command which supports different set of operations when used with ca or x509 argument.
Both the commands are used in a way to sign certificate requests
openssl x509 is considered as a multi-purpose certificate utility because it can do much more than signing certificate requests, such as view certificate content, convert certificate formats etc. openssl ca doesn't provide these features.
openssl ca and openssl x509, both can be used to sign certificate requests. But openssl ca command is used when you want to maintain a database of the list of certificates which are signed and revoked. openssl x509 maintains no such database.
You can sign the same certificate (i.e. with same Common Name) n number of times with openssl x509 command but openssl ca command will not allow you to sign the same certificate more than 1 time as it maintains a database of the signed certificate. In such scenarios you must first revoke the existing certificate and then you may continue to get is signed again using openssl ca command