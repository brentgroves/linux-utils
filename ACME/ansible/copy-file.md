# copy a file
ansible all -i hosts -m ansible.builtin.copy -a "src=./hosts dest=/tmp/hosts"
ansible all -i hosts --limit reports12 -a "/bin/echo hello"
