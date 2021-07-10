# ansible-role-dnsmasq

A versatile role to setup dnsmasq, created using this philosophy:
https://github.com/jriguera/ansible-role-pattern/blob/master/README.md

This role supports the definition of different interfaces for different
purposes (dns, tftp ...) and a lot of dnsmasq parameters. Also it is
able to manage the resolv.conf file.

Ansible 2.0, works with Ubuntu Trusty, Xenial and Centos 7


## Configuration

Default configuration parameters are:

```
dnsmasq_enabled_on_startup: True
# Manage resolvconf
dnsmasq_resolvconf: False

# Install from upstream repos or directly from operating system packages
dnsmasq_os_packages: True

# Global parameters, settings needed! otherwise are ignored!
dnsmasq_dhcp: True
dnsmasq_tftp: True

### resolv.conf
#dnsmasq_host_domain: local
#dnsmasq_host_search: local
dnsmasq_host_resolvers: [ "127.0.0.1" ]

# Set the facility to which dnsmasq will send syslog entries, this defaults to
# DAEMON, and to LOCAL0 when debug mode is in operation. If the facility given
# contains at least one '/' character, it is taken to be a filename, and dnsmasq
# logs to the given file, instead of syslog. If the facility is '-' then dnsmasq
# logs to stderr.
dnsmasq_conf_log: /var/log/dnsmasq.log

# Enable asynchronous logging and optionally set the limit on the number of
# lines which will be queued by dnsmasq when writing to the syslog is slow.
#dnsmasq_conf_log_async:
dnsmasq_conf_log_dns: False

# List of ip or interfaces to listen (empty list for all)
dnsmasq_conf_listen: []

# On systems which support it, dnsmasq binds the wildcard address,
# even when it is listening on only some interfaces. It then discards
# requests that it shouldn't reply to. This has the advantage of
# working even when interfaces come and go and change address.
dnsmasq_conf_bind_interfaces: 'dynamic'


### DNS
# Accept DNS queries only from hosts whose address is on a local subnet,
# ie a subnet for which an interface exists on the server.
#dnsmasq_conf_local_service: True

# Never forward plain names (without a dot or domain part)
dnsmasq_conf_domain_needed: True

# Enable code to detect DNS forwarding loops; ie the situation where a query
# sent to one of the upstream server eventually returns as a new query to the
# dnsmasq instance.
#dnsmasq_conf_dns_loop_detect: True

# All reverse lookups for private IP ranges (ie 192.168.x.x, etc) which
# are not found in /etc/hosts or the DHCP leases file are answered with
# "no such domain" rather than being forwarded upstream.
# Never forward addresses in the non-routed address spaces.
dnsmasq_conf_bogus_priv: True

# If you don't want dnsmasq to read /etc/hosts, uncomment the
# following line.
dnsmasq_conf_no_hosts: False

# Additional hosts file, /etc/hosts format (it is a list!)
#dnsmasq_conf_hosts:
# - ["127.0.0.1", "localhost"]
# - ["::1", "ip6-localhost", "ip6-loopback"]
# - ["fe00::0", "ip6-localnet"]
# - ["ff00::0", "ip6-mcastprefix"]
# - ["ff02::1", "ip6-allnodes"]
# - ["ff02::2", "ip6-allrouters"]
# - ["192.168.1.10", "foo.mydomain.org", "foo" ]
dnsmasq_conf_hosts: []

# Set the dns memory cachesize here.
cache-size: 1024

# Disable negative caching. Negative caching allows dnsmasq to remember
# "no such domain" answers from upstream nameservers and answer identical
# queries without forwarding them again.
# Negative replies from upstream servers normally contain time-to-live
# information in SOA records which dnsmasq uses for caching. If this parameter
# is undefined: "no-negcache".
dnsmasq_conf_negcache: 5

# This flag forces dnsmasq to try each query with each server strictly in
# the order they appear in /etc/resolv.conf
dnsmasq_conf_strict_order: False

# This flag forces dnsmasq to send all queries to all available servers.
# The reply from the server which answers first will be returned to the
# original requester.
dnsmasq_conf_all_servers: False

# If you want dnsmasq to read "/etc/resolv.conf" or any other file.
# Empty or not defined to disable reading resolfv.conf
dnsmasq_conf_resolv: /etc/resolv.conf

# Don't poll /etc/resolv.conf for changes.
dnsmasq_conf_no_poll: False

# if dnsmasq_conf_no_poll is False then /etc/resolv.conf is re-read or the
# upstream servers are set via DBus, clear the DNS cache.
dnsmasq_conf_clear_on_reload: True

# Specify IP address of upstream servers directly. Setting this flag does not
# suppress reading of /etc/resolv.conf: ['localnet', '192.168.0.1']
# Example of routing PTR queries to nameservers: this will send all:
# address->name queries for 192.168.3/24 to nameserver 10.1.2.3
# ['3.168.192.in-addr.arpa', '10.1.2.3']
#dnsmasq_conf_servers:
#  - [ "/google.com/", "8.8.8.8" ]
#  - "8.8.4.4"
dnsmasq_conf_servers: [ "8.8.8.8", "8.8.4.4" ]

# Return an MX record pointing to itself for all local machines: '_self'
# MX record pointing to dnsmasq server for all local machines: '_local' or ''
# MX record pointing to "servername" for all local machines: 'servername'
# Return an MX record named "maildomain.com" with target
# "servername" and preference 50: [maildomain.com, servername, 50]
#dnsmasq_conf_mx: servername
#dnsmasq_conf_mx_domain: {{ hostvars['k4.ww.mens.de'].
#dnsmasq_conf_mx_pref: 1

# Add A, AAAA and PTR records to the DNS. This adds one or more names to the
# DNS with associated IPv4 (A) and IPv6 (AAAA) records
#dnsmasq_conf_host_records:
#  -[]

# Define a DNS zone for which dnsmasq acts as authoritative server.
#dnsmasq_conf_auth_zone: []


### DHCP

# Log lots of extra information about DHCP transactions.
dnsmasq_conf_log_dhcp: False

# Set the domain for dnsmasq. this is optional, but if it is set, it
# does the following things.
# 1) Allows DHCP hosts to have fully qualified domain names, as long
#     as the domain part matches this setting.
# 2) Sets the "domain" DHCP option thereby potentially setting the
#    domain of all systems configured by DHCP
# 3) Provides the domain part for "expand-hosts"
# If the domain is given as "#" then the domain is read from the first
# "search" directive in /etc/resolv.conf
dnsmasq_conf_domain: '#'

# Only if dnsmasq_conf_domain is set, the unqualified name is no longer put
# in the DNS, only the qualified name.
dnsmasq_conf_dhcp_fqdn: True

# Should be set when dnsmasq is definitely the only DHCP server on a network.
dnsmasq_conf_dhcp_authoritative: True

# Dnsmasq is designed to choose IP addresses for DHCP clients using a hash
# of the client's MAC address.
dnsmasq_conf_dhcp_sequential_ip: True

# Disable re-use of the DHCP servername and filename fields as extra option space.
dnsmasq_conf_dhcp_no_override: True

# Uncomment this to enable the integrated DHCP server, you need
# to supply the range of addresses available for lease and optionally
# a lease time. If you have more than one network, you will need to
# repeat this for each network on which you want to supply DHCP
# service.
#dnsmasq_conf_dhcp: []
#dnsmasq_conf_dhcp:
#   - device: eth0:
#     range: [192.168.1.80, 192.168.1.150, infinite]
#     option: []
#     ignore_names: True
#     generate_names: True
#     boot: []
#     tftp: /var/lib/tftpboot

# Read DHCP host information from the list or from specified local file
#dnsmasq_conf_dhcp_hosts: []

# Completely suppress use of the lease database file. The file will not be
# created, read, or written.
dnsmasq_conf_dhcp_leasefile_ro: False

# Whenever a new DHCP lease is created, or an old one destroyed, or a TFTP file
# transfer completes, the executable specified by this option is run.
#dnsmasq_conf_dhcp_script: files/program.bin


### TFTP

# Enable TFTP secure mode: without this, any file which is readable by the
# dnsmasq process under normal unix access-control rules is available via TFTP
dnsmasq_conf_tftp_secure: False

# Convert filenames in TFTP requests to all lowercase. This is useful for
# requests from Windows machines
dnsmasq_conf_tftp_lowercase: True

# Set the maximum number of concurrent TFTP connections allowed
dnsmasq_conf_tftp_max: 50

# Stop the TFTP server from negotiating the "blocksize" option with a client
dnsmasq_conf_tftp_no_blocksize: False
```

You can overwrite these default parameters as role variables. Have a look at
the example in `site.yml` with vagrant and test it by using `vagrant up`.

Apart of managing dnsmasq, this role is capable of managing `/etc/resolv.conf`
file by defining `dnsmasq_resolvconf: true` and `dnsmasq_host_*` parameters.


## Author

José Riguera López <jriguera@gmail.com>
