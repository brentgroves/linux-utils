https://en.wikipedia.org/wiki/Padding_(cryptography)

In cryptography, padding is any of a number of distinct practices which all include adding data to the beginning, middle, or end of a message prior to encryption. In classical cryptography, padding may include adding nonsense phrases to a message to obscure the fact that many messages end in predictable ways, e.g. sincerely yours.

Official messages often start and end in predictable ways: My dear ambassador, Weather report, Sincerely yours, etc. The primary use of padding with classical ciphers is to prevent the cryptanalyst from using that predictability to find known plaintext[1] that aids in breaking the encryption. Random length padding also prevents an attacker from knowing the exact length of the plaintext message.