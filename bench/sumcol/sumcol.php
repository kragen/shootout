#!/usr/local/bin/php -f
<?php
/*
 $Id: sumcol.php,v 1.1 2004-05-29 08:48:06 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
$fd = fopen("php://stdin", "r");
$sum = 0;
while (!feof ($fd)) { $sum += fgets($fd, 1024); }
fclose($fd);
print "$sum\n";
?>
