https://vault.bitwarden.com/#/login
Set up gpg and pass on reports-avi and 
generated a new gpg key, see gpg.md, using fingerprint brent.groves@gmail.com
then exported this key pair to *.asc files
Then installed and initialized pass and git using brent.groves@gmail.com as its figerprint.
Then added the MobexCloudPlatform/pass as a remote orig, see new-host.md.
Then installed the instructions at new-host.md to setup new-host with pass Azure MobexCloudPlatform/pass repo.

https://www.passwordstore.org/
https://medium.com/@chasinglogic/the-definitive-guide-to-password-store-c337a8f023a1
https://github.com/docker/docker-credential-helpers

https://geoffhudik.com/tech/2020/09/15/docker-pass-credential-helper-on-ubuntu/
sudo apt-get -y install gnupg2 pass rng-tools jq 

sudo apt-get install pass
pass init "Mobex Password Storage Key"

https://github.com/docker/docker-credential-helpers
https://stackoverflow.com/questions/75055585/docker-error-message-denied-requested-access-to-the-resource-is-denied
download pass binary
cd ~/Downloads
sudo install -m755 ./docker-credential-pass-v0.7.0.linux-amd64 /usr/local/bin/docker-credential-pass

With the Docker Engine
Set the credsStore option in your ~/.docker/config.json file with the suffix of the program you want to use. For instance, set it to osxkeychain if you want to use docker-credential-osxkeychain.

{
  "credsStore": "pass",
}
pass store {
  "ServerURL": "https://index.docker.io/v1",
  "Username": "brentgroves",
  "Secret": "JesusLives1!"
}

{

  "credsStore": "docker-credential-pass",
	"auths": {
		"https://index.docker.io/v1/": {
			"auth": "YnJlbnRncm92ZXM6SmVzdXNMaXZlczEh"
		}
	}
}

If you are currently logged in, run docker logout to remove the credentials from the file and run docker login again.
Removing login credentials for https://index.docker.io/v1/
docker-credential-pass list
Using the password store
We can list all the existing passwords in the store:

zx2c4@laptop ~ $ pass

And we can show passwords too:

zx2c4@laptop ~ $ pass Email/zx2c4.com

Or copy them to the clipboard:

zx2c4@laptop ~ $ pass -c Email/zx2c4.com

There will be a nice password input dialog using the standard gpg-agent (which can be configured to stay authenticated for several minutes), since all passwords are encrypted.

We can add existing passwords to the store with insert:

zx2c4@laptop ~ $ pass insert Business/cheese-whiz-factory
Enter password for Business/cheese-whiz-factory: omg so much cheese what am i gonna do

This also handles multiline passwords or other data with --multiline or -m, and passwords can be edited in your default text editor using pass edit pass-name.

The utility can generate new passwords using /dev/urandom internally:

zx2c4@laptop ~ $ pass generate Email/jasondonenfeld.com 15
The generated password to Email/jasondonenfeld.com is:
$(-QF&Q=IN2nFBx

Setting it up
To begin, there is a single command to initialize the password store:

zx2c4@laptop ~ $ pass init "ZX2C4 Password Storage Key"

We can additionally initialize the password store as a git repository:

zx2c4@laptop ~ $ pass git init
Initialized empty Git repository in /home/zx2c4/.password-store/.git/
zx2c4@laptop ~ $ pass git remote add origin kexec.com:pass-store
If a git repository is initialized, pass creates a git commit each time the password store is manipulated.