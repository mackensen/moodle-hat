#!/usr/bin/env bash
apt-get update -y
add-apt-repository ppa:ondrej/php
add-apt-repository ppa:openjdk-r/ppa
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get -y update
apt-get install -y git

# Puppet modules
(puppet module list |grep puppetlabs-apache) || puppet module install puppetlabs-apache --version=1.11.1
(puppet module list |grep puppetlabs-mysql) || puppet module install puppetlabs-mysql --version=3.11.0
(puppet module list |grep puppetlabs-postgresql) || puppet module install puppetlabs-postgresql --version=4.8.0
(puppet module list |grep puppetlabs-vcsrepo) || puppet module install puppetlabs-vcsrepo --version=1.5.0
(puppet module list |grep puppetlabs-stdlib) || puppet module install puppetlabs-stdlib
(puppet module list |grep saz-locales) || puppet module install saz-locales
(puppet module list |grep camptocamp-openldap) || puppet module install camptocamp-openldap --version=1.15.0
(puppet module list |grep thias-php) || puppet module install thias-php --version 1.2.2
