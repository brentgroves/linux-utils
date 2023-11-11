https://www.nakivo.com/blog/how-to-use-remote-desktop-connection-ubuntu-linux-walkthrough/ 
https://devanswe.rs/how-to-fix-authentication-is-required-to-create-a-color-profile-managed-device-on-ubuntu-20-04-20-10/
sudo nvim /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes

https://linuxize.com/post/how-to-install-xrdp-on-ubuntu-20-04/ 

sudo apt install xrdp  

sudo systemctl status xrdp 

sudo adduser xrdp ssl-cert 

sudo systemctl restart xrdp 

https://mangolassi.it/topic/25498/remote-access-to-ubuntu-23-04-lunar-lobster-with-kvm-child-process-has-exited-meshcentral-error