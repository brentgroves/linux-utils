https://www.techtarget.com/searchsecurity/definition/nonce

What is a nonce?
A nonce is a random or semi-random number that is generated for a specific use. It is related to cryptographic communication and information technology (IT). The term stands for "number used once" or "number once" and is commonly referred to as a cryptographic nonce.

Typically, a nonce is a value that varies with time to verify that specific values are not reused. A nonce can be a timestamp, a visit counter on a webpage or a special marker intended to limit or prevent the unauthorized replay or reproduction of a file.

In cryptography, a nonce is an arbitrary number that can be used just once in a cryptographic communication.[1] It is often a random or pseudo-random number issued in an authentication protocol to ensure that old communications cannot be reused in replay attacks. They can also be useful as initialization vectors and in cryptographic hash functions.

A nonce is an arbitrary number used only once in a cryptographic communication, in the spirit of a nonce word. They are often random or pseudo-random numbers. Many nonces also include a timestamp to ensure exact timeliness, though this requires clock synchronisation between organisations. The addition of a client nonce ("cnonce") helps to improve the security in some ways as implemented in digest access authentication. To ensure that a nonce is used only once, it should be time-variant (including a suitably fine-grained timestamp in its value), or generated with enough random bits to ensure a insignificantly low chance of repeating a previously generated value. Some authors define pseudo-randomness (or unpredictability) as a requirement for a nonce.[2]

We can see it in figure 2, the plaintext is divided into blocks and needs to add padding data. First, we will use the plaintext block xor with the IV. Then CBC will encrypt the result to the ciphertext block. In the next block, we will use the encryption result to xor with plaintext block until the last block. In this mode, even if we encrypt the same plaintext block, we will get a different ciphertext block. We can decrypt the data in parallel, but it is not possible when encrypting data. If a plaintext or ciphertext block is broken, it will affect all following block.

A Mallory can change the IV to attack the system. Even if a bit is wrong in the IV, all data is broken. Mallory also can make a padding oracle attack. They can use a part of ciphertext to pad the ciphertext block. This will return some messages about the plaintext. It is safe from CPA, but it is easily sysceptible to CCA and PA.

To ensure security, we need to change the key when we encrypt 2^((n+1)/2)(n is the length of a block).


