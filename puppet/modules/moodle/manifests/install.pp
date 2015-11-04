class moodle::install {
  Exec {
    path        => ['/bin','/usr/bin'],
    environment => ['HOME=/root'],
    provider    => 'shell',
    cwd         => "${moodle::docroot}",
  }

  package { ['php5-mysql', 'php5-curl', 'php5-gd', 'php5-xmlrpc', 'php5-intl']:
    ensure => "present"
  }->
  file { "${moodle::docroot}/config.php":
    source => 'puppet:///modules/moodle/config.php',
    group => "www-data",
  }->
  exec { "git_clean": 
    command => "/usr/bin/git clean -d -f -f",
  }->
  exec { "install_moodle":
    command => "/usr/bin/php admin/cli/install_database.php --fullname='MoodleHat: ${::instance::moodleversion}' --shortname='HAT: ${::instance::moodleversion}' --adminuser=admin --adminpass=P4ssw0rd! --agree-license",
  }
}
