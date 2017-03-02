# Moodle Hat

Moodle Hat is a [Vagrant](http://vagrantup.com) configuration which provisions a Moodle instance with Behat [Acceptance testing](https://docs.moodle.org/dev/Acceptance_testing) and [PHPUnit testing](https://docs.moodle.org/dev/PHPUnit) configured. It uses a headless [Selenium](http://www.seleniumhq.org/) server for Javascript testing.

The `MOODLE_31_STABLE` branch is locked on that version of Moodle instead of `master`. To stay on bleeding-edge Moodle, please switch to the `master` branch.

## Overview

### Purpose

Configuring Behat and Selenium isn't one of my favorite things. This project provides a relatively quick and painless way to create that environment for testing. PHPUnit testing is included as well for completeness.

### How to Use

These instructions assume a basic familiarity with Vagrant.

After `vagrant up` finishes, open two ssh sessions to the vagrant box. In the first, run `selenium`. This relies on a bash alias to launch the headless Selenium server. In the second window, do this:

- `cd /var/www/moodle/htdocs` (default location of Moodle)
- `behat` (runs all Behat tests)

`behat` is a shell script which creates reports within `/var/www/behat/` and calls the local vendor binary. You may append standard arguments such as `behat --tags @core_blog`, which would execute core_blog tests only. The reports may be accessed via the command line or at [http://behat31.moodle.dev](http://behat31.moodle.dev).

PHPUnit tests may be invoked normally from the command line on the vagrant host.

The instance itself may be accessed at [http://local31.moodle.dev](http://local31.moodle.dev).

#### Software requirements

Moodle Hat requires recent versions of both Vagrant and VirtualBox to be installed. You also need the [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin.

Running the full suite of acceptance tests takes several hours. If you experience timeouts, try increasing the amount of memory in the Vagrantfile.

#### Database support

Both MySQL and PostgreSQL are installed and configured; the database schemas are named `moodle` and are accessed by that same username and password. Moodle is installed on MySQL by default; to use PostgreSQL instead change the database driver in `config.php` and reinstall.

#### Known issues

- The initial provisioning task can take a long time because it clones the Moodle git repository from github.
- If you destroy and re-create the VM delete `config.php` inside the shared `moodle/` folder otherwise core Moodle won't re-install.

## Copyright / License

Moodle Hat was originally developed at Lafayette College and is available under the GPL2 license.

## Acknowledgements

The headless Selenium portion of this project borrows heavily from David Adams' blog post [Behat And Selenium In Vagrant](http://programmingarehard.com/2014/03/17/behat-and-selenium-in-vagrant.html).
