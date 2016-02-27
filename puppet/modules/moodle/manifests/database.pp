class moodle::database {
  class { '::mysql::server':
    override_options => { 'mysqld' => { 'innodb_file_per_table' => 1, 'innodb_file_format' => 'barracuda' } },
    restart => true,
  }

  mysql::db { 'moodle':
    user => 'moodle',
    password => 'moodle',
    host => 'localhost',
    grant => ['all'],
    charset => 'utf8',
    collate => 'utf8_bin',
    before => Exec['configure_behat', 'configure_phpunit', 'install_moodle'],
  }
}
