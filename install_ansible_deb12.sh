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
pip3 --break-system-packages install ansible 
pip3 --break-system-packages install ansible-lint
pip3 --break-system-packages install ansible-runner
pip3 --break-system-packages install ansible-builder
pip3 --break-system-packages install netmiko
pip3 --break-system-packages install netaddr
pip3 --break-system-packages install argcomplete
activate-global-python-argcomplete
pip3 --break-system-packages install  cryptography --upgrade  
pip3 --break-system-packages install  pywinrm 
pip3 --break-system-packages install  pywinrm[credssp] 
pip3 --break-system-packages install  pywinrm[kerberos] 
pip3 --break-system-packages install  molecule[ansible,docker,lint] 
pip3 --break-system-packages install  docker 
pip3 --break-system-packages install  ansible-navigator[ansible-core]
pip3 --break-system-packages install  --upgrade   git+https://github.com/networkop/docker-topo.git
ansible-galaxy collection install arista.eos
ansible-galaxy collection install community.general
docker pull registry.iutbeziers.fr/ceosimage:4.25.0F
docker pull registry.iutbeziers.fr/debian11:ssh 
docker pull registry.iutbeziers.fr/rocky8:ssh
