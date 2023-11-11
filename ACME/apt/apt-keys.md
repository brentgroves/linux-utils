https://askubuntu.com/questions/131397/what-is-a-repository-key-under-ubuntu-and-how-do-they-work
What is a repository key under Ubuntu and how do they work?


Most of the time just adding a package repository allows you to download and install packages without a repository key. Also some repositories display their key beside their information so they're easy to find. But

Why do we need to add keys if we can install packages without them?
How do they work under Ubuntu?
https://www.2daygeek.com/how-to-list-and-remove-repository-gpg-key-in-ubuntu/

How Does the GPG key work on Repository?
All packages are signed with a pair of keys consisting of a private key and a public key, by the package maintainer.

A user’s private key is kept secret and the public key may be given to anyone the user wants to communicate.

Whenever you add a new repository to your system, you must also add a repository key so that the APT Package Manager trusts the newly added repository.

Once you’ve added the repository keys, you can make sure you get the packages from the correct source.

Listing Repository keys
‘apt-key’ is used to manage the list of keys used by ‘apt’ to authenticate packages. Trusted keys are stored in the following locations.

/etc/apt/trusted.gpg – Keyring of local trusted keys; new keys will be added here.
/etc/apt/trusted.gpg.d/ – File fragments for the trusted keys; additional keyrings can be stored here (by other packages or the administrator).

Use the following command to list trusted keys with fingerprints:
$ 

Removing Repository keys?
You can remove the repository key if it is no longer needed or if the repository has already been removed from the system.

It can be deleted by entering the full key with quotes as follows (which has a hex value of 40 characters):

$ sudo apt-key del "D320 D0C3 0B02 E64C 5B2B B274 3766 2239 8999 3A70"
OK
Alternatively, you can delete a key by entering only the last 8 characters:

$ sudo apt-key del 89993A70
OK
Once you have removed the repository key, run the apt command to refresh the repository index:

$ sudo apt update
You can verify that the above GPG key has been removed by running the following command:

$ sudo apt-key list
Wrapping Up
In this guide, we have shown you how to List and Remove a GPG Key in Ubuntu.

If you found this article helpful, please do share with your friends and spread the knowledge. Please feel free to comment below if you have any queries/concerns. We will get back to you as soon as we can. Happy learning!

