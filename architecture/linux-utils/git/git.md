# Install git

<https://linuxhint.com/install-git-ubuntu22-04/>

```bash
# Step 1: Update the system
# Before installing Git make sure your system is up to date. To verify this use the following commands.

sudo apt update -yq | sudo apt upgrade -yq
sudo apt install git
git --version

# Step 1: Provide a username
# Use the command given below to provide a username
# Pick only one user.name, user.email
git config --global user.name "cstangland"
git config --global user.name "bcieslik"
git config --global user.name "bcook"
git config --global user.name "sjackson"
git config --global user.name "jdavis"
git config --global user.name "kyoung"
git config --global user.name "brentgroves"

# Step 2: Provide an email address
# The email address is provided using this command.

git config --global user.email "cstangland@mobexglobal.com"
git config --global user.email "bcieslik@mobexglobal.com"
git config --global user.email "bcook@mobexglobal.com"
git config --global user.email "sjackson@mobexglobal.com"
git config --global user.email "jdavis@mobexglobal.com"
git config --global user.email "kyoung@mobexglobal.com"
git config --global user.email "brent.groves@gmail.com"
git config --global core.editor "nano"

cp *.sh ~/

```

## **[Setup user for SSH access to use Azure Dev Ops](./ssh-azure.md)**

## **[Setup user for SSH access to use GitHub](./ssh-github.md)**
