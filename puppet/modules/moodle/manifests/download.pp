class moodle::download {
  vcsrepo { "${moodle::docroot}":
    ensure => present,
    provider => git,
    source => 'https://github.com/moodle/moodle',
    revision => "${moodle::version}",
    group => vagrant,
    owner => www-data,
  }

  file { "${moodle::docroot}":
    ensure => directory,
    group => vagrant,
    owner => www-data,
    mode => '774',
    subscribe => Vcsrepo["${moodle::docroot}"],
  }
}
