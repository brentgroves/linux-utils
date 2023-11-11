https://www.highgo.ca/2019/08/08/the-difference-in-five-modes-in-the-aes-encryption-algorithm/
General
The block ciphers are schemes for encryption or decryption where a block of plaintext is treated as a single block and is used to obtain a block of ciphertext with the same size. Today, AES (Advanced Encryption Standard) is one of the most used algorithms for block encryption. It has been standardized by the NIST (National Institute of Standards and Technology) in 2001, in order to replace DES and 3DES which were used for encryption in that period. The size of an AES block is 128 bits, whereas the size of the encryption key can be 128, 192 or 256 bits. Please note this, there is three length in the key, but the size of the encryption block always is 128 bits. Block cipher algorithms should enable encryption of the plaintext with size which is different from the defined size of one block as well. We can use some algorithms for padding block when the plaintext is not enough a block, like PKCS5 or PKCS7, it also can defend against PA attack, if we use ECB or CBC mode. Or we can use the mode of AES which support a stream of plaintext, like CFB, OFB, CTR mode.

Now let’s introduce the five modes of AES.

ECB mode: Electronic Code Book mode
CBC mode: Cipher Block Chaining mode
CFB mode: Cipher FeedBack mode
OFB mode: Output FeedBack mode
CTR mode: Counter mode
The attack mode:

PA: Padding attack
CPA: Chosen Plaintext Attack
CCA: Chosen Ci

ECB Mode
The ECB (Electronic Code Book) mode is the simplest of all. Due to obvious weaknesses, it is generally not recommended. A block scheme of this mode is presented in Fig. 1.

We can see it in Fig. 1, the plaintext is divided into blocks as the length of the block of AES, 128. So the ECB mode needs to pad data until it is same as the length of the block. Then every block will be encrypted with the same key and same algorithm. So if we encrypt the same plaintext, we will get the same ciphertext. So there is a high risk in this mode. And the plaintext and ciphertext blocks are a one-to-one correspondence. Because the encryption/ decryption is independent, so we can encrypt/decrypt the data in parallel. And if a block of plaintext or ciphertext is broken, it won’t affect other blocks.

Mallory is an active attacker coming from mallices
Because of the feature of ECB, the Mallory can make an attack even if they don’t get the plaintext. For example, if we encrypt the data about our bank account, like this: The ciphertext: C1: 21 33 4e 5a 35 44 90 4b(the account) C2: 67 78 45 22 aa cb d1 e5(the password) Then the Mallory can copy the data in C1 to C2. Then he can log in the system with the account as the password which is easier to get.

In the database encryption, we can use ECB to encrypt the tables, indexes, wal, temp files, and system catalogs. But with the issues of security, we don’t suggest to use this mode.

The CBC (Cipher Block Chaining) mode (Fig. 2) provides this by using an initialization vector – IV. The IV has the same size as the block that is encrypted. In general, the IV usually is a random number, not a nonce.
number only used once

We can see it in figure 2, the plaintext is divided into blocks and needs to add padding data. First, we will use the plaintext block xor with the IV. Then CBC will encrypt the result to the ciphertext block. In the next block, we will use the encryption result to xor with plaintext block until the last block. In this mode, even if we encrypt the same plaintext block, we will get a different ciphertext block. We can decrypt the data in parallel, but it is not possible when encrypting data. If a plaintext or ciphertext block is broken, it will affect all following block.

A Mallory can change the IV to attack the system. Even if a bit is wrong in the IV, all data is broken. Mallory also can make a padding oracle attack. They can use a part of ciphertext to pad the ciphertext block. This will return some messages about the plaintext. It is safe from CPA, but it is easily sysceptible to CCA and PA.

To ensure security, we need to change the key when we encrypt 2^((n+1)/2)(n is the length of a block).



https://cybernews.com/resources/what-is-aes-encryption/
1. Dividing data into blocks
First, we have to keep in mind that AES is a block cipher. Unlike stream ciphers, it encrypts data in blocks of bits instead of bit-by-bit. 

Each of its blocks contains a column of 16 bytes in a layout of four-by-four. As one byte contains 8 bits, we get 128-bit block size (16x8=128).

Thus, the very first step of AES encryption is dividing the plaintext (text that is not written in code) into these blocks. 

So, let’s choose the text you want to encrypt. For example, it can be “better late than never”.

