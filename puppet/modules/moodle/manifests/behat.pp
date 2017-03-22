class moodle::behat {
  exec { 'configure_behat':
    command => 'php admin/tool/behat/cli/init.php',
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    cwd => "${moodle::docroot}",
    require => Exec['composer_install'],
  }

  file { '/var/www/behat':
    ensure => 'directory',
    mode => 777,
  }

  apache::vhost { 'behat30.moodle.dev':
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
