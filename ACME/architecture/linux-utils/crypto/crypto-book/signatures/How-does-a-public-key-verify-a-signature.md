How does a public key verify a signature?
https://stackoverflow.com/questions/18257185/how-does-a-public-key-verify-a-signature

I am trying to get a better grapple on how public/private keys work. I understand that a sender may add a digital signature to a document using his/her private key to essentially obtain a hash of the document, but what I do not understand is how the public key can be used to verify that signature.

My understanding was that public keys encrypt, private keys decrypt... can anyone help me understand?

Public keys aren't used to encrypt, they're used to sign. The terminology is important because if something is "encrypted", it means it's almost impossible for any person (who doesn't have the private key) to get back the original message. This obviously isn't the case if you sign something with a private key because anyone can get the public key and decrypt the ciphertext to get back the original message. – 
David Klempfner
 Feb 26, 


Your understanding of "public keys encrypt, private keys decrypt" is correct... for data/message ENCRYPTION. For digital signatures, it is the reverse. With a digital signature, you are trying to prove that the document signed by you came from you. To do that, you need to use something that only YOU have: your private key.

A digital signature in its simplest description is a hash (SHA1, MD5, etc.) of the data (file, message, etc.) that is subsequently encrypted with the signer's private key. Since that is something only the signer has (or should have) that is where the trust comes from. EVERYONE has (or should have) access to the signer's public key.

So, to validate a digital signature, the recipient

Calculates a hash of the same data (file, message, etc.),
Decrypts the digital signature using the sender's PUBLIC key, and
Compares the 2 hash values.
If they match, the signature is considered valid. If they don't match, it either means that a different key was used to sign it, or that the data has been altered (either intentionally or unintentionally).

https://stackoverflow.com/questions/61175300/how-to-decrypt-with-public-key-in-pycryptodome-python-3-7

What you're describing is a signature. Look at the sign/verify API of pycryptodome. The words "encryption" and "decryption" are confusing when applied to RSA. So it's better to reserve the word encryption exclusively for the case when the sender transforms plaintext using the receiver's public key. Only the receiver can recover the plaintext. When we transform the plaintext using our private key, so that anybody can recover the plaintext with our public key, that is called signing. – 
President James K. Polk
 Apr 13, 2020 at 15:40
