
# How To Share Your Public Key
- export it from the gpg local key store.
gpg --output ~/moto-groves.key --armor --export moto.groves@gmail.com
less ~/moto-groves.key

options:
1. copy it to a remote computergpg --keyserver moto --search-keys moto.groves@gmail.com
ssh brent@reports-avi
lftp brent@moto
get /home/brent/moto-groves.key 
exit
gpg --import moto-groves.key
2. upload it to a key server
gpg --fingerprint moto.groves@gmail.com
pub   rsa3072 2023-04-13 [SC] [expires: 2023-04-18]
      9DBC 8763 83B3 A9BD D2CB  CCA0 3B65 3444 95BC 7FB0
uid           [ultimate] Moto Groves (test gpg) <moto.groves@gmail.com>
sub   rsa3072 2023-04-13 [E] [expires: 2023-04-18]

gpg --send-keys --keyserver pgp.mit.edu 9DBC876383B3A9BDD2CBCCA03B65344495BC7FB0
gpg --send-keys --keyserver moto 9DBC876383B3A9BDD2CBCCA03B65344495BC7FB0
gpg --send-keys --keyserver reports-avi 9DBC876383B3A9BDD2CBCCA03B65344495BC7FB0
gpg --send-keys --keyserver http://localhost:11371 4D33A6941022E1E0277477E8B3952CE542E39F20
gpg --send-keys --keyserver reports-avi 4D33A6941022E1E0277477E8B3952CE542E39F20
gpg --send-keys --keyserver reports-avi 23CE47FCA5F5E530FA54F820858586D4AE7A3E6F

gpg --keyserver moto --search-keys brent@moto

gpg --keyserver moto --search-keys brent@reports51

gpg --keyserver moto --search-keys brent@reports-avi

