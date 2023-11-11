https://www.cyberciti.biz/faq/ubuntu-change-hostname-command/
Ubuntu Linux Change Hostname Using hostnamectl
Systemd based Linux distro such as Ubuntu Linux 16.04 LTS and above can simply use the hostnamectl command to change hostname. To see current setting just type the following command:
$ hostnamectl

Sample outputs:

   Static hostname: nixcraft
         Icon name: computer-laptop
           Chassis: laptop
        Machine ID: 291893e6499e4d99891c3cf4b70a138b
           Boot ID: 9fda2365b77841649e40a141fde46537
  Operating System: Ubuntu 17.10
            Kernel: Linux 4.13.0-21-generic
      Architecture: x86-64
To change hostname from nixcraft to viveks-laptop, enter:
hostnamectl set-hostname alb-ubu
hostnamectl