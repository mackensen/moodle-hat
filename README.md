# Moodle Hat

Moodle Hat is a [Vagrant](http://vagrantup.com) configuration which provisions a Moodle instance with Behat [Acceptance testing](https://docs.moodle.org/dev/Acceptance_testing) configured. It includes a headless [Selenium](http://www.seleniumhq.org/) server for Javascript testing.

## Overview

### Purpose

Configuring Behat and Selenium isn't one of my favorite things. This project provides a relatively quick and painless way to create that environment for testing.

### How to Use

These instructions assume a basic familiarity with Vagrant. After `vagrant up` finishes, open two ssh sessions to the vagrant box. In the first, run `selenium`. This relies on a bash alias to launch the headless Selenium server. In the second window, do this:

- `cd /var/www/moodle/htdocs` (default location of Moodle)
- `vendor/bin/behat --config /var/www/moodle/behatdata/behat/behat.yml` (runs all Behat tests)

#### Software requirements

Moodle Hat requires recent versions of both Vagrant and VirtualBox to be installed. You also need the [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin.

#### Known issues ####

The initial provisioning task can take a long time because it clones the Moodle git repository from github. Sometimes the composer task which installs Behat will fail because of Github API limits and has to be run manually.

## Copyright / License

Moodle Hat was originally developed at Lafayette College and is available under the GPL2 license.

## Acknowledgements

The headless Selenium portion of this project borrows heavily from David Adams' blog post [Behat And Selenium In Vagrant](http://programmingarehard.com/2014/03/17/behat-and-selenium-in-vagrant.html).