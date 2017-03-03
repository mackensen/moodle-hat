class moodle::cron {
  cron { 'moodle':
    command => "/usr/bin/php ${moodle::docroot}/admin/cli/cron.php >> /var/www/cron/`date +\%Y\%m\%d`-cron.log 2>&1",
    user => 'www-data',
    minute => '*/1',
    require => [
      Exec['install_moodle'],
      File['/var/www/cron'],
    ]
  }

  file { '/var/www/cron':
    ensure => 'directory',
    mode => 777,
  }

  apache::vhost { 'cron.moodle.dev':
    port => '80',
    priority => 2,
    docroot => "/var/www/cron",
    require => File['/var/www/cron'],
  }
}
