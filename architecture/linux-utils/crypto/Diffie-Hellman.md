https://www.techtarget.com/searchsecurity/definition/Diffie-Hellman-key-exchange#:~:text=Diffie%2DHellman%20key%20exchange%20is,encrypt%20and%20decrypt%20their%20messages.

https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange

Diffie–Hellman key exchange[nb 1] is a mathematical method of securely exchanging cryptographic keys over a public channel and was one of the first public-key protocols as conceived by Ralph Merkle and named after Whitfield Diffie and Martin Hellman.[1][2] DH is one of the earliest practical examples of public key exchange implemented within the field of cryptography. Published in 1976 by Diffie and Hellman, this is the earliest publicly known work that proposed the idea of a private key and a corresponding public key.

Traditionally, secure encrypted communication between two parties required that they first exchange keys by some secure physical means, such as paper key lists transported by a trusted courier. The Diffie–Hellman key exchange method allows two parties that have no prior knowledge of each other to jointly establish a shared secret key over an insecure channel. This key can then be used to encrypt subsequent communications using a symmetric-key cipher.

Although Diffie–Hellman key agreement itself is a non-authenticated key-agreement protocol, it provides the basis for a variety of authenticated protocols, and is used to provide forward secrecy in Transport Layer Security's ephemeral modes (referred to as EDH or DHE depending on the cipher suite).

The method was followed shortly afterwards by RSA, an implementation of public-key cryptography using asymmetric algorithms.

Diffie–Hellman key exchange establishes a shared secret between two parties that can be used for secret communication for exchanging data over a public network. An analogy illustrates the concept of public key exchange by using colors instead of very large numbers:

The process begins by having the two parties, Alice and Bob, publicly agree on an arbitrary starting color that does not need to be kept secret. In this example, the color is yellow. Each person also selects a secret color that they keep to themselves – in this case, red and cyan. The crucial part of the process is that Alice and Bob each mix their own secret color together with their mutually shared color, resulting in orange-tan and light-blue mixtures respectively, and then publicly exchange the two mixed colors. Finally, each of them mixes the color they received from the partner with their own private color. The result is a final color mixture (yellow-brown in this case) that is identical to their partner's final color mixture.

If a third party listened to the exchange, they would only know the common color (yellow) and the first mixed colors (orange-tan and light-blue), but it would be very hard for them to find out the final secret color (yellow-brown). Bringing the analogy back to a real-life exchange using large numbers rather than colors, this determination is computationally expensive. It is impossible to compute in a practical amount of time even for modern supercomputers.

[DH](https://en.wikipedia.org/wiki/File:Diffie-Hellman_Key_Exchange.svg)
Generalization to finite cyclic groups
Here is a more general description of the protocol:[9]

Alice and Bob agree on a natural number n and a generating element g in the finite cyclic group G of order n. (This is usually done long before the rest of the protocol; g is assumed to be known by all attackers.) The group G is written multiplicatively.
Alice picks a random natural number a with 1 < a < n, and sends the element ga of G to Bob.
Bob picks a random natural number b with 1 < b < n, and sends the element gb of G to Alice.
Alice computes the element (gb)a = gba of G.
Bob computes the element (ga)b = gab of G.

