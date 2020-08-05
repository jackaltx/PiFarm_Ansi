#!/bin/sh

mkdir -p ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ""
cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

