https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account

To sign commits associated with your account on GitHub, you can add a public GPG key to your personal account. Before you add a key, you should check for existing keys. If you don't find any existing keys, you can generate and copy a new key. For more information, see "Checking for existing GPG keys" and "Generating a new GPG key."

You can add multiple public keys to your account on GitHub. Commits signed by any of the corresponding private keys will show as verified. If you remove a public key, any commits signed by the corresponding private key will no longer show as verified.

To verify as many of your commits as possible, you can add expired and revoked keys. If the key meets all other verification requirements, commits that were previously signed by any of the corresponding private keys will show as verified and indicate that their signing key is expired or revoked.

Supported GPG key algorithms
GitHub supports several GPG key algorithms. If you try to add a key generated with an unsupported algorithm, you may encounter an error.

RSA
ElGamal
DSA
ECDH
ECDSA
EdDSA
When verifying a signature, GitHub extracts the signature and attempts to parse its key ID. The key ID is then matched with keys added to GitHub. Until a matching GPG key is added to GitHub, it cannot verify your signatures.

Adding a GPG key
In the upper-right corner of any page, click your profile photo, then click Settings.

Screenshot of GitHub's account menu showing options for users to view and edit their profile, content, and settings. The menu item "Settings" is outlined in dark orange.

In the "Access" section of the sidebar, click  SSH and GPG keys.

Click New GPG key.
GPG Key button

In the "Key" field, paste the GPG key you copied when you generated your GPG key.
The key field

Click Add GPG key.
The Add key button

To confirm the action, enter your GitHub password.