Applying the advanced encryption standard would turn the beginning of this phrase into the following block:

Note that this is only the first block of the text - the rest of the phrase would go into the next one.

2. Key expansion
This is an important step of AES encryption. It produces new 128-bit round keys with the help of Rijndael’s key schedule.

Let’s say that our initial key is “extraterrestrial”:

AES before key expansion
After applying Rijndael’s key schedule, the phrase will look like a jumble of random characters and might resemble something like this:

After applying Rijndael’s key schedule, the phrase will look like a jumble of random characters and might resemble something like this:

AES encryption after key expansion
However, these characters won’t be so random after all, as Rijndael’s key schedule uses specific processes to encrypt each and every symbol.
The AES algorithm will need this set of new expanded keys a bit later.

This is the very first round of AES encryption. Here, the algorithm adds the initial key to our phrase, which was previously turned into a 4x4 block:

I know that adding two blocks of text might seem impossible. However, remember that AES actually uses binary code, and what you now see is just a visual representation of what is actually happening in the binary language.

So, after adding the two blocks, we end up with a completely new block of cipher, which I will depict as this:

Byte substitution
Now, the AES algorithm substitutes every byte with a code according to a pre-established table called the Rijndael S-box. It looks like this:


According to the table, an element like 19 becomes d4, e9 becomes 1a, and so on. So, after the process of byte substitution, my block of cipher might take the appearance of something like this (keep in mind that it’s still a hypothetical representation of what the real deal looks like):

As you can see, I marked a couple of columns with different colors. This will come in handy in the next step.

5. Shifting rows
In this step, the AES algorithm shifts the rows of the block it got during the byte substitution process.

The first row stays put. However, the second row gets shifted to the left by one byte, the third row moves to the left by two bytes, while the last one gets shifted by three bytes:

6. Mixing columns
Talking in mathematical terms, this step multiplies each column by a predefined matrix, giving us a brand new block of code.

It is a really complicated process, involving a lot of advanced level mathematics.

For the sake of simplicity, let’s assume that I did the math and my new block now looks like this:

7. Adding round key
It’s time to apply the round key we got in the key expansion section. Let’s add it to the block we got in the previous section after the process of column mixing:

AES encryption add round key
This action produces yet another block of binary code, which later on undergoes lots of further modifications.

8. Rinse and repeat
Now, the AES encryption algorithm will go through many more rounds of byte substitution, shifting rows, mixing columns, and adding a round key.

The number of identical rounds the data goes through depends on the AES key length:

128-bit key: 9 rounds
192-bit key: 11 rounds
256-bit key: 13 rounds
So, in the case of 256-bit key encryption, for example, the data goes through the previously mentioned steps 13 times in a row.

However, that’s still not the end of it.

There is one extra round after the mentioned 9, 11, or 13 rounds of encryption. During this additional round, the algorithm only goes through the stages of byte substitution, row shifts, and adding a round key. It leaves out the step of mixing columns.

Why? Because, at this point, that would be redundant. In other words, this action would use too much processing power without significantly altering the data.

So, at the very end of the encryption process, the data will have gone through the following number of rounds:

128-bit key: 10 rounds
192-bit key: 12 rounds
256-bit key: 14 rounds
After all the rounds are completed, the original phrase “better late than never” will look like a set of random characters. 

AES decryption
With the help of inverse encryption, the AES ciphertext can be restored to its initial state.

As mentioned before, the advanced encryption standard implements the method of symmetric cryptography. In other words, it uses the same key for both data encryption and decryption.

In this way, it differs from the algorithms that use asymmetric encryption, when both public and private keys are required.

So, in our case, AES decryption begins with the inverse round key. Afterwards, the algorithm reverses every single action (shift rows, byte substitution, and, later on, column mixing), until it deciphers the original message.

Does AES encryption have any security issues?
Even though AES is an exceptionally secure type of encryption, it might not be 100% impenetrable a few years from now.

No known successful real-life attacks have been recorded so far, however, the rapid evolution of technology might pose potential threats in the future.

Also, mistakes happen. If someone implements AES encryption incorrectly, the potential errors might serve as a gateway for hackers.

Luckily, the correct usage of AES prevents successful attacks from happening.

To make sure that AES encryption is still impenetrable, cryptographers constantly work on ways to crack it, coming up with all kinds of theoretical attacks. Up until now, nobody managed to do it - only a few side-channel attacks were successful.

