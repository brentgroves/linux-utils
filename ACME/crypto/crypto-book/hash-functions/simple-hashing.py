#!/usr/bin/env python
# https://docs.python.org/3/library/hashlib.html
# https://cryptobook.nakov.com/cryptographic-hash-functions
# To calculate hash of some data, you should first construct a hash object by calling the 
# appropriate constructor function (blake2b() or blake2s()), then update it with the data by 
# calling update() on the object, and, finally, get the digest out of the object by calling 
# digest() (or hexdigest() for hex-encoded string).

import hashlib
import binascii
sha3_256hash = hashlib.sha3_256(b'hello').digest()
print("SHA3-256('hello') =", binascii.hexlify(sha3_256hash))
m = hashlib.sha3_256()
m.update(b"hello")
sha3_256hash=m.digest()
print("SHA3-256('hello') =", binascii.hexlify(sha3_256hash))
# b',\xf2M\xba_\xb0\xa3\x0e&\xe8;*\xc5\xb9\xe2\x9e\x1b\x16\x1e\\\x1f\xa7B^s\x043b\x93\x8b\x98$'
# m.update(b" the spammish repetition")
# m.digest()
# b'\x03\x1e\xdd}Ae\x15\x93\xc5\xfe\\\x00o\xa5u+7\xfd\xdf\xf7\xbcN\x84:\xa6\xaf\x0c\x95\x0fK\x94\x06'
# m.hexdigest()