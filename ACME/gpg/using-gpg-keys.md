https://confluence.atlassian.com/bitbucketserver/using-gpg-keys-913477014.html

Use this command to list your GPG keys.
gpg --list-secret-keys --keyid-format LONG

Copy the GPG key ID to use with Bitbucket. For example, below the GPG key ID is 7FFFC09ACAC05FD0.


gpg --list-secret-keys --keyid-format LONG
/home/brent/.gnupg/pubring.kbx
------------------------------
sec   rsa4096/ECC27BA70C24BB41 2023-03-01 [SC]
      039036C4E9FA2ADAE1BE94C6ECC27BA70C24BB41
uid                 [ultimate] Brent Groves <brent.groves@gmail.com>
ssb   rsa4096/38AF78B1B4211DCA 2023-03-01 [E]

sec   rsa3072/B3952CE542E39F20 2023-04-14 [SC] [expires: 2028-04-12]
      4D33A6941022E1E0277477E8B3952CE542E39F20
uid                 [ultimate] Cali Groves <cali.groves@gmail.com>
ssb   rsa3072/9B54E73F5B2EE32F 2023-04-14 [E] [expires: 2028-04-12]

sec   rsa3072/B1F9909F3A98493F 2023-04-15 [SC] [expires: 2028-04-13]
      F15AEC7B8377EC7F2FB72225B1F9909F3A98493F
uid                 [ultimate] Brent reports-avi <brent@reports-avi>
ssb   rsa3072/524471B061DB9B33 2023-04-15 [E] [expires: 2028-04-13]


Get your public key you'll add to Bitbucket.
Paste the GPG key ID into this command to export the public key you will enter in Bitbucket.
gpg --armor --export B1F9909F3A98493F

From the output, copy your public GPG key, which starts at -----BEGIN PGP PUBLIC KEY BLOCK-----
and ends at  -----END PGP PUBLIC KEY BLOCK-----.

