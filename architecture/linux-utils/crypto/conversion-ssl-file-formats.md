https://www.rapidsslonline.com/ssl-tools/ssl-converter.php
You can also perform the file conversion using the ‘OpenSSL’ tool.
Problem
Convert standard format certificate (x.509 .der or .cer) into PEM format


Solution
OpenSSL can be used to convert a standard format certificate (X.509) into a PEM format certificate.
 
The command line to use is:
 
openssl x509 -in certFileName.cer -outform PEM -out convertedCertFileName.pem

The ‘.pem’ file is just a text file containing the signing authority certificate, your certificate and the key. To combine the various certs, and the key, you would open the different files using Workbench in a text editor, not a pem editor, so you can copy out the whole certificate for pasting to the master pem file. If you just want to read the certificate, to verify contents, then open using the pem editor. To copy the certificate, so you can then paste it into some master pem you are building up, open the certs in the text editor. In a text editor you will see the 'BEGIN' and 'END' with all the garbage in between. That is what goes into the master '.pem'. 