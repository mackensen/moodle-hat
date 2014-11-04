class moodle::database {
  mysql::db { 'moodle':
    user => 'moodle',
    password => 'moodle',
    host => 'localhost',
    grant => ['all'],
    charset => 'utf8',
    collate => 'utf8_unicode_ci',
  }
}
