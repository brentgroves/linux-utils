https://www.howtogeek.com/427982/how-to-encrypt-and-decrypt-files-with-gpg-on-linux/
Use a key server to exchange files securely:
https://www.howtogeek.com/427982/how-to-encrypt-and-decrypt-files-with-gpg-on-linux/

Instead of lftp use Avilla qnap for exchanging encrypted files.
Britney Jazzy1!
# Generating your key pair
"The gpg command was installed on all of the Linux distributions that were checked, including Ubuntu, Fedora, and Manjaro."
pick a email address to associate this key pair with (moto.groves@gmail.com).
gpg --full-generate-key

pub   rsa3072 2023-04-14 [SC] [expires: 2028-04-12]
      4D33A6941022E1E0277477E8B3952CE542E39F20
uid                      Cali Groves <cali.groves@gmail.com>
sub   rsa3072 2023-04-14 [E] [expires: 2028-04-12]

# upload you public key to a key server
What is Hockeypuck? It is an OpenPGP public keyserver easily ran as a docker container.
Since we don't have a private keyserver I will use a public one.
- get a code uniquely identifying your key pair
gpg --fingerprint moto.groves@gmail.com
gpg --fingerprint cali.groves@gmail.com
4D33A6941022E1E0277477E8B3952CE542E39F20
# go to remote computer
ssh brent@reports-avi
- install moto-groves@gmail.com public key on remote system.
gpg --keyserver pgp.mit.edu --search-keys moto.groves@gmail.com
# sign the key
gpg --sign-key moto.groves@gmail.com
# encypt raven.txt file
gpg --encrypt --sign --armor -r moto.groves@gmail.com raven.txt
gpg --encrypt --sign --armor -r moto.groves@gmail.com ~/Downloads/TB-202203_to_202303_on_04-11_GP.xlsx
# go back to recipient's computer
ssh brent@moto
lftp brent@reports-avi
get /home/brent/Downloads/TB-202203_to_202303_on_04-11_GP.xlsx.asc 
exit
gpg --decrypt TB-202203_to_202303_on_04-11_GP.xlsx.asc > TB-202203_to_202303_on_04-11_GP.xlsx

# Generating Your Keys
The gpg command was installed on all of the Linux distributions that were checked, including Ubuntu, Fedora, and Manjaro.

gpg --full-generate-key

# Generating a Revocation Certificate
gpg --output ~/moto-revocation.crt --gen-revoke moto.groves@gmail.com

# How To Share Your Public Key
- export it from the gpg local key store.
gpg --output ~/moto-groves.key --armor --export moto.groves@gmail.com
less ~/moto-groves.key

options:
1. copy it to a remote computer
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

# brent@reports51
gpg --send-keys --keyserver moto D7FE7CA4C89645A8B936BEE920E794F892EB0308

gpg --send-keys --keyserver pgp.mit.edu 9DBC876383B3A9BDD2CBCCA03B65344495BC7FB0
gpg --send-keys --keyserver http://localhost:11371 9DBC876383B3A9BDD2CBCCA03B65344495BC7FB0

gpg --send-keys --keyserver http://localhost:11371 4D33A6941022E1E0277477E8B3952CE542E39F20

gpg --send-keys --keyserver localhost 4D33A6941022E1E0277477E8B3952CE542E39F20


go to remote computer
ssh brent@reports-avi
https://superuser.com/questions/1172804/how-to-prevent-gpg-agent-from-timing-out-during-passphrase-collection
nvim ~/.gnupg/gpg-agent.conf
no-grab 
no-allow-external-cache 
pinentry-program /usr/bin/pinentry-curses
default-cache-ttl 86400
max-cache-ttl 86400

http://pgp.mit.edu:11371/pks/lookup?op=stats
http://localhost:11371/pks/lookup?op=stats
- verify
gpg --keyserver pgp.mit.edu --search-keys moto.groves@gmail.com

gpg --keyserver localhost --search-keys moto.groves@gmail.com
gpg --keyserver reports-avi --search-keys cali.groves@gmail.com
gpg --keyserver moto --search-keys brent@reports51

gpg: data source: http://pgp.mit.edu:11371
(1)	Moto Groves (test gpg) <moto.groves@gmail.com>
	  3072 bit RSA key 3B65344495BC7FB0, created: 2023-04-13, expires: 2023-04-18
Keys 1-1 of 1 for "moto.groves@gmail.com".  Enter number(s), N)ext, or Q)uit > 1
gpg: key 3B65344495BC7FB0: public key "Moto Groves (test gpg) <moto.groves@gmail.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1

# sign the key
If you don’t do this, you can still use it to encrypt and decrypt messages from and to that person. But gpg will ask you every time whether you wish to proceed because the key is unsigned.
gpg --sign-key moto.groves@gmail.com
gpg --sign-key brent@reports51

# encypt raven.txt file
gpg --encrypt --sign --armor -r moto.groves@gmail.com raven.txt
gpg --encrypt --sign --armor -r brent@reports51 raven.txt

less raven.txt.asc

# give encrypted file to moto
ssh brent@moto
lftp brent@reports-avi
get /home/brent/raven.txt.asc 
get /home/brent/Downloads/raven.txt.asc 
exit
gpg --decrypt raven.txt.asc > raven.txt

Test passphrase:
Britney Jazzy1!










