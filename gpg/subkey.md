https://wiki.debian.org/Subkeys#:~:text=What%20are%20subkeys%3F,also%20stored%20separately%20from%20them.

What are subkeys?
OpenPGP further supports subkeys, which are like the normal keys, except they're bound to a primary key pair. A subkey can be used for signing or for encryption. The really useful part of subkeys is that they can be revoked independently of the primary keys, and also stored separately from them.

In other words, subkeys are like a separate key pair, but automatically associated with your primary key pair.

GnuPG actually uses a signing-only key as the primary key, and creates an encryption subkey automatically. Without a subkey for encryption, you can't have encrypted e-mails with GnuPG at all. Debian requires you to have the encryption subkey so that certain kinds of things can be e-mailed to you safely, such as the initial password for your debian.org shell account.

Why?
Subkeys make key management easier. The primary key pair is quite important: it is the best proof of your identity online, at least for Debian, and if you lose it, you'll need to start building your reputation from scratch. If anyone else gets access to your private primary key or its private subkey, they can make everyone believe they're you: they can upload packages in your name, vote in your name, and do pretty much anything else you can do. This can be very harmful for Debian. You might dislike it as well. So you should keep all your private keys safe.

You should keep your private primary key very, very safe. However, keeping all your keys extremely safe is inconvenient: every time you need to sign a new package upload, you need to copy the packages onto suitable portable media, go into your sub-basement, prove to the armed guards that you're you by using several methods of biometric and other identification, go through a deadly maze, feed the guard dogs the right kind of meat, and then finally open the safe, get out the signing laptop, and sign the packages. Then do the reverse to get back up to your Internet connection for uploading the packages.

Subkeys make this easier: you already have an automatically created encryption subkey and you create another subkey for signing, and you keep those on your main computer. You publish the subkeys on the normal keyservers, and everyone else will use them instead of the primary keys for encrypting messages or verifying your message signatures. Likewise, you will use the subkeys for decrypting and signing messages.

You will need to use the primary keys only in exceptional circumstances, namely when you want to modify your own or someone else's key. More specifically, you need the primary private key:

when you sign someone else's key or revoke an existing signature,
when you add a new UID or mark an existing UID as primary,

when you create a new subkey,
when you revoke an existing UID or subkey,
when you change the preferences (e.g., with setpref) on a UID,

when you change the expiration date on your primary key or any of its subkey, or
when you revoke or generate a revocation certificate for the complete key.
(Because each of these operation is done by adding a new self- or revocation signatures from the private primary key.)

Since each link of the Web of Trust is an endorsement of the binding between a public key and a user ID, OpenPGP certification signatures (from the signer's private primary key) are relative to a UID and are irrelevant for subkeys. In particular, subkey creation or revocation does not affect the reputation of the primary key. So in case your subkey gets stolen while your primary key remains safe, you can revoke the compromised subkey and replace it with a new subkey without having to rebuild your reputation and without reducing reputation of other people's keys signed with your primary key.

How?
Unfortunately, GnuPG's user interface is not entirely fun to use. We'll take you through the necessary steps below.

How?
Unfortunately, GnuPG's user interface is not entirely fun to use. We'll take you through the necessary steps below.

These instructions assume you use one computer, and keep the primary keys on an encrypted USB flash drive, or preferably at least two (you should keep backups of your secret keys). We also assume you already have a key; if not, see http://keyring.debian.org/creating-key.html for instructions.

Make backups of your existing GnuPG files ($HOME/.gnupg). Keep them safe. If something goes wrong during the following steps, you may need this to return to a known good place.

umask 077; tar -cf $HOME/gnupg-backup.tar -C $HOME .gnupg

(note: umask 077 will result in restrictive permissions for the backup.)
Create a new subkey for signing.
Find your key ID: gpg --list-keys yourname

gpg --edit-key YOURPRIMARYKEYID

At the gpg> prompt: addkey

This asks for your passphrase, type it in.
Choose the "RSA (sign only)" key type.
It would be wise to choose 4096 (or at least 2048) bit key size.
Choose an expiry date (you can rotate your subkeys more frequently than the primary keys, or keep them for the life of the primary key, with no expiry).
Julian calendars can help calculate the exact number of days to a target calendar date

date +%j # command line to display current Julian date

date -d 2021-05-16 +%j # command to display specific Julian date

GnuPG will (eventually) create a key, but you may have to wait for it to get enough entropy to do so.
Save the key: save