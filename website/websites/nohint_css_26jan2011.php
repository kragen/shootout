<?php
ob_start('ob_gzhandler');
header('Pragma: public');
header('Cache-Control: public');
header('Expires: Mon, 14 Feb 2050 14:00:00 GMT');
header('Content-type: text/css');
readfile('nohint.css');
?>
