class moodle::behat {
  package { ['curl', 'openjdk-6-jre-headless', 'firefox', 'xvfb']:
    ensure => 'present',
  }

  exec { 'composer':
    command => 'curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer',
    path => '/usr/bin:/usr/sbin',
    require => Package['curl'],
    creates => '/usr/local/bin/composer',
  }->
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

  file { "/opt/selenium":
    ensure => directory,
  }->
  file { "/opt/selenium/selenium-server-standalone.jar":
    source => 'puppet:///modules/moodle/selenium-server-standalone-2.44.0.jar',
  }->
  file { "/home/vagrant/.bash_profile":
    source => 'puppet:///modules/moodle/.bash_profile',
    owner => vagrant,
    group => vagrant,
  }
}
