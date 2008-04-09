<?php
// Copyright (c) Isaac Gouy 2004, 2005
// FILE PATHS ///////////////////////////////////////////////////

define('LIB_PATH', '../../lib/');
define('LIB', '../../lib/lib.php');

define('DATA_PATH', '../../data/');
define('DESC_PATH', '../../desc/');
define('ABOUT_PATH', '../../about/');
define('ABOUT_PROGRAMS_PATH', '../../about/programs/');
define('CODE_PATH', '../../code/');
define('LOG_PATH', '../../code/');
define('MISC_PATH', '../../misc/');
define('DOWNLOAD_PATH', '../download/');
define('IMAGE_PATH', '../');
define('VERSION_PATH', '../../about/');

define('CORE_SITE', '../');
define('DEBIAN_SITE', '../debian/');
define('SANDBOX_SITE', '../sandbox/');
define('GREAT_SITE', './');
define('OLD_SITE', '../old/');
define('CONTESTS_SITE', '../contests/');


// CONSTANTS ///////////////////////////////////////////////////

define('REV_COLOR', 'navy');      // background color for banner etc
define('REV_COLOR_CORE', 'navy');           
define('REV_COLOR_GREAT', 'navy'); 
//define('REV_COLOR_GREAT', '#991900');         
define('REV_COLOR_SANDBOX', '#cc9900');
define('REV_COLOR_OLD', 'gray');   
define('REV_COLOR_CONTESTS', '#ff0000');    

define('DEV',FALSE);                 // show excluded languages, tests, programs, when TRUE
define('HOMEPAGE_ROWS',0);          // show 26 rows of languages on the homepage


define('SITE_NAME', 'great');
define('SITE_TITLE','The Computer Language Shootout Benchmarks');
define('BANNER_TITLE','The&nbsp;Computer&nbsp;Language&nbsp; <br/>Shootout&nbsp;Benchmarks');
define('FAQ_TITLE','Read the FAQ!');
define('BAR',' | ');
define('DASH',' - ');
define('BLANK','');
define('STARTUP','hello');    
define('SEPARATOR','-');             // Separator in file names

define('CHART_VSCALE',240);          
define('CHART_HSCALE',1);
define('CHART_V1',10);
define('CHART_V2',100);
define('CHART_V3',200);
 
define('TESTS_PHRASE', 'benchmark');              
define('LANGS_PHRASE','language');             
?>