Below, I will share a few examples of how AES encryption can be compromised (at least in theory).



The advantages of AES
Safety aside, AES encryption is very appealing to those who work with it. Why? Because the encryption process of AES is relatively easy to understand. This allows for easy implementation, as well as really fast encryption and decryption times.

In addition, AES requires less memory than many other types of encryption (like DES), which makes it a true winner when it comes to choosing your preferred encryption method.

Finally, when an action requires an extra layer of safety, you can combine AES with various security protocols like WPA2 or even other types of encryption like SSL. 

Why do we use the AES algorithm?
Even if not exactly “ancient”, the advanced encryption standard is old.

Originally developed in 1998 by two Belgian cryptographers, Vincent Rijmen and Joan Daemen, AES has been around for more than 20 years. At first, it was referred to as Rijndael - a combination of the names of its developers.

Thanks to its impenetrability, AES encryption has already served as the encryption standard for 18 years. That’s because, in 2002, the National Institute of Standards and Technology (NIST) replaced the outdated Data Encryption Standard (DES) with AES. 

Why did this happen?

Well, first of all, the DES key length was a mere 56 bits. And it turned out that this isn’t nearly enough to keep encrypted information safe. For example, a test by distributed.net and the Electronic Frontier Foundation showed that DES can be easily cracked in a little bit more than 22 hours. Keep in mind that this was done in 1999, when computing power was far from what it is now.

Today, a powerful machine can crack a 56-bit DES key in 362 seconds. 

On the other hand, cracking a 128-bit AES encryption key can take up to 36 quadrillion years.

Just imagine what time it would take to crack a 256-bit AES key, which boasts a staggering number of 984,665,640,564,039,457,584,007,913,129,639,936 combinations. Keeping this number in mind, we can safely assume that a brute-force attack on AES encryption will not happen without a significant increase in computing power.

Where is the AES algorithm used?
With its humble beginnings as the go-to encryption cipher of the US government, AES encryption quickly took the world by storm, becoming the encryption standard for basically anything we see online. As a result, you will have trouble finding industries or services that don’t use the AES algorithm.

Online banking credentials, passwords, and messages all need to be protected from people who can do harm. So, aside from “serving” the government (like the National Security Agency), the advanced encryption standard protects the sensitive data of a myriad of products.

Examples of AES usage
Here are a few notable examples of where developers can use the AES encryption:

VPNs (Virtual Private Networks). As the job of a VPN is to securely connect you to another server online, only the best methods of encryption can be considered so that your data wouldn’t leak. The VPNs that use the advanced encryption standard with 256-bit keys include NordVPN, Surfshark, and ExpressVPN.

Wi-Fi. That’s right - wireless networks also use AES encryption (usually, together with WPA2). This is not the only type of encryption Wi-Fi networks can use, however, most of the other encryption methods are far less safe.

Mobile applications. Many popular apps (like Snapchat and Facebook Messenger) use AES encryption in order to safely send info like photos and messages.

Archive and compression tools. All major file compression programs use AES to prevent data from leaking. These tools include 7z, WinZip, and RAR.

OS system components. Some operating system components (like file systems) use the advanced encryption standard for an extra layer of safety.

Programming language libraries. The libraries of such coding languages like Java, Python, and C++ implement AES encryption.

Password managers. These are the programs that carry a lot of sensitive information. That’s why password managers like LastPass and Dashlane don’t skip the important step of AES implementation.

Even though this is an impressive list of what AES encryption is useful for, it still doesn’t include everything. 

Aside from all the things mentioned before, you will encounter the AES encryption algorithm in various file systems and disk encryption systems, as well as web browsers.

That’s right - you even used AES to open this article, as your browser must encrypt your connection with this page.

How does AES encryption work?
Here’s what you should know from the get-go: without the proper background, the AES encryption algorithm can be a tough one to understand. To fully appreciate its intricacies, you would probably have to be a maths major (at least).

Luckily, it is possible to simplify the inner workings of the AES cipher. Replacing the binary code with “normal” symbols is one way of doing it.

In the following sections, I will briefly explain the main idea behind the cryptography of AES.

https://en.wikipedia.org/wiki/Advanced_Encryption_Standard
The Advanced Encryption Standard (AES), also known by its original name Rijndael (Dutch pronunciation: [ˈrɛindaːl]),[5] is a specification for the encryption of electronic data established by the U.S. National Institute of Standards and Technology (NIST) in 2001.[6]

