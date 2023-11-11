https://kulkarniamit.github.io/whatwhyhow/howto/verify-ssl-tls-certificate-signature.html#fn:1

The output tells us that the certificate was hashed usingSHA256 . However, the output you see is in hex and is separated by :. Let’s remove the first line, colon separator and spaces to get just the hex part

$ SIGNATURE_HEX=$(openssl x509 -in stackexchange.crt -text -noout -certopt ca_default -certopt no_validity -certopt no_serial -certopt no_subject -certopt no_extensions -certopt no_signame | grep -v 'Signature Algorithm' | tr -d '[:space:]:')
   
$ echo $SIGNATURE_HEX 
0093cef7ffed90b3029f252427fa265e65cf2e88683df6999dd34f04d9c98612ba8dccf7252bd20d6cf8f0c65f732204dc5e917f52d055552d59ed7a3cdea7ec18c3dd33362ddc5fa14294182e194617ee497f6c7a65bd738d3fda33718c7468bee8e3d5f981e5ff08147b8e4dea446e0d99d52f5ebbf96de5da70fe99284effbc6ac07899bb3d061f2047469e62e376e51f4be0ebbb09f20b8df35a5aa6ea58dafefc15cbd1f23d042df8327a1b56a63177bf3292abfad8dac3174d8cd23ea31e92cb1e1cd85231853a5b0f61f69c8c6959f0f6f6a1a9fee72871dc0b65514d482441f9fdc839a604ea349d0f1781fa5deb9fcf6b155f067b8a7c491705fa4c
Convert the signature to binary

$ echo ${SIGNATURE_HEX} | xxd -r -p > stackexchange-signature.bin
Where,

xxd: makes a hexdump or does the reverse

-r: convert hexdump into binary.

-p: plain hexdump style

We need to use the combination -r -p to read plain hexadecimal dumps without line number information and without a particular column layout.

OR

If you prefer a straightforward command-line to obtain your signature in binary:

Find out the offset where RSA signature lives in the certificate:

$ openssl asn1parse -in stackexchange.crt