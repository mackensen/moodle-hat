class vim {
  package { ['vim']:
    ensure => 'present',
  }

  file { "/home/vagrant/.vimrc":
    source => 'puppet:///modules/vim/.vimrc',
    owner => vagrant,
    group => vagrant,
  }

  exec { "set-vim-default":
    command => 'git config --global core.editor "vim"',
    path => '/usr/bin:/usr/sbin',
    environment => ['HOME=/home/vagrant'],
    user => 'vagrant',
    require => Package['vim'],
  }
}
