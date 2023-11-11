https://www.keyfactor.com/resources/what-is-pki/

Today, there are three popular mathematical properties used to generate private and public keys: RSA, ECC, and Diffie-Hellman. Each uses different algorithms to generate encryption keys but they all rely on the same basic principles as far as the relationship between the public key and private key.  

Let’s look at the RSA 2048 bit algorithm as an example. This algorithm randomly generates two prime numbers that are each 1024 bits long and then multiplies them together. The answer to that equation is the public key, while the two prime numbers that created the answer are the private key.  

This approach works because it’s extremely difficult to reverse the computation when it involves two prime numbers of that size, making it relatively easy to compute the public key from the private key but nearly impossible to compute the private key from the public key. 

How Symmetric and Asymmetric Encryption Get Used Today
Both symmetric and asymmetric encryption get used often today. Asymmetric encryption is much slower than symmetric encryption, so the two are often used in tandem. For example, someone may encrypt a message using symmetric encryption and then send the key to decrypt the message using asymmetric encryption (which speeds up the decryption process since the key is much smaller than the entire message). 

Today, asymmetric encryption powers things like: 

SSH algorithms 
SSL/TLS 
S/MIME encrypted email 
Code signing 
Bitcoin/Blockchain 
Signal private messenger 
Digital signatures
 

Most notably, asymmetric encryption powers PKI. 

The Emergence of PKI to Govern Encryption Keys
Both symmetric and asymmetric encryption have one major challenge: How do you know that the public key you received actually belongs to the person you think it does?  

Even with asymmetric encryption, the risk of the “man in the middle” exists. For example, what if someone intercepted Bob’s public key, made his own private key, and then generated a new public key for Alice? In this case, Alice would encrypt messages for Bob, the man in the middle could decrypt them, change them and then re-encrypt them and neither Alice nor Bob would be any wiser. 

PKI resolves this challenge by issuing and governing digital certificates that confirm the identity of people, devices or applications that own private keys and the corresponding public keys. In short, PKI assigns identities to keys so that recipients can accurately verify the owners. This verification gives users confidence that if they send an encrypted message to that person (or device), the intended recipient is the one who will actually read it and not anyone else who may be sitting as a “man in the middle.” 
