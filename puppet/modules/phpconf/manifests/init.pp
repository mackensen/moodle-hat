class phpconf {

  # package { ['php7.1', 'php7.1-cli', 'php7.1-mysql', 'php7.1-pgsql', 'php7.1-curl', 'php7.1-gd', 'php7.1-xmlrpc', 'php7.1-intl', 'php7.1-xml', 'php7.1-mbstring', 'php7.1-zip', 'php7.1-ldap', 'php7.1-xdebug', 'php7.1-fpm', 'ghostscript']:
  #   ensure => 'present',
  #   before => [
  #     Exec['install_moodle'],
  #     Exec['composer'],
  #     File['/etc/php/7.1/mods-available/custom.ini'],
  #   ],
  # }
  #
  # file {'/etc/php/7.1/mods-available/custom.ini':
  #   ensure => 'present',
  #   owner => root, group => root, mode => 444,
  #   content => "always_populate_raw_post_data = -1\n",
  #   before => Exec['enable_custom_ini'],
  # }


  # class { '::php::fpm':
  #   pools => { },
  # }

  php::fpm::pool { 'moodlehat':
    user => 'www-data',
    group => 'vagrant',
    listen_owner => 'www-data',
    listen_group => 'www-data',
    listen_allowed_clients => '127.0.0.1',
    listen => '127.0.0.1:9001',
    # before => Class['::php::globals'],
  }

  class { '::php::globals':
    php_version => '7.1',
    config_root => '/etc/php/7.1',
  } ->
  class { '::php':
    package_prefix => 'php7.1-',
    fpm => true,
    fpm_service_enable => true,
    fpm_service_ensure => 'running',
    # fpm_service_name => 'php-fpm',
    dev => true,
    composer => false,
    pear => false,
    phpunit => false,
    settings => {
      'PHP/always_populate_raw_post_data' => '-1',
      'PHP/log_errors' => 'true',
      'PHP/error_log' => '/var/log/php-fpm-error.log',
    },
    extensions => {
      'mysql'     => { },
      'pgsql'     => { },
      'curl'      => { },
      'gd'        => { },
      'xmlrpc'    => { },
      'intl'      => { },
      'xml'       => { },
      'mbstring'  => { },
      'zip'       => { },
      'ldap'      => { },
      'xml'       => { },
      'xdebug'    => { },
    },
    before => [
      Exec['composer'],
      Exec['install_moodle'],
    ]
  }

  # class { '::php::fpm':
  #   pools => { },
  # }

}
