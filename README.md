# Moodle Hat

Moodle Hat is a [Vagrant](http://vagrantup.com) configuration which provisions a Moodle instance with Behat [Acceptance testing](https://docs.moodle.org/dev/Acceptance_testing) and [PHPUnit testing](https://docs.moodle.org/dev/PHPUnit) configured. It uses a headless [Selenium](http://www.seleniumhq.org/) server for Javascript testing.

## Overview

### Purpose

Configuring Behat and Selenium isn't one of my favorite things. This project provides a relatively quick and painless way to create that environment for testing. PHPUnit testing is included as well for completeness.

### How to Use

These instructions assume a basic familiarity with Vagrant.

You will need a [Github personal access token](https://help.github.com/articles/git-automation-with-oauth-tokens/) to download the composer dependencies for Behat and PHPUnit. Replace the placeholder value in `$oauth` in [the Moodle initiation file](puppet/modules/moodle/manifests/init.pp) with a valid token.

After `vagrant up` finishes, open two ssh sessions to the vagrant box. In the first, run `selenium`. This relies on a bash alias to launch the headless Selenium server. In the second window, do this:

- `cd /var/www/moodle/htdocs` (default location of Moodle)
- `vendor/bin/behat --config /var/www/moodle/behatdata/behat/behat.yml` (runs all Behat tests)

PHPUnit tests may be invoked normally from the command line on the vagrant host.

The instance itself may be accessed at [http://local.moodle.dev](http://local.moodle.dev).

#### Software requirements

Moodle Hat requires recent versions of both Vagrant and VirtualBox to be installed. You also need the [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin.

#### Known issues

The initial provisioning task can take a long time because it clones the Moodle git repository from github.

## Copyright / License

Moodle Hat was originally developed at Lafayette College and is available under the GPL2 license.

## Acknowledgements

The headless Selenium portion of this project borrows heavily from David Adams' blog post [Behat And Selenium In Vagrant](http://programmingarehard.com/2014/03/17/behat-and-selenium-in-vagrant.html).