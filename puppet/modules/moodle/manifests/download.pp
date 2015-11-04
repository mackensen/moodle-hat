class moodle::download {
  vcsrepo { "${moodle::docroot}":
    ensure => present,
    provider => git,
    remote => "${::instance::remotename}",
    source => "${::instance::moodlesource}",
    revision => "${moodle::version}",
    group => vagrant,
    owner => vagrant,
  }
}
