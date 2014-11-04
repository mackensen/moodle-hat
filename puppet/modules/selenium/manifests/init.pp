class selenium {
  package { ['openjdk-6-jre-headless', 'firefox', 'xvfb']:
    ensure => 'present',
  }

  file { "/opt/selenium":
    ensure => directory,
  }->
  file { "/opt/selenium/selenium-server-standalone.jar":
    source => 'puppet:///modules/selenium/selenium-server-standalone-2.44.0.jar',
  }->
  file { "/home/vagrant/.bash_profile":
    source => 'puppet:///modules/selenium/.bash_profile',
    owner => vagrant,
    group => vagrant,
  }
}
