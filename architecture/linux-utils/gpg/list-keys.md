https://docs.github.com/en/authentication/managing-commit-signature-verification/checking-for-existing-gpg-keys

Open Terminal.

Use the gpg --list-secret-keys --keyid-format=long command to list the long form of the GPG keys for which you have both a public and private key. A private key is required for signing commits or tags.

Shell
$ gpg --list-secret-keys --keyid-format=long

Check the command output to see if you have a GPG key pair.

If there are no GPG key pairs or you don't want to use any that are available for signing commits and tags, then generate a new GPG key.
If there's an existing GPG key pair and you want to use it to sign commits and tags, you can display the public key using the following command, substituting in the GPG key ID you'd like to use. In this example, the GPG key ID is 3AA5C34371567BD2:
$ gpg --armor --export 3AA5C34371567BD2
# Prints the GPG key ID, in ASCII armor format