# install ssh server

<https://linuxhint.com/enable-use-ssh-ubuntu/>

```bash
# check if its installed
sudo systemctl status ssh

sudo apt install openssh-server -y
sudo systemctl status ssh

# copy clients public key to remote hosts ~/.ssh/authorized_keys file
# https://www.simplified.guide/ssh/copy-public-key

# Add your SSH public key to remote server user's authorized_keys file using ssh-copy-id command.
ssh-copy-id cstangland@reports11
ssh-copy-id cstangland@reports12
ssh-copy-id cstangland@reports13
```
