class moodle::behat {
  exec { 'configure_composer':
    command => "composer config -g github-oauth.github.com ${moodle::oauth}",
    cwd => "${moodle::docroot}",
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
  }->
  exec { 'configure_behat':
    command => 'php admin/tool/behat/cli/init.php',
    environment => ["COMPOSER_HOME=/home/vagrant"],
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    cwd => "${moodle::docroot}",
  }

  file {"/var/www/behat":
    ensure => "directory",
    mode => 777,
  }->
  apache::vhost { 'behat.moodle.dev':
    port => '80',
    priority => 2,
    docroot => "/var/www/behat",
  }

  file { "/usr/local/bin/behat":
    source => 'puppet:///modules/moodle/behat.sh',
    mode => 755,
  }
}
