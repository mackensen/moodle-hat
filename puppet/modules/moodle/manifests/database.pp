class moodle::database {
  class { '::mysql::server':
    override_options => { 'mysqld' => { 'innodb_file_per_table' => 1, 'innodb_file_format' => 'barracuda', 'innodb_large_prefix' => '1', } },
    restart => true,
  }

  mysql::db { 'moodle':
    user => 'moodle',
    password => 'moodle',
    host => 'localhost',
    grant => ['all'],
    charset => 'utf8mb4',
    collate => 'utf8mb4_bin',
    before => Exec['configure_behat', 'configure_phpunit', 'install_moodle'],
  }

  class { 'postgresql::server': }

  postgresql::server::db { 'moodle':
    user => 'moodle',
    password => postgresql_password('moodle', 'moodle'),
  }
}
