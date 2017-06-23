class moodle::npm {
  package { ['nodejs']:
    ensure => 'present',
  }

  exec { 'grunt-cli':
    command => 'npm install -g grunt-cli',
    path => '/usr/bin:/usr/sbin',
    require => Package['nodejs'],
    creates => '/usr/local/bin/grunt',
  }

  exec { 'shifter':
    command => 'npm install -g shifter@0.4.6',
    path => '/usr/bin:/usr/sbin',
    require => Package['nodejs'],
    creates => '/usr/local/bin/shifter',
  }

  exec { 'npm_reload_shell':
    command => "bash -c 'source /home/vagrant/.bash_profile'",
    path => '/bin',
    require => [
      Exec['grunt-cli','shifter'],
      File['/home/vagrant/.bash_profile'],
    ],
  }

  exec { 'configure_npm':
    command => 'npm install',
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    require => [
      Package['nodejs'],
      Vcsrepo["${moodle::docroot}"],
    ],
    cwd => "${moodle::docroot}",
  }
}
