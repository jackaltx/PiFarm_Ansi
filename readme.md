# PiFarmAnsible Scripts

## Introduction

Use this to configure a Raspberry Pi Cluster with an external mangement node (the Farmer) and group of Raspberry Pi's doing tasks (the Workers).
This work is based on the [RaspiFarm](https://raspi.farm/) work by two students from Switzerland. The idea is is old and works quite
well, and I am grateful for them showing me how to do it with Pi's. I happened on their work when I was curious about how to build a cluster of commodity single board computers.  Raspberry Pi's have been an cost effective way to assemble a bare metal cluster, so off I went to amazon.

It was on the RaspiFarm site I got to learn about [ansible](https://www.ansible.com/).  Earlier in my career had started working with Puppet and have used it satifactorally in a few projects.  The issue was always...I had to install ruby, and puppet AND teach others how to do ruby/puppet. Plus there were enginers and engineers like control.  Declarative languages are sometimes a bridge to far. The organizaiton I worked with an organization hasb been embracing python. Python was available everyplace I needed it.  And installed on every Linux OS. So this was an opportunity to learn more about ansible and python.  It's still a love-hate relationship, but it grows on me.  Best of all, other people wanted to make it work for them.</p>

This project hosts my experiments of building a Pi Cluster into a working Computer farm by using ansible.  It is far from perfect, but it it working well (for me). I can take a default download of the [Raspberry Pi OS](https://www.raspberrypi.org/software/operating-systems/), connect them with a simple network appliance, and use these ansibles scripts to configure bare metal cluster. I have done this many times with a VMs, but always seem to have issues with bare metal.</p>

## Sample PiFarms

### The network appliance

Any old switch and/or firewall will do.  I have tested with a Dlink [DGS-1100-8](https://www.dlink.com/en/products/dgs-1100-08-8-port-gigabit-smart-managed-switch) smart managed switch and a [Ubiquiti EdgeRouter X](https://store.ui.com/collections/operator-edgemax-routers/products/edgerouter-x).

The farm can use snmp for monitoring the network appliance

### Farm types

I have tested the cluster with and without DNS services. Some small labs will not want the burden of DNS, so I use ansible to create a farm-wide '/etc/hosts' file. 

The farm can connect ot the internet or not. Of late I am not working in isolation so I do not need to setup a repository for updating.

The farm is a rasberry pi cluster, but I am currently adding in x86 VMs for other services.

I view the farm to be either a system to be the "unit under test" or the tool to do the testing of other units.  

### Reference Network Diagram

The Farmer can be multi-homed.  Do not put a gateway on the local farm network one or you will likely get a network loop.  Currently I the Farmer is node on my network which is allowed into the farm network.

The Pi's only know their private nework and have the router internal address as their gateway.

![Reference image]( docs/images/ReferenceNetwork.png )

# Installation 

```
git checkout https://github.com/jackaltx/PiFarm_Ansi.git
```

# Configuration

In the root directory the 'ansible.cfg' file is the glue that makes this tool work. Review it and change as required.

The farm uses a "yaml" file to set the structure.  This is convenient because is meant to be reconfigured often. The current confguration being run is in the 'farm.yml' file.

## Secrets Management

Secrets are stored in the structre, to keep them secret ansible_vault is being used.  Create the password environment variable in your ~/.bash_profile, like ``export PIFARM_VAULT_PASSWORD=test``.  Review the file '.vault_pass to see how this environment variable is used.

Create the vault secrets file '

## Create SSH Keys

Ansible uses SSH has the transport, so ....

[BEING REWORKED]

On the the management node, a.k.a. Farmer, download ansible and create the ssh keys  (./bin/init_ssh).


## SSH discovery setup on the farmer

Setup the ssh known_hosts on the farmer for the ip address:

  - ``` ansible-playbook initialize-known-hosts.yml```

## Initialize the farm

[BEING TRANSITIONED]  This is a chicken/egg issue.  The pi's default user/passwors is worker/raspberry.  It will change. It has changed. Also I need to account for non Rasberry Pi installs, such as VMs or other single board computer types.   The inventory is currenly seperated into workers, helpers and farmer(s).  The farmer is generally a non-integrating manager.  Other helpers will be need to be used as-is.  So this area will change as I get smarter.

[NON-WORKING] Create the Lab Users and push the Farmer key to all the Pi Worker nodes. You will need to do this at your pi's user/password  (default images: worker/raspberry)
  - ``` ansible-playbook -e ansible_user=worker -k initialize-cluster-workers.yml```

## Get the facts

All of this is optional. Ansible variables are clear as mud.  I like to gather all the ansible facts into a folder to help me debug.

  - ``` ansible-playbook -K tools/get-facts.yml```

Use the following to get the local hostvars

  - ``` ansible -m debug -a "var=hostvars"  localhost > facts/hostvars.json ```


```
ansible helper2 -m ansible.builtin.setup | less
ansible -m debug -a 'var=hostvars[inventory_hostname]' helper2 | less
```

## Initialize the cluster

Then initialize the farmer and workers:
  - ``` ansible-playbook initialize-workers.yml```
  - (not working!)``` ansible-playbook -K initialize-farmer.yml```

## Monitoring

(Optional) Setup a grafana/loki/promtail/prometheus monitor on the farm:
  - ``` ansible-playbook monitor-cluster.yml```

## Benchmarking 

[NOT WORKING]

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
