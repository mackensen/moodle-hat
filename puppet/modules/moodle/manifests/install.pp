class moodle::install {
  Exec {
    path        => ['/bin','/usr/bin'],
    environment => ['HOME=/root'],
    provider    => 'shell',
    cwd         => "${moodle::docroot}",
  }

  package { ['php5.6', 'php5.6-cli', 'php5.6-mysql', 'php5.6-curl', 'php5.6-gd', 'php5.6-xmlrpc', 'php5.6-intl', 'php5.6-xml', 'php5.6-mbstring', 'php5.6-zip', 'php5.6-ldap']:
    ensure => 'present',
    before => Exec['install_moodle'],
  }

  exec { 'install_moodle':
    command => "/usr/bin/php admin/cli/install.php --wwwroot=\"http://local.moodle.dev\" --dataroot=${moodle::dataroot} --dbname=moodle --dbuser=moodle --dbpass=moodle --fullname=MoodleHat --shortname=HAT --adminuser=admin --adminpass=P4ssw0rd! --non-interactive --agree-license --allow-unstable",
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

  exec { 'update_composer':
    command => "composer update",
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    cwd => "${moodle::docroot}",
    require => Exec['composer', 'install_moodle'],
  }
}
