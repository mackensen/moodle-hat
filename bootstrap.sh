#!/usr/bin/env bash
apt-get update
apt-get install -y git acl

# Puppet modules
(puppet module list |grep puppetlabs-apache) || puppet module install puppetlabs-apache
(puppet module list |grep puppetlabs-mysql) || puppet module install puppetlabs-mysql
(puppet module list |grep puppetlabs-vcsrepo) || puppet module install puppetlabs-vcsrepo
(puppet module list |grep puppetlabs-stdlib) || puppet module install puppetlabs-stdlib
