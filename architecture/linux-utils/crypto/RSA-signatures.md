RSA Verify Signature
Verifying a signature s for the message msg with the public key exponent e:
Calculate the message hash: h = hash(msg)
Decrypt the signature: 
Compare h with h' to find whether the signature is valid or not

https://cryptobook.nakov.com/digital-signatures/rsa-signatures

https://cryptobook.nakov.com/digital-signatures/rsa-sign-verify-examples