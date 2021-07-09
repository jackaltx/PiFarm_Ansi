<H1>PiFarmAnsible Scripts</H1>   

## Introduction

Use this to configure a Raspberry Pi Cluster with and external mangement node (the Farmer) and connected group of Raspberry Pi's doing tasks (the Workers).
This work is based on the [RaspiFarm](https://raspi.farm/) work by two students from Switzerland. The idea is is old and works quite
well, and I am grateful for them showing me how to do it with Pi's. I happened on their work when I was curious about how to build a cluster with commodity single board computers.  Raspberry Pi's have been an cost effective way to assemble a bare metal cluster, so off I went to amazon. 

It was on the RaspiFarm site I got to learn about [ansible](https://www.ansible.com/).  Earliers in my career had started working with Puppet and have used it satifactorally in a few projects.  The issue was always...I had to install ruby, and puppet AND teach others how to do ruby AND puppet. I worked with an organziation that has been embrasing python. Python was available everyplace I needed it. So this was an opportunity to learn more about ansible and python.  It's still a love-hate relationship, but it grows on me.  Best of all, other people wanted to make it work for them.</p>

This project hosts my experiments of building a Pi Cluster into a working Computer farm by using ansible.  It is far from perfect, but it it working well (for me). I can take a default download of the [Raspberry Pi OS](https://www.raspberrypi.org/software/operating-systems/), connect them with a simple network appliance, and use these ansibles scripts to configure bare metal cluster. I have done this many times with a VMs, but always seem to have issues with bare metal.</p>

## Sample PiFarms

###  The network appliance

Any old Swich

###  Farm types

External Farmers (ansible, dhcp, dns, [gateway]) and  All pi workers


### Configuring you home router hints.

Pfsense instructions

## Steps

Prior to pulling this file on Centos8 install git  "dnf install git-all -y"

- Edit the farm.yml to set infrastructure variables. (details pending)
- (Optional) On the Farmer node download ansible and create the ssh keys  (./bin/init_ssh)
- Create the Lab Users and push the Farmer key to all the Pi Worker nodes. You will need to do this at you pi's user/password  (my images: pi/pifarm)
  - ansible-playbook -e ansible_user=pi -k initialize_cluster-workers.yml
- Setup the ssh known_hosts by doing:
  - ansible-playbook initialize-known-hosts.yml
- (Optional) Gather all the ansible facts into a folder
  - ansible-playbook get-facts.yml
- Then initialize the farmer and workers:
  - ansible-playbook initialize_workers.yml
  - ansible-playbook initialize_farmer.yml
- (Optional) Setup a granafa monitor on the farmer:
  - ansible-playbook monitor-cluster.yml
- (Optional) test the cluster using sysbench:
  - ansible-playbook  run-sysbench.yml

## Optional playbooks

Dump Ansible Host Variables (host-vars)
```
ansible-playbook dump-hostvars.yml
```
Shutdown the farm worker nodes
```
ansible-playbook shutdown-farm.yml
```
Reboot the farm worker nodes
```
ansible-playbook reboot-farm.yml
```
Update the Pi firmware the farm worker nodes
```
ansible-playbook set-eeprom.yml
```
Stop Bluetooth and WiFi on the farm worker nodes.  Currently I don't enable, but just in case.
```
ansible-playbook stop-wireless
```
## Configuration

This will be high level and break into deeper details

## Future work


More later, this is starting the documention off.
