<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mysqli';
$CFG->dblibrary = 'native';
$CFG->dbhost    = 'localhost';
$CFG->dbname    = 'moodle';
$CFG->dbuser    = 'moodle';
$CFG->dbpass    = 'moodle';
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => '',
  'dbsocket' => '',
);

$CFG->wwwroot   = 'http://local.moodle.dev';
$CFG->dataroot  = '/var/www/moodle/moodledata';
$CFG->admin     = 'admin';

// Behat configuration.
$CFG->behat_dataroot = '/var/www/moodle/behatdata';
$CFG->behat_prefix = 'behat_';
$CFG->behat_wwwroot = 'http://localhost';
$CFG->behat_faildump_path = '/var/www/behat';

// PHPUnit configuration.
$CFG->phpunit_prefix = 'phpu_';
$CFG->phpunit_dataroot = '/var/www/moodle/phpudata';

$CFG->directorypermissions = 02777;


// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
require_once(dirname(__FILE__) . '/lib/setup.php');
