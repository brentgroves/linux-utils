# Topics

- Install Microk8s.
- Install S3 Compatible Object Storage.
- K8s Training Cluster and devcon2 access to all report system meeting members.
- SSH access to K8s nodes.
- Regular package updates with Ansible or tmux.
- What snap channel should be used when installing MicroK8s?
- Install kubectl and cluster contexts.
- How to reboot Kubernetes.

## Install Microk8s

**[Microk8s Installation](../../../reports/k8s/microk8s_1.28_install.md)**

## What is Mayastor

A dynamic storage provider managed entirely with k8s which uses the hugepages and nvme instruction set found in AMD/I64 cpu.

Postgres does work with on a k8s node with hugepages enabled so **[disable hubepages](../../../reports/k8s/mayastor-install-2.0.0.md)** for now.

## What is a virtual disk

It is a file that is treated as a disk.  Ceph Storage uses virtual disks to provide dynamic storage.

## What is Ceph Storage

**[What is Ceph Storage](https://en.wikipedia.org/wiki/Ceph_(software))**

Ceph is a free and open-source software-defined storage platform that provides object storage, block storage, and file storage built on a common distributed cluster foundation.

Why do we need it? To install Minio S3 compatible Cloud Object Storage which will be used to store report excel files.

**[Ceph Storage](../../ceph-storage/microk8s-ceph-storage.md)**

## What is MicroCeph

MicroCeph is a lightweight way of deploying a Ceph cluster with a focus on reduced ops. It is distributed as a snap and thus it gets deployed with:

## S3 Compatible Coud Object Storage

**[S3](https://aws.amazon.com/s3/)**

Amazon S3 or Amazon Simple Storage Service is a service offered by Amazon Web Services that provides object storage through a web service interface.

What ca we use it for? Backing up postgres databases.
Can we have in-house S3 storage? Yes.
What is Minio?
**[Minio](https://en.wikipedia.org/wiki/MinIO)**
"
MinIO is a High-Performance Object Storage released under GNU Affero General Public License v3.0. It is API compatible with the Amazon S3 cloud storage service. It can handle unstructured data such as photos, videos, log files, backups, and container images with a current maximum supported object size of 50TB.
"
How to setup Minio?
**[Minio Setup](https://thedatabaseme.de/2022/03/20/i-do-it-on-my-own-then-self-hosted-s3-object-storage-with-minio-and-docker/)**
"
"
How to backup Postgres database to S3 bucket?
**[Postgres S3 clone](https://thedatabaseme.de/2022/03/26/backup-to-s3-configure-zalando-postgres-operator-backup-with-wal-g/)**

## Our Minio server

Spun up a server for testing purposes

<http://reports-alb:9001>
admin/supersecret

<https://min.io/docs/minio/linux/reference/minio-mc.html?ref=docs-redirect>

```bash
cd ~/Downloads
mc ls minio minio/test-bucket/
mc cp minio/test-bucket/TB-202209_to_202309_on_10-24_DM_GP.xlsx ~/data/
```

## K8s Training Cluster

### Access devcon2 and K8s Training Cluster

If you wish to use devcon2 to access the K8s Training cluster you can log in using rdp or ssh.  The **[meeting notes](~/src/linux-utils/status/report_system/week43.md)** can be viewed by logging into devcon2 and running vscode which has a markdown viewer.  Typing ~/startday.sh ensures you get a fresh copy of all our git repositories.  If you change any of the files please make your changes to a different branch.

user: bcieslik
user: bcook
user: sjackson
user: jdavis
user: kyoung
Initial password for all: k8sAdmin1!

FYI: Thanks to Brendan these IP addresses are in our DNS.

```hosts
10.1.0.110      reports11
10.1.0.111      reports12
10.1.0.112      reports13
10.1.0.120      devcon2
```

- devcon2 already has these entries in /etc/hosts file.
- On Windows to change hosts file you must open a command prompt as administrator and type notepad c:\Windows\System32\Drivers\etc\hosts then add the above host entries but Brendan has added the A records to our DNS so you should not have to add them to test go to the command prompt and type:

```bash
ping reports11
ping devcon2
```

## Create a new user with sudo priviliges

**[Setup admin user account](https://jumpcloud.com/blog/how-to-create-a-new-sudo-user-manage-sudo-access-on-ubuntu-20-04)**

### Create user

```bash
sudo adduser bcook 
Adding user newuser' ... Adding new group newuser' (1001) ...
Adding new user newuser' (1001) with group newuser' ...
Creating home directory /home/newuser' ... Copying files from /etc/skel' ...

At the prompt, enter the password for the new user twice to set and verify it.

New password: ******
Retype new password: ******
passwd: password updated successfully

# verify user with id
id bcook
uid=1002(bcook) gid=1002(bcook) groups=1002(bcook)
```

### Grant root permissions for a new or existing user

Add admin users to sudo group.

```bash

bcieslik@devcon2:~# sudo usermod -aG sudo bcook # add user to sudo group
bcieslik@devcon2:~# id bcook # verify user was added to sudo group
uid=1002(bcook) gid=1002(bcook) groups=1002(bcook),27(sudo)
bcieslik@devcon2:~#
```

## K8s node SSH server setup

**[SSH Setup](https://linuxhint.com/enable-use-ssh-ubuntu/)**

```bash
sudo apt install openssh-server -y
sudo systemctl status ssh
ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2023-10-26 17:22:44 EDT; 2h 57min left
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 549 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 591 (sshd)
      Tasks: 1 (limit: 37467)
     Memory: 5.9M
        CPU: 121ms
     CGroup: /system.slice/ssh.service
             └─591 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"

Oct 26 17:22:43 devcon2.busche-cnc.com systemd[1]: Starting OpenBSD Secure Shell server...
Oct 26 17:22:44 devcon2.busche-cnc.com sshd[591]: Server listening on 0.0.0.0 port 22.
Oct 26 17:22:44 devcon2.busche-cnc.com sshd[591]: Server listening on :: port 22.
Oct 26 17:22:44 devcon2.busche-cnc.com systemd[1]: Started OpenBSD Secure Shell server.
Oct 26 14:24:49 devcon2.busche-cnc.com sshd[1440]: Accepted password for bcieslik from 10.1.0.113 port 58486 ssh2
Oct 26 14:24:49 devcon2.busche-cnc.com sshd[1440]: pam_unix(sshd:session): session opened for user bcieslik(uid=1001) by (uid=0)
(
```

### Development System SSH client setup

To enable passwordless login to K8s nodes use an encryption key pair.

note: I did this already for report system team on devcon2 @ 10.1.0.120.

```bash
# rdp or ssh into the development system as the user.
ssh bcook@devcon2
# Generate the ssh key with the ed25519 algorithm and accept the defaults 
bcook@devcon2:~$ ssh-keygen -t ed25519 -C bcook@mobexglobal.com 

# start the ssh-agent if not already started
# We don't normally need to stop and start the ssh-agent on Ubuntu 22.04 desktop but on Ubuntu 22.04 server you may need to
bcook@devcon2:~$ eval "$(ssh-agent -s)"
Agent pid 2443

# Add the SSH private key to the SSH-agent 
bcook@devcon2:~$ ssh-add ~/.ssh/id_ed25519 
Identity added: /home/bcook/.ssh/id_ed25519 (bcook@mobexglobal.com)

# To list ssh-keys that have been added: 
bcook@devcon2:~$ ssh-add -L
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILrLD//7Ui7/MZHHyg+3EGl2wc1HwXZiLprsXqUh5ubF bcook@mobexglobal.com

# Add the SSH public key to each remote K8s node user's authorized_keys file using ssh-copy-id command.
ssh-copy-id bcook@reports11
ssh-copy-id bcook@reports12
ssh-copy-id bcook@reports13
```

## Package update options

We need a way to update the K8s nodes with the latest package updates at least weekly.

1. Ansible automation.
2. tmux.

**[Ansible Setup](https://www.linode.com/docs/guides/getting-started-with-ansible/)**

Ansible is a one way to automate the Linux package update process.  You first create a file of ip addresses or host names that is grouped if you like. Then you put some commands to update OS packages in a file and run ansible.

## Ansible play-book notes

```bash
ssh jdavis@devcon2
pushd ~/src/reports/volume/ansible/playbooks
# copy a file
cd ~/src/reports/volume/ansible/playbooks

ansible reports11 -m ansible.builtin.copy -a "src=./test.yml dest=/tmp/test.yaml"
ansible-playbook upgrade.yml -i inventory.yaml -b --ask-become-pass
ansible-playbook reboot-reports11-jdavis.yml -i inventory.yaml -b --ask-become-pass
```

TMUX splits your screen up into sections then each section there is a command prompt for you to ssh into one node.  So you will be looking at all nodes at once.  You then press the key combo to output to all sections of the TMUX screen.  Finally type the commands that you want to run on all 4 nodes.

```bash
# tmux commands
# start
tmux
# end
Ctrl-a is the prefix
type the prefix before any command
:kill-server // to end session
# split screen
ctrl + a + % to make a vertical split. ctrl + a + " to make a Horizontal split. ctrl + a + left arrow to move to the left pane.
```

```bash
# send command to all panes
ctrl + e
## stop sending commands to all panes
ctrl + E
```

## What snap channel should be used when installing MicroK8s?

IMO it is best to use channel 1.28 because it has better storage drivers and the observability add-on.

### Check snap channel

snap info microk8s

## Kubernetes Reboot Daemon

After package updates a reboot is sometimes required. So how do you reboot K8s nodes safely?

**[Install and test Kured](https://www.youtube.com/watch?v=t2vwuSHmInk)**

```bash
scc.sh reports1.yaml microk8s
kubectl get pods -n kube-system -owide | grep kured
kubectl edit daemonset kured -n kube-system
- command
  - /usr/bin/kured
  - --period=0h0m30s

# check if pods came up after change
kubectl get pods -n kube-system -owide | grep kured

# watch the nodes
kubectl get nodes -w

# Or look at the logs to see the reboot
kubectl logs -f kured-gpf2w -n kube-system

# Check MySQL InnoDB Cluster
kubectl get pods -n default -owide 
```

## Install kubectl and cluster contexts

```bash
sudo snap install kubectl  --classic
```

## generate microk8s config from k8s node

```bash
ssh brent@reports11
cd ~
mkdir .kube
cd .kube
microk8s config > config
```

## How to reboot kubernetes

**[Kubernetes Reboot Daemon](https://kured.dev/docs/)**
"
Watches for the presence of a reboot sentinel file e.g. /var/run/reboot-required or the successful run of a sentinel command.
Cordons & drains worker nodes before reboot, uncordoning them after.
Utilises a lock in the API server to ensure only one node reboots at a time.
Optionally defers reboots in the presence of active Prometheus alerts or selected pods.
"

## Install Kured

**[Install Kured](https://kured.dev/docs/installation/)**

"
Installation
To obtain a default installation without Prometheus alerting interlock or Slack notifications:

```bash
scc.sh reports1.yaml microk8s
sudo apt  install jq
latest=$(curl -s https://api.github.com/repos/kubereboot/kured/releases | jq -r '.[0].tag_name')
kubectl apply -f "https://github.com/kubereboot/kured/releases/download/$latest/kured-$latest-dockerhub.yaml"
clusterrole.rbac.authorization.k8s.io/kured created
clusterrolebinding.rbac.authorization.k8s.io/kured created
role.rbac.authorization.k8s.io/kured created
rolebinding.rbac.authorization.k8s.io/kured created
serviceaccount/kured created
daemonset.apps/kured created
```

**[Install and test Kured](https://www.youtube.com/watch?v=t2vwuSHmInk)**

```bash
# Verify installation
kubectl get pods -n kube-system -owide | grep kured

# Change this for test purposes to 30
kubectl edit daemonset kured -n kube-system
- command
  - /usr/bin/kured
  - --period=0h0m30s

# check if pods came up after change
kubectl get pods -n kube-system -owide | grep kured

# You can test your configuration by provoking a reboot on a node:
ssh brent@reports11
sudo touch /var/run/reboot-required

# watch the nodes to detect reboot
kubectl get nodes -w

# Or look at the logs to see the reboot
kubectl logs -f kured-gpf2w -n kube-system

```
