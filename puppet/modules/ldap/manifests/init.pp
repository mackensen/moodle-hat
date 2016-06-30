class ldap {
  class { 'openldap::server': }

  openldap::server::database { 'dc=example,dc=com':
    ensure => present,
    rootdn => 'cn=admin,dc=example,dc=com',
    rootpw => 'password',
  }
}
