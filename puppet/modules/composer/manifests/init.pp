class composer {
  package { ['curl', 'php5']:
    ensure => 'present',
  }

  exec { 'composer':
    command => 'curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer',
    path => '/usr/bin:/usr/sbin',
    require => Package['curl', 'php5'],
    creates => '/usr/local/bin/composer',
    environment => ["COMPOSER_HOME=/home/vagrant"],
  }

  exec { 'configure_composer':
    command => "composer config -g preferred-install dist",
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    require => Exec['composer'],
  }
}
