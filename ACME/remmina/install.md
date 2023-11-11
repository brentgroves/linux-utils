https://www.how2shout.com/linux/4-ways-to-install-remmina-on-ubuntu-22-04-lts-jammy-jellyfish/
https://devanswe.rs/how-to-fix-authentication-is-required-to-create-a-color-profile-managed-device-on-ubuntu-20-04-20-10/
https://devanswe.rs/how-to-fix-authentication-is-required-to-create-a-color-profile-managed-device-on-ubuntu-20-04-20-10/
sudo nvim /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes

sudo add-apt-repository ppa:remmina-ppa-team/remmina-next

sudo apt update

sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice

Run Remmina on Ubuntu 22.04

We can access the remote desktop using Remmina. Go to Application launcher and search for it. As you see the app icon, click to run the same.

https://askubuntu.com/questions/420986/copy-or-export-remmina-remote-desktop-files-to-another-ubuntu-install

cd ~/src
git clone git@github.com:brentgroves/remmina.git
cd remmina
rm ~/.local/share/remmina/*
mkdir -p ~/.local/share/remmina
cp * ~/.local/share/remmina
cp *.remmina ~/.local/share/remmina  
Thank you Father for this work.
You may have to reenter the password

to update github repo:
cd ~/src/remmina
rm *
cp ~/.local/share/remmina/* .
