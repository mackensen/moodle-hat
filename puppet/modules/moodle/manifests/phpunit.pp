class moodle::phpunit {
  exec { 'configure_phpunit':
    command => 'php admin/tool/phpunit/cli/init.php',
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    cwd => "${moodle::docroot}",
  }
}
