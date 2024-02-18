#!/bin/bash
apt-get -y install jupyter python3-virtualenv python3-setuptools build-essential libssl-dev libffi-dev python3-dev libkrb5-dev sshpass  yamllint 
if [ ! -d /etc/ansible ]
then
    mkdir /etc/ansible
    mkdir /etc/ansible/group_vars
    mkdir /etc/ansible/roles
    sudo cp /home/ansible/group_vars/*  /etc/ansible/group_vars/
    sudo cp /home/ansible/ansible.cfg /etc/ansible/ansible.cfg
    sudo cp /home/ansible/hosts /etc/ansible/hosts
fi
pipx install ansible 
pipx install ansible-lint
pipx install ansible-runner
pipx install ansible-builder
pipx install netmiko
pipx install netaddr
pipx install argcomplete
activate-global-python-argcomplete
pipx install  cryptography --upgrade  
pipx install  pywinrm 
pipx install  pywinrm[credssp] 
pipx install  pywinrm[kerberos] 
pipx install  molecule[ansible,docker,lint] 
pipx install  docker 
pipx install  ansible-navigator[ansible-core]
pipx install  --upgrade   git+https://github.com/networkop/docker-topo.git
ansible-galaxy collection install arista.eos
ansible-galaxy collection install community.general
docker pull registry.iutbeziers.fr/ceosimage:4.25.0F
docker pull registry.iutbeziers.fr/debian11:ssh 
docker pull registry.iutbeziers.fr/rocky8:ssh
