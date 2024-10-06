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
pip3 install --break-system-packages ansible 
pip3 install --break-system-packages ansible-lint
pip3 install --break-system-packages ansible-runner
pip3 install --break-system-packages ansible-builder
pip3 install --break-system-packages netmiko
pip3 install --break-system-packages netaddr
pip3 install --break-system-packages argcomplete
activate-global-python-argcomplete
pip3 install --break-system-packages  cryptography --upgrade  
pip3 install --break-system-packages  pywinrm 
pip3 install --break-system-packages  pywinrm[credssp] 
pip3 install --break-system-packages  pywinrm[kerberos] 
pip3 install --break-system-packages  molecule[ansible,docker,lint] 
pip3 install --break-system-packages  docker 
pip3 install --break-system-packages  ansible-navigator[ansible-core]
pip3 install --break-system-packages  ansible-pylibssh
ansible-galaxy collection install arista.eos
ansible-galaxy collection install nokia.srlinux
ansible-galaxy collection install community.general
docker pull registry.iutbeziers.fr/ceosimage:4.25.0F
docker tag registry.iutbeziers.fr/ceosimage:4.25.0F registry.iutbeziers.fr/ceosimage:latest
docker pull ghcr.io/nokia/srlinux
docker tag ghcr.io/nokia/srlinux ghcr.io/nokia/srlinux:latest
docker pull registry.iutbeziers.fr/debian12:ssh 
docker pull registry.iutbeziers.fr/rocky9:ssh
