class moodle (
  $version = "${::instance::moodleversion}",
  $docroot = '/var/www/moodle/htdocs',
  $dataroot = '/var/www/moodle/moodledata',
  $behatdataroot = '/var/www/moodle/behatdata',
  $phpudataroot = '/var/www/moodle/phpudata',
) {
  class { 'moodle::download': }->
  class { 'moodle::config': }->
  class { 'moodle::database': }->
  class { 'moodle::install': }->
  class { 'moodle::behat': }->
  class { 'moodle::phpunit': }->
  class { 'moodle::npm': }
}
