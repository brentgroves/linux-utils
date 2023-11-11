# Setup authorization to github

Note: You must have admin permission to GitHub repos to do this.

```bash
# We don't normally need to stop and start the ssh-agent on Ubuntu 22.04 desktop but we do on Ubuntu 22.04 server.

eval "$(ssh-agent -k)"

# To list ssh-keys that have been added: ssh-add -L

# <https://docs.github.com/en/authentication/connecting-to-github-with-ssh>

# Generate the ssh key for one user only with the ed25519 algorithm accept defaults with no passcode
ssh-keygen -t ed25519 -C "cstangland@mobexglobal.com"
ssh-keygen -t ed25519 -C "bcook@mobexglobal.com"
ssh-keygen -t ed25519 -C "jdavis@mobexglobal.com"
ssh-keygen -t ed25519 -C "bcieslik@mobexglobal.com"
ssh-keygen -t ed25519 -C "sjackson@mobexglobal.com"
ssh-keygen -t ed25519 -C "kyoung@mobexglobal.com"
ssh-keygen -t ed25519 -C brent.groves@gmail.com 

# Add the SSH private key to the SSH-agent 

ssh-add ~/.ssh/id_ed25519 

# Add the SSH key to your GitHub account. 

# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account 

# Copy the SSH public key to your clipboard. 

# If your SSH public key file has a different name than the example code, modify the filename to match your current setup. When copying your key, don't add any newlines or whitespace. 

# Tip: If pbcopy isn't working, you can locate the hidden .ssh folder, open the file in your favorite text editor, and copy it to your clipboard. 
# Copies the contents of the id_ed25519.pub file to your clipboard  
cat ~/.ssh/id_ed25519.pub 

# Connect to GitHub as Admin user for repos.
# In the upper-right corner of any page, click your profile photo, then click Settings. 
# In the "Access" section of the sidebar, click  
# SSH and GPG keys. 
# Click New SSH key or Add SSH key. SSH Key button 
# In the "Title" field, add a descriptive label for the new key. For example, if you're using a personal Mac, you might call this key "Personal MacBook Air". 
# Paste your key into the "Key" field. 
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection 

cd ~
git clone git@github.com:brentgroves/dotfiles.git


```
