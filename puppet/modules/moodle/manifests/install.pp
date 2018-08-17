class moodle::install {
  Exec {
    path        => ['/bin','/usr/bin', '/usr/sbin'],
    environment => ['HOME=/root'],
    provider    => 'shell',
    cwd         => "${moodle::docroot}",
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
