class moodle::npm {
  package { ['npm','nodejs-legacy']:
    ensure => 'present',
  }

  exec { 'grunt-cli':
    command => 'npm install -g grunt-cli',
    path => '/usr/bin:/usr/sbin',
    require => Package['npm'],
    creates => '/usr/local/bin/grunt',
  }

  exec { 'shifter':
    command => 'npm install -g shifter@0.4.6',
    path => '/usr/bin:/usr/sbin',
    require => Package['npm'],
    creates => '/usr/local/bin/shifter',
  }

  exec { 'npm_reload_shell':
    command => "bash -c 'source /home/vagrant/.bash_profile'",
    path => '/bin',
    require => Exec['grunt-cli','shifter'],
  }

  exec { 'configure_npm':
    command => 'test -f package.json && npm install; true',
    path => '/usr/bin:/usr/sbin:/usr/local/bin',
    require => Package['npm'],
    cwd => "${moodle::docroot}",
  }
}