AES is a variant of the Rijndael block cipher[5] developed by two Belgian cryptographers, Joan Daemen and Vincent Rijmen, who submitted a proposal[7] to NIST during the AES selection process.[8] Rijndael is a family of ciphers with different key and block sizes. For AES, NIST selected three members of the Rijndael family, each with a block size of 128 bits, but three different key lengths: 128, 192 and 256 bits.

AES has been adopted by the U.S. government. It supersedes the Data Encryption Standard (DES),[9] which was published in 1977. The algorithm described by AES is a symmetric-key algorithm, meaning the same key is used for both encrypting and decrypting the data.

In the United States, AES was announced by the NIST as U.S. FIPS PUB 197 (FIPS 197) on November 26, 2001.[6] This announcement followed a five-year standardization process in which fifteen competing designs were presented and evaluated, before the Rijndael cipher was selected as the most suitable.[note 3]

AES is included in the ISO/IEC 18033-3 standard. AES became effective as a U.S. federal government standard on May 26, 2002, after approval by the U.S. Secretary of Commerce. AES is available in many different encryption packages, and is the first (and only) publicly accessible cipher approved by the U.S. National Security Agency (NSA) for top secret information when used in an NSA approved cryptographic module.[note 4]

Description of the ciphers
AES is based on a design principle known as a substitution–permutation network, and is efficient in both software and hardware.[11] Unlike its predecessor DES, AES does not use a Feistel network. AES is a variant of Rijndael, with a fixed block size of 128 bits, and a key size of 128, 192, or 256 bits. By contrast, Rijndael per se is specified with block and key sizes that may be any multiple of 32 bits, with a minimum of 128 and a maximum of 256 bits. Most AES calculations are done in a particular finite field.

AES operates on a 4 × 4 column-major order array of 16 bytes b0, b1, ..., b15 termed the state:[note 5]

The key size used for an AES cipher specifies the number of transformation rounds that convert the input, called the plaintext, into the final output, called the ciphertext. The number of rounds are as follows:

10 rounds for 128-bit keys.
12 rounds for 192-bit keys.
14 rounds for 256-bit keys.

Each round consists of several processing steps, including one that depends on the encryption key itself. A set of reverse rounds are applied to transform ciphertext back into the original plaintext using the same encryption key.

High-level description of the algorithm
KeyExpansion – round keys are derived from the cipher key using the AES key schedule. AES requires a separate 128-bit round key block for each round plus one more.
Initial round key addition:
AddRoundKey – each byte of the state is combined with a byte of the round key using bitwise xor.
9, 11 or 13 rounds:
SubBytes – a non-linear substitution step where each byte is replaced with another according to a lookup table.
ShiftRows – a transposition step where the last three rows of the state are shifted cyclically a certain number of steps.
MixColumns – a linear mixing operation which operates on the columns of the state, combining the four bytes in each column.
AddRoundKey
Final round (making 10, 12 or 14 rounds in total):
SubBytes
ShiftRows
AddRoundKey



https://aesencryption.net/
What is AES encryption?
It is a webtool to encrypt and decrypt text using AES encryption algorithm. You can chose 128, 192 or 256-bit long key size for encryption and decryption. The result of the process is downloadable in a text file.

How to use AES encryption?
If you want to encrypt a text put it in the white textarea above, set the key of the encryption then push the Encrypt button.
The result of the encryption will appear in base64 encoded to prevent character encoding problems.
If you want to decrypt a text be sure it is in base64 encoded and is encrypted with AES algorithm!
Put the encrypted text in the white textarea, set the key and push the Decrypt button.

When is helpful to use AES encryption?
When you want to encrypt a confidential text into a decryptable format, for example when you need to send sensitive data in e-mail.
The decryption of the encrypted text it is possible only if you know the right password.

What is AES encryption?
AES (acronym of Advanced Encryption Standard) is a symmetric encryption algorithm.
The algorithm was developed by two Belgian cryptographer Joan Daemen and Vincent Rijmen.
AES was designed to be efficient in both hardware and software, and supports a block length of 128 bits and key lengths of 128, 192, and 256 bits.

How secure is AES encryption algorithm?
AES encryption is used by U.S. for securing sensitive but unclassified material, so we can say it is enough secure.