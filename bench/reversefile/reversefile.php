#!/usr/bin/php4 -f
<?php
/*
 $Id: reversefile.php,v 1.1 2004-05-28 22:25:05 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
$fd = fopen("php://stdin", "r");
$lines = array();
while (!feof ($fd)) { array_push($lines, fgets($fd, 4096)); }
fclose($fd);
foreach (array_reverse($lines) as $line) print $line;
?>
