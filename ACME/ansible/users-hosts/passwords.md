https://medium.com/opsops/how-to-pass-password-to-ansible-from-environment-variable-bd5c566bc8a1

There is an idea that passing secrets via environment variables is more safe, than passing it via command line.

Ansible has few methods to accept password:

Store it somewhere in the file (inventory, secrets, group vars, etc).
Use a ssh key from ssh agent. Which eliminates passwords, actually, and is a preferable way for Ansible to work. (its not a method to get a password, so this one does not count).
Use a separate private ssh key from filesystem (--private-key option), which is not that better than having password in the inventory. (again, not a password, does not count).
Get it from a terminal from a user. askpass is more tricky than you may think, and simple echo $PASS | ansible won’t work in most cases.
Pass them as -e ansible_password=revealed in command line.
As you can see, non of them includes simple ANSIBLE_PASSWORD environment variable. But, with Jinja, it’s not a problem.

Solution: How to use environment variable for passwords for Ansible
export ANSIBLE_PASSWORD="not revealed"
ansible-playbook \
  -i inventory.yaml \
  play.yaml \
  -e ansible_password='{{ lookup("env", "ANSIBLE_PASSWORD") }}'
That’s it. Basically, we are passing Jinja2 expression as a password, and that expression is using ‘env’ lookup plugin to see content of the ANSIBLE_PASSWORD environment variable.

