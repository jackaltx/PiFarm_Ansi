#!/bin/sh

# Used to setup the local machine for the "farmer" role
# This is used one time only.  I did nothing to make it idempotent

# TODO...determine the distro and install accordingly

# this will be centos  ssh-ask only for now
sudo dnf install centos-release-ansible-29 openssh-askpass -y
#sudo apt install ansible -y
#sudo apt install ssh-askpass -y

mkdir -p ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ""
cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

