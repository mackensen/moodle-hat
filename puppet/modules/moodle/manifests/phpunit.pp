class moodle::phpunit {
  exec { 'configure_phpunit':
    command => 'php admin/tool/phpunit/cli/init.php',
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    cwd => "${moodle::docroot}",
  }
  class { 'locales':
    default_locale  => 'en_US.UTF-8',
    locales => ['en_US.UTF-8 UTF-8', 'en_AU.UTF-8 UTF-8'],
  }
}
