# Moodle Hat

Moodle Hat is a [Vagrant](http://vagrantup.com) configuration which provisions a Moodle instance with Behat [Acceptance testing](https://docs.moodle.org/dev/Acceptance_testing) and [PHPUnit testing](https://docs.moodle.org/dev/PHPUnit) configured. It uses a headless [Selenium](http://www.seleniumhq.org/) server for Javascript testing. It supports LDAP tests and has optional xdebug support.

## Overview

### Purpose

Configuring Behat and Selenium isn't one of my favorite things. This project provides a relatively quick and painless way to create that environment for testing. PHPUnit testing is included as well for completeness.

### How to Use

These instructions assume a basic familiarity with Vagrant. Run `vagrant up` after the initial clone and `vagrant provision` after updates. The Moodle instance may be accessed at [http://local.moodle.dev](http://local.moodle.dev).

#### Behat

Open two ssh sessions to the vagrant box. In the first, run `selenium`. This relies on a bash alias to launch the headless Selenium server. In the second window, do this:

- `cd /var/www/moodle/htdocs` (default location of Moodle)
- `behat` (runs all Behat tests)

`behat` is a shell script which creates reports within `/var/www/behat/` and calls the local vendor binary. You may append standard arguments such as `behat --tags @core_blog`, which would execute core_blog tests only. The reports may be accessed via the command line or at [http://behat.moodle.dev](http://behat.moodle.dev).

#### PHPUnit

PHPUnit tests may be invoked normally from the command line on the vagrant host. To run the tests with [xdebug](https://docs.moodle.org/dev/Profiling_PHP) support, use this syntax:

```bash
php -d xdebug.profiler_enable=on vendor/bin/phpunit ...
```

Profiles are logged to `/tmp` on the virtual machine and may be inspected at [http://webgrind.moodle.dev](http://webgrind.moodle.dev), which runs [Webgrind](https://github.com/jokkedk/webgrind).

#### Cron

Cron is enabled by default under the `www-data` user. It logs to `/var/www/cron`. You may view the logs at [http://cron.moodle.dev](http://cron.moodle.dev).

### Software requirements

Moodle Hat requires recent versions of both Vagrant and VirtualBox to be installed. You also need the [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin.

Running the full suite of acceptance tests takes several hours. If you experience timeouts, try increasing the amount of memory in the Vagrantfile.

### Database support

Both MySQL and PostgreSQL are installed and configured; the database schemas are named `moodle` and are accessed by that same username and password. Moodle is installed on MySQL by default; to use PostgreSQL instead change the database driver in `config.php` and reinstall.

### Known issues

- The initial provisioning task can take a long time because it clones the [Moodle git repository](https://github.com/moodle/moodle) from GitHub.
- If you destroy and re-create the VM, you need to delete `config.php` inside the shared `moodle/` folder, otherwise core Moodle won't re-install.

## Copyright / License

Moodle Hat was originally developed at Lafayette College and is available under the GPL2 license.

## Acknowledgements

The headless Selenium portion of this project borrows heavily from David Adams' blog post [Behat And Selenium In Vagrant](http://programmingarehard.com/2014/03/17/behat-and-selenium-in-vagrant.html).
