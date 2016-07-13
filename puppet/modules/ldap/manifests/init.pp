class ldap {
  class { 'openldap::server': }

  openldap::server::database { 'dc=example,dc=com':
    ensure => present,
    rootdn => 'cn=admin,dc=example,dc=com',
    rootpw => 'password',
  }

  openldap::server::schema { 'eduperson':
    ensure => present,
    path => '/etc/ldap/schema/eduperson.schema',
    require => File['/etc/ldap/schema/eduperson.schema'],
  }

  file { '/etc/ldap/schema/eduperson.schema':
    source => 'puppet:///modules/ldap/eduperson.schema',
    mode => 755,
  }
}
