#!/usr/bin/env python
import os


# export username3=$(</etc/foo/username3)
# export password3=$(</etc/foo/password3)

with open('/etc/foo/username3') as f:
    username3 = f.readline()
    print(f'username3={username3}')

with open('/etc/foo/password3') as f:
    password3 = f.readline()    
    print(f'password3={password3}')