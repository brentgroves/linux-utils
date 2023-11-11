https://stackoverflow.com/questions/48833451/no-protocol-specified-when-running-a-sudo-su-app-on-ubuntu-linux

Newer systems by design don't allow graphical applications as root (it's a Wayland thing). Workaround:

xhost si:localuser:root

sudo   your-graphical-app
Restore the default permissions:

xhost -si:localuser:root