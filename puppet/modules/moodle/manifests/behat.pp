class moodle::behat {
  exec { 'configure_composer':
    command => "composer config -g preferred-install dist",
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    require => Exec['composer'],
  }

  exec { 'configure_behat':
    command => 'php admin/tool/behat/cli/init.php',
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    cwd => "${moodle::docroot}",
    require => Exec['configure_composer', 'install_moodle'],
  }

  file { '/var/www/behat':
    ensure => 'directory',
    owner => 'www-data',
    group => 'vagrant',
    mode => 774,
  }

  apache::vhost { 'behat.moodle.dev':
    port => '80',
    priority => 2,
    docroot => "/var/www/behat",
    require => File['/var/www/behat'],
  }

  file { '/usr/local/bin/behat':
    source => 'puppet:///modules/moodle/behat.sh',
    mode => 755,
  }
}
