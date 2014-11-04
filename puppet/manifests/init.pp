node 'moodledev' {
  include mysql::server, composer, selenium, moodle
}
