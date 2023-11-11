https://raymii.org/s/tutorials/OpenSSL_command_line_Root_and_Intermediate_CA_including_OCSP_CRL%20and_revocation.html

# installing self-signed certificates into the openssl framework
http://gagravarr.org/writing/openssl-certs/others.shtml#selfsigned-openssl


https://itslinuxfoss.com/install-openssl-ubuntu-22-04/
sudo apt install openssl -y
openssl is already the newest version (3.0.2-0ubuntu1.10).
# Newer openssl versions
if you install the latest version of openssl in the python base environment you can perform TLS/SSL certificate verification with less errors but in the reports python centric environment you may need to install openssl version 1.1.1 because many python database libraries require it.
## can't install the latest version of curl in base 

openssl s_client -connect frt-kors43:443 -CApath /etc/ssl/certs/ 2>&1 < /dev/null

conda install -c anaconda openssl
# latest curl
just installing the latest version of curl from conda will also update the openssl library
conda install -c conda-forge curl
many python libraries such as pyodbc may require an older version of openssl this may be a problem if you are working with TLS/SSL certificate verifications giving you many errors that would be resolved with new versions of openssl installed.

# note 
If you install curl from conda-forge many openssl libraries will be updated to newer version in that environment.

- reports env contains openssl=1.1.1
- The default OpenSSL version on Ubuntu 22.04 is 3.1.0 so this
environment will use it unless you specifically install a 1.1.1
- I believe I needed this version for pysoap and maybe mongodb to work
OpenSSL 1.1.1n  15 Mar 2022
built on: Mon Mar 21 08:17:01 2022 UTC
platform: linux-x86_64
options:  bn(64,64) rc4(16x,int) des(int) idea(int) blowfish(ptr) 
compiler: /tmp/build/80754af9/openssl_1647850586650/_build_env/bin/x86_64-conda-linux-gnu-cc -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /home/brent/anaconda3/include -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/brent/anaconda3/include -fdebug-prefix-map=/tmp/build/80754af9/openssl_1647850586650/work=/usr/local/src/conda/openssl-1.1.1n -fdebug-prefix-map=/home/brent/anaconda3=/usr/local/src/conda-prefix -Wa,--noexecstack -fPIC -pthread -m64 -Wa,--noexecstack -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/brent/anaconda3/include -fdebug-prefix-map=/tmp/build/80754af9/openssl_1647850586650/work=/usr/local/src/conda/openssl-1.1.1n -fdebug-prefix-map=/home/brent/anaconda3=/usr/local/src/conda-prefix -Wa,--noexecstack -DOPENSSL_USE_NODELETE -DL_ENDIAN -DOPENSSL_PIC -DOPENSSL_CPUID_OBJ -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DKECCAK1600_ASM -DRC4_ASM -DMD5_ASM -DAESNI_ASM -DVPAES_ASM -DGHASH_ASM -DECP_NISTZ256_ASM -DX25519_ASM -DPOLY1305_ASM -DNDEBUG -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /home/brent/anaconda3/include
OPENSSLDIR: "/home/brent/anaconda3/ssl"
ENGINESDIR: "/home/brent/anaconda3/lib/engines-1.1"
Seeding source: os-specific