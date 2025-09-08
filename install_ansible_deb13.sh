#!/bin/bash
apt-get -y install pipx jupyter python3-virtualenv python3-setuptools build-essential libssl-dev libffi-dev python3-dev libkrb5-dev sshpass  yamllint 
export PATH="~/.local/bin:$PATH"
if [ ! -d /etc/ansible ]
then
    mkdir /etc/ansible
    mkdir /etc/ansible/group_vars
    mkdir /etc/ansible/roles
    sudo cp /home/ansible/group_vars/*  /etc/ansible/group_vars/
    sudo cp /home/ansible/ansible.cfg /etc/ansible/ansible.cfg
    sudo cp /home/ansible/hosts /etc/ansible/hosts
fi
pipx install --include-deps ansible
pipx install --include-deps netmiko
pipx install --include-deps netaddr
pipx install --include-deps argcomplete
activate-global-python-argcomplete
pipx install --include-dep cryptography --upgrade  
pipx install --include-deps pywinrm 
pipx install --include-deps  pywinrm[credssp] 
pipx install --include-deps pywinrm[kerberos] 
pipx install --include-deps molecule[ansible,docker,lint] 
pipx install --include-deps docker 
pipx ensurepath
ansible-galaxy collection install arista.eos
ansible-galaxy collection install nokia.srlinux
ansible-galaxy collection install community.general
docker image pull docker image pull registry.iutbeziers.fr/ceos:4.33.1F
docker tag registry.iutbeziers.fr/ceos:4.33.1F registry.iutbeziers.fr/ceosimage:latest
docker tag registry.iutbeziers.fr/ceos:4.33.1F registry.iutbeziers.fr/ceos:latest
docker image pull ghcr.io/nokia/srlinux
docker tag ghcr.io/nokia/srlinux ghcr.io/nokia/srlinux:latest
docker image pull registry.iutbeziers.fr/debian12:ssh 
docker image pull registry.iutbeziers.fr/rocky9:ssh
