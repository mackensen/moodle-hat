class webgrind {
  vcsrepo { "/var/www/webgrind":
    ensure => present,
    provider => git,
    source => 'https://github.com/jokkedk/webgrind',
    revision => 'master',
    group => www-data,
    owner => www-data,
  }

  apache::vhost { 'webgrind31.moodle.dev':
    port => '80',
    priority => 2,
    docroot => "/var/www/webgrind",
    require => Vcsrepo['/var/www/webgrind'],
  }

  exec { 'make-webgrind':
    command => 'make',
    path => '/usr/bin',
    cwd => '/var/www/webgrind',
    require => Vcsrepo['/var/www/webgrind'],
  }
}
