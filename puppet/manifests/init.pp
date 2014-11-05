node 'moodlehat' {
  include mysql::server, composer, selenium, moodle
}
