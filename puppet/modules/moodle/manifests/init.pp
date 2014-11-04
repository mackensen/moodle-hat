class moodle (
  $version = 'master',
  $docroot = '/var/www/moodle/htdocs',
  $dataroot = '/var/www/moodle/moodledata',
  $behatdataroot = '/var/www/moodle/behatdata',
  $oauth = 'YOUR TOKEN HERE',
) {
  class { 'moodle::download': }->
  class { 'moodle::config': }->
  class { 'moodle::database': }->
  class { 'moodle::install': }->
  class { 'moodle::behat': }
}
