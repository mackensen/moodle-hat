class moodle::download {
  vcsrepo { "${moodle::docroot}":
    ensure => present,
    provider => git,
    source => 'https://github.com/moodle/moodle',
    revision => "${moodle::version}",
    group => vagrant,
    owner => vagrant,
  }
}
