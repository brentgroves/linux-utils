# Create user with sudo privileges

<https://docs.rackspace.com/docs/create-a-sudo-user-in-ubuntu>

This article describes how to grant sudo access to a new or existing user on the Ubuntu® operating system.

Create a new user
Use adduser command followed by the new <username>:

```bash
# check existing sudo users
grep '^sudo:.*$' /etc/group | cut -d: -f4
brent,bcook,sjackson,bcieslik,kyoung,jdavis,cstangland

sudo adduser bcieslik // "Brendan Cieslik" 248-208-5446 bcieslik@mobexglobal.com
Adding user newuser' ... Adding new group newuser' (1001) ...
Adding new user newuser' (1001) with group newuser' ...
Creating home directory /home/newuser' ... Copying files from /etc/skel' ...

At the prompt, enter the password for the new user twice to set and verify it.

New password: k8sAdmin1!
Retype new password: k8sAdmin1!
passwd: password updated successfully

# Use the usermod command to add the user to the sudo group:
brent,bcook,sjackson,bcieslik,kyoung,jdavis,cstangland
sudo usermod -aG sudo cstangland

# Verify the permission change
# Use su followed by the <username> to switch to the new user account:

su - bcieslik

# Use sudo -i to verify that the user account can elevate permissions.
# At the prompt, enter the new user's password:

sudo -i
[sudo] password for newuser:
root@reports11:~#

```

- Add to **[azure git repos](../git/ssh-azure.md)**

- Add to **[GitHub repos](../git/ssh-github.md)**

- Install **[dotfiles](../dotfiles/install-dotfiles.md)**

- Add your SSH public key to any remote server user's authorized_keys file using ssh-copy-id command

```bash
ssh-copy-id bcieslik@reports11
ssh-copy-id bcook@reports11
ssh-copy-id sjackson@reports11
ssh-copy-id cstangland@reports11
ssh-copy-id jdavis@reports11
ssh-copy-id kyoung@reports11
ssh-copy-id brent@reports11
```
