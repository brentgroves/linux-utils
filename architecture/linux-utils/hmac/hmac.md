https://www.okta.com/identity-101/hmac/
https://manpages.ubuntu.com/manpages/jammy/man1/hmac256.1.html

hmac256 "This is my key" foo.txt

HMAC with SHA256 can only be used to hash a value, which is a one-way trip only. If you want to be able to encrypt/decrypt you will have to use a cipher, such as aes or des.

Example on how encryption/decryption:

const crypto = require("crypto");

// key and iv   
var key = crypto.createHash("sha256").update("OMGCAT!", "ascii").digest();
var iv = "1234567890123456";

// this is the string we want to encrypt/decrypt
var secret = "ermagherd";

console.log("Initial: %s", secret);

// create a aes256 cipher based on our password
var cipher = crypto.createCipheriv("aes-256-cbc", key, iv);
// update the cipher with our secret string
cipher.update(secret, "ascii");
// save the encryption as base64-encoded
var encrypted = cipher.final("base64");

console.log("Encrypted: %s", encrypted);

// create a aes267 decipher based on our password
var decipher = crypto.createDecipheriv("aes-256-cbc", key, iv);
// update the decipher with our encrypted string
decipher.update(encrypted, "base64");

console.log("Decrypted: %s", decipher.final("ascii"));


Encrypt a File using GPG
To encrypt a file using GPG, please use the command as shown below –

$ gpg -c cron.log


Decrypt a File using GPG
To decrypt the above file, use the following command –

$ gpg -o cron.log.2 -d cron.log.gpg
gpg: AES encrypted data
Enter passphrase: