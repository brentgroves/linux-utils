https://medium.com/asecuritysite-when-bob-met-alice/whats-so-special-about-pkcs-1-v1-5-and-the-attack-that-just-won-t-go-away-51ccf35d65b7
https://brilliant.org/wiki/rsa-encryption/
https://brilliant.org/wiki/rsa-encryption/

What’s So Special About PKCS#1 v1.5? And The Attack That Just Won’t Go Away!
RSA has been with us for many decades, and it’s still going strong. But it has weaknesses. The first is where we have a short message and the second is where we have a small value of e. To recap, in traditional RSA, we take the message of m, and an encryption key value e, along with a modulus of N, to give a cipher message of:

c = m^e (mod N)

To decrypt we use a value of d, to recover the message:

m = c^d (mod N)

The value of N is the product to two large prime numbers (p and q).