# PiFarmAnsible Scripts

## Introduction

Use this to configure a Raspberry Pi Cluster with an external mangement node (the Farmer) and group of Raspberry Pi's doing tasks (the Workers).
This work is based on the [RaspiFarm](https://raspi.farm/) work by two students from Switzerland. The idea is is old and works quite
well, and I am grateful for them showing me how to do it with Pi's. I happened on their work when I was curious about how to build a cluster of commodity single board computers.  Raspberry Pi's have been an cost effective way to assemble a bare metal cluster, so off I went to amazon.

It was on the RaspiFarm site I got to learn about [ansible](https://www.ansible.com/).  Earlier in my career had started working with Puppet and have used it satifactorally in a few projects.  The issue was always...I had to install ruby, and puppet AND teach others how to do ruby/puppet. Plus there were enginers and engineers like control.  Declarative languages are sometimes a bridge to far. The organizaiton I worked with an organization hasb been embracing python. Python was available everyplace I needed it.  And installed on every Linux OS. So this was an opportunity to learn more about ansible and python.  It's still a love-hate relationship, but it grows on me.  Best of all, other people wanted to make it work for them.</p>

This project hosts my experiments of building a Pi Cluster into a working Computer farm by using ansible.  It is far from perfect, but it it working well (for me). I can take a default download of the [Raspberry Pi OS](https://www.raspberrypi.org/software/operating-systems/), connect them with a simple network appliance, and use these ansibles scripts to configure bare metal cluster. I have done this many times with a VMs, but always seem to have issues with bare metal.</p>

## Sample PiFarms

### The network appliance

Any old switch and or firewall.

### Farm types

External Services (ansible, dhcp, [dns)], with or without a gateway.  Then a cluster of rasperry pi workers.
Current I am using dnsmasq to do DHCP.

### Reference Network Diagram

The Farmer is multi-homed.  Do not put a gateway on the internal one or you will get a network loop.

The Pi's only know their private nework and have the router internal address as their gateway.

![Reference image]( docs/images/ReferenceNetwork.png )

## Steps

Prior to pulling this file on Centos8 install git  "dnf install git-all -y"

In the root directory the 'ansible.cfg' is the glue that makes this tool work. Review it and change as required.

The farm uses a "yaml" file to set the structure.  This is convenient because it is meant to be reconfigured often. The current confguration being run is in the farm.yml file.

Secrets are stored in the structre, to keep them secret ansible_vault is being used.  Create the password environment variable in your ~/.bash_profile, like ``export PIFARM_VAULT_PASSWORD=test``.  Review the file '.vault_pass to see how this environment variable is used.

[BEING REWORKED]

On the the management node, a.k.a. Farmer, download ansible and create the ssh keys  (./bin/init_ssh).




- Setup the ssh known_hosts on the farmer for the ip address:
  - ``` ansible-playbook initialize-known-hosts.yml```
- Create the Lab Users and push the Farmer key to all the Pi Worker nodes. You will need to do this at your pi's user/password  (default images: worker/raspberry)
  - ``` ansible-playbook -e ansible_user=worker -k initialize-cluster-workers.yml```
- (Optional) Gather all the ansible facts into a folder
  - ``` ansible-playbook -K tools/get-facts.yml```
  - ``` ansible -m debug -a "var=hostvars"  localhost > facts/hostvars.json ```
- Then initialize the farmer and workers:
  - ``` ansible-playbook initialize-workers.yml```
  - ``` ansible-playbook -K initialize-farmer.yml```
- (Optional) Setup a grafana monitor on the farmer:
  - ``` ansible-playbook monitor-cluster.yml```
- (Optional) test the cluster using sysbench:
  - ``` ansible-playbook run-sysbench.yml```

## Optional playbooks

Dump Ansible Host Variables (host-vars)

```bash
ansible-playbook tools/dump-hostvars.yml
```

Expand the file root filesystem.  This is for a special case where there is unallocated space on the SD card.

``` bash
ansible-playbook  expandfs.yml
```


Shutdown the farm worker nodes

```bash
ansible-playbook shutdown-farm.yml
```

Reboot the farm worker nodes

```bash
ansible-playbook reboot-farm.yml
```

Update the Pi firmware the farm worker nodes

```bash
ansible-playbook update-firmware.yml
```

Stop Bluetooth and WiFi on the farm worker nodes.  Currently I don't enable, but just in case.

```bash
ansible-playbook stop-wireless
```

## Inventory

This is continually under development  lookin the farms directory for samples


## Future work

More later, this is starting the documention off.
