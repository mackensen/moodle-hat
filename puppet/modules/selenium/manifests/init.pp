class selenium {
  package { ['openjdk-6-jre-headless', 'firefox', 'xvfb']:
    ensure => 'present',
  }

  file { "/opt/selenium":
    ensure => directory,
  }->
  exec { "download-selenium":
    command => "wget -O /opt/selenium/selenium-server-standalone.jar http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar",
    path => '/usr/bin:/usr/sbin',
    creates => "/opt/selenium/selenium-server-standalone.jar",
  }->
  file { "/home/vagrant/.bash_profile":
    source => 'puppet:///modules/selenium/.bash_profile',
    owner => vagrant,
    group => vagrant,
  }
}
