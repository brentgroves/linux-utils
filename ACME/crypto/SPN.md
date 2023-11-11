In short, AES is a symmetric type of encryption, as it uses the same key to both encrypt and decrypt data.

It also uses the SPN (substitution permutation network) algorithm, applying multiple rounds to encrypt data. These encryption rounds are the reason behind the impenetrability of AES, as there are far too many rounds to break through.

There are three lengths of AES encryption keys. Each key length has a different number of possible key combinations:

128-bit key length: 3.4 x 1038
192-bit key length: 6.2 x 1057
256-bit key length: 1.1 x 1077

In cryptography, an SP-network, or substitution–permutation network (SPN), is a series of linked mathematical operations used in block cipher algorithms such as AES (Rijndael), 3-Way, Kalyna, Kuznyechik, PRESENT, SAFER, SHARK, and Square.

Such a network takes a block of the plaintext and the key as inputs, and applies several alternating rounds or layers of substitution boxes (S-boxes) and permutation boxes (P-boxes) to produce the ciphertext block. The S-boxes and P-boxes transform (sub-)blocks of input bits into output bits. It is common for these transformations to be operations that are efficient to perform in hardware, such as exclusive or (XOR) and bitwise rotation. The key is introduced in each round, usually in the form of "round keys" derived from it. (In some designs, the S-boxes themselves depend on the key.)

Decryption is done by simply reversing the process (using the inverses of the S-boxes and P-boxes and applying the round keys in reversed order).

Components
An S-box substitutes a small block of bits (the input of the S-box) by another block of bits (the output of the S-box). This substitution should be one-to-one, to ensure invertibility (hence decryption). In particular, the length of the output should be the same as the length of the input (the picture on the right has S-boxes with 4 input and 4 output bits), which is different from S-boxes in general that could also change the length, as in Data Encryption Standard (DES), for example. An S-box is usually not simply a permutation of the bits. Rather, a good S-box will have the property that changing one input bit will change about half of the output bits (or an avalanche effect). It will also have the property that each output bit will depend on every input bit.


A P-box is a permutation of all the bits: it takes the outputs of all the S-boxes of one round, permutes the bits, and feeds them into the S-boxes of the next round. A good P-box has the property that the output bits of any S-box are distributed to as many S-box inputs as possible.

At each round, the round key (obtained from the key with some simple operations, for instance, using S-boxes and P-boxes) is combined using some group operation, typically XOR.

Permutation box
In cryptography, a permutation box is a method of bit-shuffling used to permute or transpose bits across S-boxes inputs, retaining diffusion while transposing. In block ciphers, the S-boxes and P-boxes are used to make the relation between the plaintext and the ciphertext difficult to understand. Wikipedia

A single typical S-box or a single P-box alone does not have much cryptographic strength: an S-box could be thought of as a substitution cipher, while a P-box could be thought of as a transposition cipher. However, a well-designed SP network with several alternating rounds of S- and P-boxes already satisfies Shannon's confusion and diffusion properties:



