https://cryptobook.nakov.com/

https://developer.electricimp.com/api/crypto/verify
https://developer.electricimp.com/api
This method is used to verify the specified message. To verify the message, it is first hashed using the type specified by the value passed into the mode parameter. Currently, only one mode is supported: the SHA256 RSA signature scheme, which is specified with the mode constant crypto.RSASSA_PKCS1_SHA256.

The signature passed into the method is used with the public partner of the private key originally used to sign the message data. This yields a second hash (also known as a ‘digest’); if the two digests match, the message data is valid.

The method returns immediately; the verification process takes place asynchronously. The result is returned via the mandatory callback function’s isVerified parameter, which will be true if the signatures match, otherwise false.

