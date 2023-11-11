https://www.geeksforgeeks.org/at-command-in-linux-with-examples/
at command is a command-line utility that is used to schedule a command to be executed at a particular time in the future. Jobs created with at command are executed only once. The at command can be used to execute any program or mail at any time in the future. It executes commands at a particular time and accepts times of the form HH:MM to run a job at a specific time of day. The following expression like noon, midnight, teatime, tomorrow, next week, next Monday, etc. could be used with at command to schedule a job.

https://docs.ansible.com/ansible-tower/latest/html/userguide/scheduling.html

ansible.builtin.cron
https://www.youtube.com/watch?v=n26nk2nMTdU

ansible-playbook playbooks/cron/add-1.yml
ansible-playbook playbooks/cron/add-2.yml
crontab -l
sudo tail -f /var/log/syslog
cat /var/log/syslog | grep 'ansible-pilot'

sudo tail –n 4 -f /var/log/syslog

ansible-playbook playbooks/cron/remove-1.yml
crontab -l
ansible-playbook playbooks/cron/remove-2.yml
crontab -l