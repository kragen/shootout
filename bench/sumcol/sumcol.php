#!/usr/bin/php -f
<?php
/*
 $Id: sumcol.php,v 1.2 2004-06-12 16:19:44 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
$fd = fopen("php://stdin", "r");
$sum = 0;
while (!feof ($fd)) { $sum += fgets($fd, 1024); }
fclose($fd);
print "$sum\n";
?>
