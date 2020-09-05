<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mysqli';
$CFG->dblibrary = 'native';
$CFG->dbhost    = 'localhost';
$CFG->dbname    = 'virtualclass';
$CFG->dbuser    = 'root';
$CFG->dbpass    = '';
$CFG->prefix    = 'mdlfx_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => '',
  'dbsocket' => '',
  'dbcollation' => 'utf8_general_ci',
);

// $CFG->wwwroot   = 'http://114.7.24.164/almazaya/almazaya_virtualclass';
$CFG->wwwroot   = 'http://virtualclass.almazayaislamicschool.sch.id';
// $CFG->dataroot  = 'C:\\xampp\\moodledata';
$CFG->dataroot  = 'C:\\xampp\\htdocs\\almazaya\\moodledata';
$CFG->admin     = 'admin';

$CFG->directorypermissions = 0777;

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
