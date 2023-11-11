https://hub.docker.com/r/willhallonline/ansible
I installed this in the reports dev container using conda.

https://hub.docker.com/r/ansible/ansible

https://www.linode.com/docs/guides/getting-started-with-ansible/

How-to-install-and-configure-ansible-on-ubuntu-20-04

pushd ~/src/conda-env
conda create -f env-ansible.yml
conda activate ansible

sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
