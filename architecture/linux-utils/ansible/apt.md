https://adamtheautomator.com/ansible-apt/
https://docs.ansible.com/ansible/2.3/apt_module.html
# use apt module to install the latest version of vim
ansible all -m apt -a "name=vim state=latest" -u root

# --become to run as sudo
ansible reports12 -m apt -a "name=elinks state=present" -K -b
elinks google.com

Thank you, Father, for giving us this good work today!
