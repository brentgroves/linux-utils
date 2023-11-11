FREE Top 10 Best Practices of Ansible Automation: save time, reduce errors and stress - http://eepurl.com/hJv3j9

BUY the Complete PDF BOOK to easily Copy and Paste the 200+ Ansible code
200+ Automation Examples For Linux and Windows System Administrator and DevOps
https://leanpub.com/ansiblebyexamples

my VIDEO COURSE: Ansible by Examples
200+ Automation Examples For Linux and Windows System Administrator and DevOps
https://www.udemy.com/course/ansible-...

# works
ansible-playbook elinks.yml -K -b

ansible reports0 -m apt -a "name=elinks state=latest" -b --extra-vars 'ansible_become_pass=JesusLives1!'

ansible-playbook elinks.yml -b --extra-vars 'ansible_become_pass=JesusLives1!'

ansible-playbook upgrade.yml -b --extra-vars 'ansible_become_pass=JesusLives1!'


sudo apt install ansible

Step 2 — Setting Up the Inventory File
The inventory file contains information about the hosts you’ll manage with Ansible. You can include anywhere from one to several hundred servers in your inventory file, and hosts can be organized into groups and subgroups. The inventory file is also often used to set variables that will be valid only for specific hosts or groups, in order to be used within playbooks and templates. Some variables can also affect the way a playbook is run, like the ansible_python_interpreter variable that we’ll see in a moment.

To edit the contents of your default Ansible inventory, open the /etc/ansible/hosts file using your text editor of choice, on your Ansible control node:

sudo nvim /etc/ansible/hosts

# check your inventory
ansible-inventory --list -y

# test connectivity
https://www.simplified.guide/ssh/copy-public-key
Add your SSH public key to remote server user's authorized_keys file using ssh-copy-id command.
ssh-copy-id brent@reports11
ssh-copy-id brent@reports12
ssh-copy-id brent@reports13

The pattern for ad hoc commands looks like this:
ansible [host-pattern] -m [module] -a “[module options]”
host-pattern: the managed hosts to run against
-m: the module to run
-a: the list of arguments required by the module

# copy a file
ansible all -i hosts -m ansible.builtin.copy -a "src=./hosts dest=/tmp/hosts"
ansible all -i hosts --limit reports12 -a "/bin/echo hello"


Step 4 — Running Ad-Hoc Commands (Optional)
After confirming that your Ansible control node is able to communicate with your hosts, you can start running ad-hoc commands and playbooks on your servers.

Any command that you would normally execute on a remote server over SSH can be run with Ansible on the servers specified in your inventory file. As an example, you can check disk usage on all servers with:

ansible all -a "df -h" -u brent
ansible reports1 -m ping -u brent

ansible reports1 -a "uptime" -u brent

https://adamtheautomator.com/ansible-apt/
https://docs.ansible.com/ansible/2.3/apt_module.html
# use apt module to install the latest version of vim
ansible all -m apt -a "name=vim state=latest" -u root

# --become to run as sudo
ansible reports12 -m apt -a "name=elinks state=present" -K -b
elinks google.com

Thank you, Father, for giving us this good work today!

https://www.digitalocean.com/community/cheatsheets/how-to-use-ansible-cheat-sheet-guide

https://www.sysadmintutorials.com/tag/ansible/https://www.sysadmintutorials.com/tag/ansible/

https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html#ansible-playbook


Thank you Father for showing me how to use ansible!!!
# This has some advanced feature
https://www.sysadmintutorials.com/ansible-username-password-prompt-with-vars_prompt/
