https://www.howtogeek.com/427982/how-to-encrypt-and-decrypt-files-with-gpg-on-linux/
The trick seems to be in exchanging and managing keys or key pairs. A good system used for the management of keys and use of cyphers is GPG which is now recommended way of storing repository keys in Ubuntu.

GnuPrivacy Guard (GPG) allows you to securely encrypt files so that only the intended recipient can decrypt them. Specifically, GPG complies with the OpenPGP standard. It is modeled on a program called Pretty Good Privacy (PGP). PGP was written in 1991 by Phil Zimmerman.

GPG relies on the idea of two encryption keys per person. Each person has a private key and a public key. The public key can decrypt something that was encrypted using the private key.

To send a file securely, you encrypt it with your private key and the recipient’s public key. To decrypt the file, they need their private key and your public key.

You’ll see from this that public keys must be shared. You need to have the public key of the recipient in order to encrypt the file, and the recipient needs your public key to decrypt it. There is no danger in making your public keys just that—public. In fact, there are Public Key Servers for that very purpose, as we shall see. Private keys must be kept private. If your public key is in the public domain, then your private key must be kept secret and secure.

# Generating Your Keys
The gpg command was installed on all of the Linux distributions that were checked, including Ubuntu, Fedora, and Manjaro.

You don’t have to use GPG with email. You can encrypt files and make them available for download, or pass them physically to the recipient. You do need to associate an email address with the keys you generate, however, so choose which email address you are going to use.

Here is the command to generate your keys. The --full-generate-key option generates your keys in an interactive session within your terminal window. You will also be prompted for a passphrase. Make sure you remember what the passphrase is. Three or four simple words joined together with punctuation is a good and robust model for passwords and passphrases.


gpg --full-generate-key
Requested keysize is 3072 bits
Key expires at Tue 18 Apr 2023 02:54:17 PM EDT
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: key 3B65344495BC7FB0 marked as ultimately trusted
gpg: revocation certificate stored as '/home/brent/.gnupg/openpgp-revocs.d/9DBC876383B3A9BDD2CBCCA03B65344495BC7FB0.rev'
public and secret key created and signed.

pub   rsa3072 2023-04-13 [SC] [expires: 2023-04-18]
      9DBC876383B3A9BDD2CBCCA03B65344495BC7FB0
uid                      Moto Groves (test gpg) <moto.groves@gmail.com>
sub   rsa3072 2023-04-13 [E] [expires: 2023-04-18]


hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/random
Britney Jazzy1!



ls ~/.gnupg
private-keys-v1.d  pubring.kbx  pubring.kbx~  random_seed  trustdb.gpg
ls ~/.gnupg
openpgp-revocs.d  private-keys-v1.d  pubring.kbx  pubring.kbx~  random_seed  trustdb.gpg

ls ~/.gnupg/private-keys-v1.d 
8BD7BC942EA3ADE8E7393AE37A05A1D50E40FB93.key  EA5322138E6CF6AA2CAC25291D1DD5DA4F683361.key

ls ~/.gnupg/private-keys-v1.d 
182F13F44635C94DD642A9BCDC0B5CA857F35202.key  8BD7BC942EA3ADE8E7393AE37A05A1D50E40FB93.key  99AA64BADD2C3954ADBD24B9F4040D96384745B1.key  EA5322138E6CF6AA2CAC25291D1DD5DA4F683361.key

ls ~/.gnupg/private-keys-v1.d 

071B850AEFB2264E3F2D8576DA86D7470E666219.key  2A1BA9BD2D318555B01A016A19704946D8BDEE7A.key  99AA64BADD2C3954ADBD24B9F4040D96384745B1.key
182F13F44635C94DD642A9BCDC0B5CA857F35202.key  8BD7BC942EA3ADE8E7393AE37A05A1D50E40FB93.key  EA5322138E6CF6AA2CAC25291D1DD5DA4F683361.key


# Generating a Revocation Certificate
If your private key becomes known to others, you will need to disassociate the old keys from your identity, so that you can generate new ones. To do this, you will require a revocation certificate. We’ll do this now and store it somewhere safe.

The --output option must be followed by the filename of the certificate you wish to create. The --gen-revoke option causes gpg to generate a revocation certificate. You must provide the email address that you used when the keys were generated.

gpg --output ~/moto-revocation.crt --gen-revoke moto.groves@gmail.com
gpg: 'brent.groves@gmail.com' matches multiple secret keys:
gpg:   sec  rsa4096/ECC27BA70C24BB41 2023-03-01 Brent Groves <brent.groves@gmail.com>
gpg:   sec  rsa3072/D09FC93FA4C9024E 2023-04-13 Brent Groves (test gpg) <brent.groves@gmail.com>

sec  rsa3072/3B65344495BC7FB0 2023-04-13 Moto Groves (test gpg) <moto.groves@gmail.com>

You can always use a key ID instead of a user ID. For example, for encrypting a message to my newer key:
gpg --encrypt --recipient A4FF2279
gpg --output ~/revocation.crt --gen-revoke D09FC93FA4C9024E

Revocation certificate created.
Please move it to a medium which you can hide away; if Mallory gets
access to this certificate he can use it to make your key unusable.
It is smart to print this certificate and store it away, just in case
your media become unreadable.  But have some caution:  The print system of
your machine might store the data and make it available to others!

The certificate will be generated. You will see a message reinforcing the need to keep this certificate safe.

It mentions someone called Mallory. Cryptography discussions have long used Bob and Alice as the two people communicating. There are other supporting characters. Eve is an eavesdropper, Mallory is a malicious attacker. All we need to know is we must keep the certificate safe and secure.

As a minimum, let’s remove all permissions apart from ours from the certificate.

chmod 600 ~/revocation.crt


Importing Someone Else’s Public Key
To encrypt a message so that only the recipient can decrypt it, we must have the recipient’s public key.

If you have been provided with their key in a file, you can import it with the following command. In this example, the key file is called “mary-geek.key.”

gpg --import mary-geek.key

How To Share Your Public Key
To share your key as a file, we need to export it from the gpg local key store. To do this, we’ll use the --export option, which must be followed by the email address that you used to generate the key. The --output option must be followed by the name fo the file you wish to have the key exported into. The --armor option tells gpg to generate ASCII armor output instead of a binary file.

gpg --output ~/dave-geek.key --armor --export dave-geek@protonmail.com

OpenPGP provides the service of converting the raw 8-bit binary octet stream to a stream of printable ASCII characters, called Radix-64 encoding or ASCII Armor. In other words, ASCII Armor is another name of a specific binary-to-text encoding (the Radix-64).

Use a key server to exchange files securely:
https://www.howtogeek.com/427982/how-to-encrypt-and-decrypt-files-with-gpg-on-linux/

# Generating your key pair
"The gpg command was installed on all of the Linux distributions that were checked, including Ubuntu, Fedora, and Manjaro."
pick a email address to associate this key pair with (moto.groves@gmail.com).
gpg --full-generate-key
# upload you public key to a key server
What is Hockeypuck? It is an OpenPGP public keyserver easily ran as a docker container.
Since we don't have a private keyserver I will use a public one.
- get a code uniquely identifying your key pair
gpg --fingerprint moto.groves@gmail.com
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



