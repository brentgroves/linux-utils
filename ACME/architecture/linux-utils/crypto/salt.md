https://www.golinuxcloud.com/generate-self-signed-certificate-openssl/#Create_encrypted_password_file_Optional

I have created a plain text file "mypass" with my "secret" passphrase

cd ~
echo JesusLives1! > mypass

Using openssl enc I will encrypt mypass file and create an encrypted file mypass.enc

openssl enc -aes256 -pbkdf2 -salt -in mypass -out mypass.enc
enter aes-256-cbc encryption password:
Verifying - enter aes-256-cbc encryption password:

What is AES 256?
https://www.ipswitch.com/blog/use-aes-256-encryption-secure-data
Advanced Encryption Standard (AES) 256 is a virtually impenetrable symmetric encryption algorithm that uses a 256-bit key to convert your plain text or data into a cipher.

What is salt?
When encrypting a file with OpenSSL, it is possible to use -pass pass:mySillyPassword, where mySillyPassword is the password used in encryption. In addition, it is possible to use a salt, where -salt -s (hex string) is used to specify the salt.

Why would someone want to use a password instead of the salt or in conjunction with a salt? Also, I understand just using the -salt command will cause OpenSSL to generate a salt. How is this better than a user-defined salt? If OpenSSL randomly generates a salt, how will the user know what the salt is to decrypt the file in the future?

In OpenSSL, the salt will be prepended to the front of the encrypted data, which will allow it to be decrypted. The purpose of the salt is to prevent dictionary attacks, rainbow tables, etc. The following is from the OpenSSL documentation:
Without the -salt option it is possible to perform efficient dictionary attacks on the password and to attack stream cipher encrypted data. The reason for this is that without the salt the same password always generates the same encryption key. When the salt is being used the first eight bytes of the encrypted data are reserved for the salt: it is generated at random when encrypting a file and read from the encrypted file when it is decrypted.

The password is used to generate a secret key for decrypting the file, and it can only be decrypted with that password. The password is secure, but only if used properly. 

The purpose of encrypting a file is to hide its contents. Thus, you must provide either a password or an encryption key. (If you provide a password, the password is used to generate an encryption key, which is then used to encrypt or decrypt your information). 

The actual key which is used for encryption is driven from the password and the SALT, if provided. Hence, even if the same password used to encrypt two files, if SALT is used, then the key will be different and the ciphertext of course.

The password is never appended or encoded into the ciphertext. In contrast, the salt is added to the beginning of the ciphertext. But it can't be used to decrypt the ciphertext without the password.

Why SALT is important? Imagine you are using the same password without SALT to encrypt ten files. An adversary can generate keys dictionary for potential passwords then once one key successfully decrypt one file, it can decrypt all files. With SALT he has to create ten different dictionaries one for each SALT, which make things more expensive for him and secure for us.

Let's do practical things, I will use openssl 1.1.1:

Password without SALT:

echo "secret data in my file" > plaintext.txt

openssl enc -aes-128-cbc -nosalt -k "mySecretPassword" -in plaintext.txt -out enc1.nosalt.bin
openssl enc -aes-128-cbc -nosalt -k "mySecretPassword" -in plaintext.txt -out enc2.nosalt.bin
Both ciphertexts should be the same because the encryption key only depends on the password which is the same in both cases.

xxd enc1.nosalt.bin
00000000: 576e a82c 0dac 92d8 5e45 5ef4 3f6f db6a  Wn.,....^E^.?o.j
00000010: 5630 554f 3f28 a0de ae96 91d9 1024 d5ca  V0UO?(.......$..

xxd enc2.nosalt.bin
00000000: 576e a82c 0dac 92d8 5e45 5ef4 3f6f db6a  Wn.,....^E^.?o.j
00000010: 5630 554f 3f28 a0de ae96 91d9 1024 d5ca  V0UO?(.......$..
Password and SALT:

openssl enc -aes-128-cbc -k "mySecretPassword" -in plaintext.txt -out enc2.salted.bin
 openssl enc -aes-128-cbc -k "mySecretPassword" -in plaintext.txt -out enc1.salted.bin
The ciphertext should be different due to the SALT, even though we use the same password. Note that the Salt is appended to the beginning of the ciphertext.

xxd enc2.salted.bin
00000000: 5361 6c74 6564 5f5f 9cfe 2d62 a2d4 70b8  Salted__..-b..p.
00000010: aee4 afb5 85c9 76a2 cb04 7e1d 27d9 94d4  ......v...~.'...
00000020: a1b3 c4d6 39b8 f5a8 c300 81b5 b6ed 4cca  ....9.........L.

xxd enc1.salted.bin
00000000: 5361 6c74 6564 5f5f e73c ee5b 701b bba8  Salted__.<.[p...
00000010: fa25 c54e befa 26dc ddb1 3a2d 2bd7 a95b  .%.N..&...:-+..[
00000020: bda9 56f0 4445 f229 3398 4076 1044 dad6  ..V.DE.)3.@v.D..


