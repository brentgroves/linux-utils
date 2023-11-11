Step 4 — Running Ad-Hoc Commands (Optional)
After confirming that your Ansible control node is able to communicate with your hosts, you can start running ad-hoc commands and playbooks on your servers.

Any command that you would normally execute on a remote server over SSH can be run with Ansible on the servers specified in your inventory file. As an example, you can check disk usage on all servers with:

ansible all -a "df -h" -u brent
ansible reports1 -m ping -u brent

ansible reports1 -a "uptime" -u brent
