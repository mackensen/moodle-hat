class composer {
  package { ['curl', 'php5']:
    ensure => 'present',
  }

  exec { 'composer':
    command => 'curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer',
    path => '/usr/bin:/usr/sbin',
    require => Package['curl', 'php5'],
    creates => '/usr/local/bin/composer',
  }
}
