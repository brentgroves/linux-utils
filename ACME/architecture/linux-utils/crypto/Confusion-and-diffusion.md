In cryptography, confusion and diffusion are two properties of the operation of a secure cipher identified by Claude Shannon in his 1945 classified report A Mathematical Theory of Cryptography[1]. These properties, when present, work to thwart the application of statistics and other methods of cryptanalysis.

These concepts are also important in the design of secure hash functions and pseudorandom number generators where decorrelation of the generated values is the main feature.

Confusion
Confusion means that each binary digit (bit) of the ciphertext should depend on several parts of the key, obscuring the connections between the two.[2]

The property of confusion hides the relationship between the ciphertext and the key.

This property makes it difficult to find the key from the ciphertext and if a single bit in a key is changed, the calculation of most or all of the bits in the ciphertext will be affected.

Confusion increases the ambiguity of ciphertext and it is used by both block and stream ciphers.

In substitution–permutation networks, confusion is provided by substitution boxes.

Diffusion
Diffusion means that if we change a single bit of the plaintext, then about half of the bits in the ciphertext should change, and similarly, if we change one bit of the ciphertext, then about half of the plaintext bits should change.[3] This is equivalent to the expectation that encryption schemes exhibit an avalanche effect.

The purpose of diffusion is to hide the statistical relationship between the ciphertext and the plain text. For example, diffusion ensures that any patterns in the plaintext, such as redundant bits, are not apparent in the ciphertext.[2] Block ciphers achieve this by "diffusing" the information about the plaintext's structure across the rows and columns of the cipher.

In substitution–permutation networks, diffusion is provided by permutation boxes.