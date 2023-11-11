Hash Functions
In computer programming hash functions map text (or other data) to integer numbers. Usually different inputs maps to different outputs, but sometimes a collision may happen (different input with the same output).

pushd ~/src/linux-utils/conda
conda env create -f env-crypto.yml
pushd ~/src/linux-utils/crypto/book/hash-functions
Cryptographic hash functions transform text or binary data to fixed-length hash value and are known to be collision-resistant and irreversible. Example of cryptographic hash function is SHA3-256:
SHA3-256("hello") = "3338be694f50c5f338814986cdf0686453a888b84f424d792af4b9202398f392"
The above SHA3-256 hash calculation can be coded in Python like this:
import hashlib, binascii
sha3_256hash = hashlib.sha3_256(b'hello').digest()
print("SHA3-256('hello') =", binascii.hexlify(sha3_256hash))