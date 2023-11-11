https://en.wikipedia.org/wiki/Cipher

In cryptography, a cipher (or cypher) is an algorithm for performing encryption or decryption—a series of well-defined steps that can be followed as a procedure. An alternative, less common term is encipherment. To encipher or encode is to convert information into cipher or code. In common parlance, "cipher" is synonymous with "code", as they are both a set of steps that encrypt a message; however, the concepts are distinct in cryptography, especially classical cryptography.

Codes generally substitute different length strings of characters in the output, while ciphers generally substitute the same number of characters as are input. A code maps one meaning with another. Words and phrases can be coded as letters or numbers. Codes typically have direct meaning from input to key. Codes primarily function to save time. Ciphers are algorithmic. The given input must follow the cipher's process to be solved. Ciphers are commonly used to encrypt written information.

Codes operated by substituting according to a large codebook which linked a random string of characters or numbers to a word or phrase. For example, "UQJHSE" could be the code for "Proceed to the following coordinates." When using a cipher the original information is known as plaintext, and the encrypted form as ciphertext. The ciphertext message contains all the information of the plaintext message, but is not in a format readable by a human or computer without the proper mechanism to decrypt it.

The operation of a cipher usually depends on a piece of auxiliary information, called a key (or, in traditional NSA parlance, a cryptovariable). The encrypting procedure is varied depending on the key, which changes the detailed operation of the algorithm. A key must be selected before using a cipher to encrypt a message. Without knowledge of the key, it should be extremely difficult, if not impossible, to decrypt the resulting ciphertext into readable plaintext.

Most modern ciphers can be categorized in several ways

By whether they work on blocks of symbols usually of a fixed size (block ciphers), or on a continuous stream of symbols (stream ciphers).
By whether the same key is used for both encryption and decryption (symmetric key algorithms), or if a different key is used for each (asymmetric key algorithms). If the algorithm is symmetric, the key must be known to the recipient and sender and to no one else. If the algorithm is an asymmetric one, the enciphering key is different from, but closely related to, the deciphering key. If one key cannot be deduced from the other, the asymmetric key algorithm has the public/private key property and one of the keys may be made public without loss of confidentiality.

Versus codes
Main article: Code (cryptography)
In casual contexts, “code” and “cipher” can typically be used interchangeably, however, the technical usages of the words refer to different concepts. Codes contain meaning; words and phrases are assigned to numbers or symbols, creating a shorter message.

An example of this is the commercial telegraph code which was used to shorten long telegraph messages which resulted from entering into commercial contracts using exchanges of telegrams.

Another example is given by whole word ciphers, which allow the user to replace an entire word with a symbol or character, much like the way Japanese utilize Kanji (meaning Chinese characters in Japanese) characters to supplement their language. ex "The quick brown fox jumps over the lazy dog" becomes "The quick brown 狐 jumps 上 the lazy 犬".

Ciphers, on the other hand, work at a lower level: the level of individual letters, small groups of letters, or, in modern schemes, individual bits and blocks of bits. Some systems used both codes and ciphers in one system, using superencipherment to increase the security. In some cases the terms codes and ciphers are also used synonymously to substitution and transposition.

Historically, cryptography was split into a dichotomy of codes and ciphers; and coding had its own terminology, analogous to that for ciphers: "encoding, codetext, decoding" and so on.

However, codes have a variety of drawbacks, including susceptibility to cryptanalysis and the difficulty of managing a cumbersome codebook. Because of this, codes have fallen into disuse in modern cryptography, and ciphers are the dominant technique.

Modern
Modern encryption methods can be divided by two criteria: by type of key used, and by type of input data.

By type of key used ciphers are divided into:

symmetric key algorithms (Private-key cryptography), where one same key is used for encryption and decryption, and
AES (Rijndael) Round Function.png
asymmetric key algorithms (Public-key cryptography), where two different keys are used for encryption and decryption.
In a symmetric key algorithm (e.g., DES and AES), the sender and receiver must have a shared key set up in advance and kept secret from all other parties; the sender uses this key for encryption, and the receiver uses the same key for decryption. The design of AES (Advanced Encryption System) was beneficial because it aimed to overcome the flaws in the design of the DES (Data encryption standard). AES’s designer’s claim that the common means of modern cipher cryptanalytic attacks are ineffective against AES due to its design structure.[12]

Ciphers can be distinguished into two types by the type of input data:

block ciphers, which encrypt block of data of fixed size, and
stream ciphers, which encrypt continuous streams of data.
