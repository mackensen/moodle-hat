class moodle::config {
  class { 'apache':
    default_vhost => false,
    mpm_module => false,
  }

  apache::vhost { 'local.moodle.dev':
    port => '80',
    priority => 1,
    docroot => "${moodle::docroot}",
  }->
  class {'::apache::mod::prefork':
  }->
  class {'::apache::mod::php':
  }

  file { ["${moodle::dataroot}", "${moodle::behatdataroot}", "${moodle::phpudataroot}"] :
    ensure => 'directory',
    owner => 'www-data',
    group => 'vagrant',
    mode => 774,
  }
}
