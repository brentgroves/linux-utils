**Need version 1.1.1 for mongodb and python zeep soap**  
openssl version

**conda fix**
explicitly add openssl to env file:  
- openssl=1.1.1
**How to install a pre-built version**
All the available ssl versions can be found here:  
http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/?C=M;O=D  
There are 

cd ~/Downloads
wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
// sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb # did not work
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
**openssl**
when creating a new environment it looks like conda uses the first openssl library on the $PATH, ie which openssl, and copies it into the environment directory. So when we use python zeep that is what version of openssl is used.

logout and login
openssl version
or  
wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
**How to build an install from scratch**
https://learnubuntu.com/install-openssl/
This url also describes the versioning of the 2 major releases of openssl.  




moto
/home/brent/.nvm/versions/node/v18.12.1/bin:/home/brent/anaconda3/envs/reports/bin:/home/brent/anaconda3/condabin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/brent/bin:/usr/local/bin:/home/bgroves@BUSCHE-CNC.COM/anaconda3/bin:/home/brent/.pyenv/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt/mssql-tools18/bin:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/lib:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git-extras:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/z:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/colored-man-pages:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract:/home/brent/.antigen/bundles/zsh-users/zsh-syntax-highlighting:/home/brent/.antigen/bundles/zsh-users/zsh-autosuggestions:/home/brent/.antigen/bundles/zsh-users/zsh-completions:/home/brent/.antigen/bundles/andrewferrier/fzf-z:/home/brent/.antigen/bundles/changyuheng/zsh-interactive-cd

which openssl
/home/brent/anaconda3/envs/reports/bin/openssl
before python ws_to_dw-test.py
OpenSSL 1.1.1n  15 Mar 2022
after python ws_to_dw-test.py
OpenSSL 1.1.1q  5 Jul 2022

openssl version -a
OpenSSL 1.1.1q  5 Jul 2022
built on: Fri Oct 21 08:06:56 2022 UTC
platform: linux-x86_64
options:  bn(64,64) rc4(16x,int) des(int) idea(int) blowfish(ptr) 
compiler: /home/conda/feedstock_root/build_artifacts/openssl_split_1666339471838/_build_env/bin/x86_64-conda-linux-gnu-cc -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /home/brent/anaconda3/envs/reports/include -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/brent/anaconda3/envs/reports/include -fdebug-prefix-map=/home/conda/feedstock_root/build_artifacts/openssl_split_1666339471838/work=/usr/local/src/conda/openssl_split-1.1.1q -fdebug-prefix-map=/home/brent/anaconda3/envs/reports=/usr/local/src/conda-prefix -Wa,--noexecstack -fPIC -pthread -m64 -Wa,--noexecstack -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/brent/anaconda3/envs/reports/include -fdebug-prefix-map=/home/conda/feedstock_root/build_artifacts/openssl_split_1666339471838/work=/usr/local/src/conda/openssl_split-1.1.1q -fdebug-prefix-map=/home/brent/anaconda3/envs/reports=/usr/local/src/conda-prefix -Wa,--noexecstack -DOPENSSL_USE_NODELETE -DL_ENDIAN -DOPENSSL_PIC -DOPENSSL_CPUID_OBJ -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DKECCAK1600_ASM -DRC4_ASM -DMD5_ASM -DAESNI_ASM -DVPAES_ASM -DGHASH_ASM -DECP_NISTZ256_ASM -DX25519_ASM -DPOLY1305_ASM -DNDEBUG -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /home/brent/anaconda3/envs/reports/include
OPENSSLDIR: "/home/brent/anaconda3/envs/reports/ssl"
ENGINESDIR: "/home/brent/anaconda3/envs/reports/lib/engines-1.1"
Seeding source: os-specific




reports31
/home/brent/.nvm/versions/node/v18.13.0/bin:/home/brent/anaconda3/bin:/home/brent/anaconda3/condabin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/brent/.local/bin:/home/brent/bin:/usr/local/bin:/home/bgroves@BUSCHE-CNC.COM/anaconda3/bin:/home/brent/.pyenv/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt/mssql-tools18/bin:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/lib:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git-extras:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/z:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/colored-man-pages:/home/brent/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract:/home/brent/.antigen/bundles/zsh-users/zsh-syntax-highlighting:/home/brent/.antigen/bundles/zsh-users/zsh-autosuggestions:/home/brent/.antigen/bundles/zsh-users/zsh-completions:/home/brent/.antigen/bundles/andrewferrier/fzf-z:/home/brent/.antigen/bundles/changyuheng/zsh-interactive-cd:/home/brent/.fzf/bin
which openssl
/home/brent/anaconda3/bin/openssl

OpenSSL 1.1.1n  15 Mar 2022
built on: Mon Mar 21 08:17:01 2022 UTC
platform: linux-x86_64
options:  bn(64,64) rc4(16x,int) des(int) idea(int) blowfish(ptr)
compiler: /tmp/build/80754af9/openssl_1647850586650/_build_env/bin/x86_64-conda-linux-gnu-cc -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /home/brent/anaconda3/include -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/brent/anaconda3/include -fdebug-prefix-map=/tmp/build/80754af9/openssl_1647850586650/work=/usr/local/src/conda/openssl-1.1.1n -fdebug-prefix-map=/home/brent/anaconda3=/usr/local/src/conda-prefix -Wa,--noexecstack -fPIC -pthread -m64 -Wa,--noexecstack -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/brent/anaconda3/include -fdebug-prefix-map=/tmp/build/80754af9/openssl_1647850586650/work=/usr/local/src/conda/openssl-1.1.1n -fdebug-prefix-map=/home/brent/anaconda3=/usr/local/src/conda-prefix -Wa,--noexecstack -DOPENSSL_USE_NODELETE -DL_ENDIAN -DOPENSSL_PIC -DOPENSSL_CPUID_OBJ -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DKECCAK1600_ASM -DRC4_ASM -DMD5_ASM -DAESNI_ASM -DVPAES_ASM -DGHASH_ASM -DECP_NISTZ256_ASM -DX25519_ASM -DPOLY1305_ASM -DNDEBUG -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /home/brent/anaconda3/include
OPENSSLDIR: "/home/brent/anaconda3/ssl"
ENGINESDIR: "/home/brent/anaconda3/lib/engines-1.1"
Seeding source: os-specific

