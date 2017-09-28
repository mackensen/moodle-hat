class moodle::config {
  class { 'apache':
    default_vhost => false,
    mpm_module => false,
  }

  apache::vhost { 'local.moodle.test':
    port => '80',
    priority => 1,
    docroot => "${moodle::docroot}",
  }->
  class {'::apache::mod::prefork':
  }->
  class {'::apache::mod::php':
    package_name => 'libapache2-mod-php5.6',
    path => '/usr/lib/apache2/modules/libphp5.6.so',
  }

  file { ["${moodle::dataroot}", "${moodle::behatdataroot}", "${moodle::phpudataroot}"] :
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => 777,
  }
}
