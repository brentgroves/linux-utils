# Install Node version manager

- nvm (Node Version Manager) is a tool that allows you to download and install Node.js. Check if you have it installed via nvm --version.
- To install or update nvm, you should run the install script. To do that, you may either download and run the script manually, or use the following cURL or Wget command:

```bash
# https://stackoverflow.com/questions/67541374/nvm-getting-permission-denied-with-nvm-install-command
sudo snap remove curl
sudo apt install curl
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
# close and reopen termainal
nvm install --lts  
nvm --version

# Some sample commands to get you started
nvm alias default 18
nvm list
$ nvm use 16
Now using node v16.9.1 (npm v7.21.1)
$ node -v
v16.9.1
$ nvm use 14
Now using node v14.18.0 (npm v6.14.15)
$ node -v
v14.18.0
$ nvm install 12
Now using node v12.22.6 (npm v6.14.5)
$ node -v
v12.22.6
```
