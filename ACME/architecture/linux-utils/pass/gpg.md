https://medium.com/@chasinglogic/the-definitive-guide-to-password-store-c337a8f023a1

sudo apt install gnupg2
Step 1. Setting up gpg
So first things first we need to generate a gpg key:
gpg2 --full-gen-key

gpg: key ECC27BA70C24BB41 marked as ultimately trusted
gpg: directory '/home/brent/.gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as '/home/brent/.gnupg/openpgp-revocs.d/039036C4E9FA2ADAE1BE94C6ECC27BA70C24BB41.rev'
public and secret key created and signed.
pub   rsa4096 2023-03-01 [SC]
      039036C4E9FA2ADAE1BE94C6ECC27BA70C24BB41
uid                      Brent Groves <brent.groves@gmail.com>
sub   rsa4096 2023-03-01 [E]

# backup keypair
gpg --export-secret-keys --armor brent.groves@gmail.com > privkey.asc
gpg --export --armor brent.groves@gmail.com > pubkey.asc


Step 2. Set up pass
Now that we have a public and private key to encrypt and decrypt with we can set up our password store. First run:

pass init brent.groves@gmail.com

Next let’s set up git:
pass git init

Now we can add our first password, let’s create a test password:
pass generate test 10
The way generate works is that pass takes first the name of the password (often the domain name such as google.com) and then the length of password you want it to generate. 


list password:
pass

Retrieving a password
If you want to see the password simply tell pass which one you want and enter your master password when prompted:
pass test

If you would like it copied to your clipboard automatically you can use the -c flag
pass -c test

All pass is doing here is storing the generated file in an encrypted plain text file in a folder located at $HOME/.password-store

Since we no longer need our test password lets get rid of it:
pass rm test

If you want to sync to another device you just need to copy the $HOME/.password-storeand $HOME/.gnupg to the target machine, however there is a much better method that allows you to sync continuously without using dropbox or a flash drive but requires a little more setup work up front which I will go over below.

Step 3. Git
First things first, you’ll need a server that has a publically accessible IP address and that you have ssh access to. I recommend using DigitalOcean as it’s probably the easiest way to get up and running.

pass git remote add origin git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/pass


git push -u origin --all


You can then start pushing to and pulling from the remote using pass git push origin master and pass git pull origin master respectively. Pass will take care of the rest of the git commands for you, but again if you ever get stuck you can either watch my talk or try Github’s excellent interactive tutorial to learn more about git.

pass git add -A
pass git push origin master

pass git pull origin master


