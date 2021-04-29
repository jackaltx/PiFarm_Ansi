<H1>PiFameAnsible Scripts</H1>   

<p>Use this to configure a Raspberry Pi Cluster with one node (the Farmer) and the others doing work tasks (the Worker).
This work is based on the [RaspiFarm](https://raspi.farm/) work by two students from Switzerland.   The idea is is old and works
well.   I happened on thier work when I was curious about how to build a farm with commodity single board computers and Raspberry Pi's have been an cost effective way to assemble a bare metal cluster. It was there I got to learn about [ansible](https://www.ansible.com/).  I had started lookin at Puppet at the beginning of the last decade and used it satifactorally in a few projoects.  The issue was allways...I had to install ruby and teach others how to do ruby.   Yet I worked with a buch of python programmers. It was loaded everyplace I needed it and the IT organization allowed it.   So this was my opportunity to learn more about ansible and ruby.  It's still a love-hate relationship, but it works.  And it works simply.</p>

<p>This project hosts my experiments of building a Pi Cluster into a working Computer farm by using ansible.  It is far from perfect, but it it working well (for me).  I can take a default download of the [Raspberry Pi OS](https://www.raspberrypi.org/software/operating-systems/), connect them with a simple network appliance, and use these ansibles scripts to configure bare metal cluster.  I have done this many times with a VMs, but always seem to have issues with bare metal.</p>

# Steps
- Edit the farm.yml to set infrastructure variables. (details pending)
- On the Farmer node download ansible and create the ssh keys  (./bin/init_ssh)
- Push the keys to all the  WorkerNodes  (ansible-playbook -u pi -k initialize_cluster.yml)
- (Optional) Gather all the ansible facts into a folder (ansible-playbook get-facts.yml)
- Then initialize the farmer and workers (in no particular order by
  - ansible-playbook initialize_workers.yml
  - ansible-playbook initialize_farmer.yml
  - Setup a granafa monitor on the farmer (ansible-playbook monitor-cluster)
- test the cluster (ansible-playbook  run-sysbench)


More later, this is starting the documention off.
