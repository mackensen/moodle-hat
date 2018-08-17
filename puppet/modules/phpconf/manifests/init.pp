class phpconf {

  # include '::php::cli'

  # class { 'php::cli': ensure => '7.1.8' }


  php::params {
    php_package_name = 'php7.1',
    cli_package_name = 'php7.1-cli',

  }

  php::module { 'cli': ensure => '7.1.8' }
  php::module { 'mysql': ensure => '7.1.8' }
  php::module { 'pgsql': ensure => '7.1.8' }
  php::module { 'curl': ensure => '7.1.8' }
  php::module { 'gd': ensure => '7.1.8' }
  php::module { 'xmlrpc': ensure => '7.1.8' }
  php::module { 'intl': ensure => '7.1.8' }
  php::module { 'xml': ensure => '7.1.8' }
  php::module { 'mbstring': ensure => '7.1.8' }
  php::module { 'zip': ensure => '7.1.8' }
  php::module { 'ldap': ensure => '7.1.8' }
  php::module { 'xdebug': ensure => '7.1.8' }
  php::module { 'fpm': ensure => '7.1.8' }
  #   ]:
  # }

  # php::fpm::pool { 'moodlehat':
  #   user => 'www-data',
  #   group => 'vagrant',
  #   listen_owner => 'www-data',
  #   listen_group => 'www-data',
  #   listen_allowed_clients => '127.0.0.1',
  #   listen => '127.0.0.1:9000',
  #   before => Class['::php'],
  # }
}
