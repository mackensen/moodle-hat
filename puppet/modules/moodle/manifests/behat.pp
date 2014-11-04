class moodle::behat {
  exec { 'configure_composer':
    command => "php composer.phar config -g github-oauth.github.com ${moodle::oauth}",
    cwd => "${moodle::docroot}",
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin',
  }->
  exec { 'configure_behat':
    command => 'php admin/tool/behat/cli/init.php',
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin',
    cwd => "${moodle::docroot}",
  }
}
