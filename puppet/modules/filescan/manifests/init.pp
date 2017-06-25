class filescan {
  vcsrepo { "/var/www/filescan":
    ensure => present,
    provider => git,
    source => 'https://github.com/Swarthmore/filescan-server',
    revision => 'master',
    group => www-data,
    owner => www-data,
  }

  exec { 'install-filescan':
    command => 'npm install',
    path => '/usr/bin',
    cwd => '/var/www/filescan',
    require => Vcsrepo['/var/www/filescan'],
  }

  exec { 'install-pm2':
    command => 'npm install -g grunt-cli',
    path => '/usr/bin',
    require => Package['nodejs'],
    creates => '/usr/bin/pm2',
  }

  exec { 'run-filescan':
    command => 'pm2 start index.js -s',
    cwd => '/var/www/filescan',
    path => '/usr/bin',
    require => [
      Exec['install-pm2'],
      Exec['install-filescan'],
    ]
  }
}
