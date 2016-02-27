class selenium (
  $full_version = '2.46.0',
  $major_version = '2.46',
) {
  package { ['openjdk-6-jre-headless', 'xvfb']:
    ensure => 'present',
  }

  package { ['firefox']:
    ensure => '28.0+build2-0ubuntu2',
  }

  file { "/opt/selenium":
    ensure => directory,
  }

  exec { "download-selenium":
    command => "wget -O /opt/selenium/selenium-server-standalone.jar http://selenium-release.storage.googleapis.com/$major_version/selenium-server-standalone-$full_version.jar",
    path => '/usr/bin:/usr/sbin',
    creates => "/opt/selenium/selenium-server-standalone.jar",
    require => File['/opt/selenium'],
  }

  file { '/home/vagrant/.bash_profile':
    source => 'puppet:///modules/selenium/.bash_profile',
    owner => vagrant,
    group => vagrant,
  }
}
