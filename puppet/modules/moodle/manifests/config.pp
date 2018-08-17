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
  apache::fastcgi::server { 'fpm':
    host       => '127.0.0.1:9000',
    timeout    => 15,
    flush      => false,
    faux_path  => '/var/www/php.fcgi',
    fcgi_alias => '/php.fcgi',
    file_type  => 'application/x-httpd-php'
  }

  file { ["${moodle::dataroot}", "${moodle::behatdataroot}", "${moodle::phpudataroot}"] :
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => 777,
  }
}
