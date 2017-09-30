class selenium (
  $full_version = '2.53.1',
  $major_version = '2.53',
) {
  package { ['openjdk-8-jre-headless', 'xvfb']:
    ensure => 'present',
  }

  package { ['firefox']:
    ensure => 'purged',
    before => Exec['download-firefox'],
  }

  exec { "download-firefox":
    command => "curl http://ftp.mozilla.org/pub/firefox/releases/47.0.1/linux-x86_64/en-US/firefox-47.0.1.tar.bz2 | tar -xj",
    path => '/usr/bin:/bin',
    creates => "/opt/firefox",
    cwd => '/opt',
    before => File['/usr/bin/firefox']
  }

  file { "/usr/bin/firefox":
    ensure => 'link',
    target => '/opt/firefox/firefox',
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
