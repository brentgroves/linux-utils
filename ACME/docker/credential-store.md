https://docs.docker.com/engine/reference/commandline/login/#credentials-store


Credentials store
The Docker Engine can keep user credentials in an external credentials store, such as the native keychain of the operating system. Using an external store is more secure than storing credentials in the Docker configuration file.

To use a credentials store, you need an external helper program to interact with a specific keychain or external store. Docker requires the helper program to be in the client’s host $PATH.

This is the list of currently available credentials helpers and where you can download them from:

D-Bus Secret Service: https://github.com/docker/docker-credential-helpers/releases
Apple macOS keychain: https://github.com/docker/docker-credential-helpers/releases
Microsoft Windows Credential Manager: https://github.com/docker/docker-credential-helpers/releases
pass: https://github.com/docker/docker-credential-helpers/releases

cd ~/Downloads
sudo install -m755 docker-credential-pass-v0.7.0.linux-amd64  /usr/local/bin/docker-credential-pass

sudo install -m755 docker-credential-pass  /usr/local/bin/docker-credential-pass

Configure the credentials store
You need to specify the credentials store in $HOME/.docker/config.json to tell the docker engine to use it. The value of the config property should be the suffix of the program to use (i.e. everything after docker-credential-). For example, to use docker-credential-pass:
nvim ~/.docker/config.json
{
	"auths": {},
  "credsStore": "pass"
}
docker login

nvim ~/.docker/config.json
{
	"auths": {
		"https://index.docker.io/v1/": {}
	},
	"credsStore": "pass"
}
