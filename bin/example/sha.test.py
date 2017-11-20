#!/usr/bin/env python3
from hashlib import md5, sha1, sha256, sha512, blake2b
from random import random
from time import time

SIZE = 4000000
rands = [repr(random()).encode() for i in range(SIZE)]

t = time()
hash = [md5(rand).hexdigest() for rand in rands]
print('md5')
print(time() - t)
print()

t = time()
hash = [sha1(rand).hexdigest() for rand in rands]
print('sha1')
print(time() - t)
print()

t = time()
hash = [sha256(rand).hexdigest() for rand in rands]
print('sha256')
print(time() - t)
print()

t = time()
hash = [sha512(rand).hexdigest() for rand in rands]
print('sha512')
print(time() - t)
print()

t = time()
hash = [blake2b(rand).hexdigest() for rand in rands]
print('blake2b')
print(time() -t)
print()
