# Play book notes

```bash
pushd /workspaces/reports/volume/ansible
pushd ~/src/reports/volume/ansible/playbooks
ansible-playbook upgrade.yml -i inventory.yaml -b --ask-become-pass
ansible-playbook reboot.yml -i inventory.yaml -b --ask-become-pass

ansible-playbook test.yml -i inventory.yaml -b --ask-become-pass
export ANSIBLE_PASSWORD="not revealed"
ansible-playbook test.yml -i inventory.yaml -b -e ansible_become_password='{{ lookup("env", "ANSIBLE_PASSWORD") }}'

ansible all -i hosts -m ansible.builtin.copy -a "src=./hosts dest=/tmp/hosts"

ansible-playbook test.yml -b --ask-become-pass


export ANSIBLE_PASSWORD="not revealed"

  -e does not work
  -e ansible_become_password='{{ lookup("env", "$ANSIBLE_PASSWORD") }}'
  Examples
- name: Unconditionally reboot the machine with all defaults
  ansible.builtin.reboot:

- name: Reboot a slow machine that might have lots of updates to apply
  ansible.builtin.reboot:
    reboot_timeout: 3600

- name: Reboot a machine with shutdown command in unusual place
  ansible.builtin.reboot:
    search_paths:
     - '/lib/molly-guard'

- name: Reboot machine using a custom reboot command
  ansible.builtin.reboot:
    reboot_command: launchctl reboot userspace
    boot_time_command: uptime | cut -d ' ' -f 5

```
