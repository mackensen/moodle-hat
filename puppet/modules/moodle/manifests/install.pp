class moodle::install {
  Exec {
    path        => ['/bin','/usr/bin'],
    environment => ['HOME=/root'],
    provider    => 'shell',
    cwd         => "${moodle::docroot}",
  }

  package { ['php5-mysql', 'php5-curl', 'php5-gd', 'php5-xmlrpc', 'php5-intl']:
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
  }
}
