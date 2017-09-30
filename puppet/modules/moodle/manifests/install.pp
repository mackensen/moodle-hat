class moodle::install {
  Exec {
    path        => ['/bin','/usr/bin', '/usr/sbin'],
    environment => ['HOME=/root'],
    provider    => 'shell',
    cwd         => "${moodle::docroot}",
  }

  package { ['php7.1', 'php7.1-cli', 'php7.1-mysql', 'php7.1-pgsql', 'php7.1-curl', 'php7.1-gd', 'php7.1-xmlrpc', 'php7.1-intl', 'php7.1-xml', 'php7.1-mbstring', 'php7.1-zip', 'php7.1-ldap', 'php7.1-xdebug', 'ghostscript']:
    ensure => 'present',
    before => [
      Exec['install_moodle'],
      Exec['composer'],
      File['/etc/php/7.1/mods-available/custom.ini'],
    ],
  }

  file {'/etc/php/7.1/mods-available/custom.ini':
    ensure => 'present',
    owner => root, group => root, mode => 444,
    content => "always_populate_raw_post_data = -1\n",
    before => Exec['enable_custom_ini'],
  }

  exec { 'enable_custom_ini':
    command => '/usr/sbin/phpenmod -v php7.1 custom',
    notify => Service['apache2'],
  }

  exec { 'install_moodle':
    command => "/usr/bin/php admin/cli/install.php --wwwroot=\"http://local.moodle.test\" --dataroot=${moodle::dataroot} --dbname=moodle --dbuser=moodle --dbpass=moodle --fullname=MoodleHat --shortname=HAT --adminuser=admin --adminpass=P4ssw0rd! --non-interactive --agree-license --allow-unstable",
    creates => "${moodle::docroot}/config.php",
  }

  file { "${moodle::docroot}/config.php":
    source => 'puppet:///modules/moodle/config.php',
    group => 'vagrant',
    owner => 'vagrant',
    mode => '777',
    require => Exec['install_moodle'],
    before => Exec['configure_behat', 'configure_phpunit'],
  }

  exec { 'clean_vendor':
    command => "rm -rf vendor/",
    path => '/bin',
    cwd => "${moodle::docroot}",
  }

  exec { 'composer_install':
    command => "composer install",
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    cwd => "${moodle::docroot}",
    require => Exec['composer', 'install_moodle', 'clean_vendor'],
  }

}
